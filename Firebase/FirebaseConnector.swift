//
//  FirebaseConnector.swift
//  Locations
//
//  Created by Ignat Urbanovich on 3.01.22.
//


import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore
import UIKit

class FirebaseConnector {
    
    
    static var shared: FirebaseConnector = {
        let instance = FirebaseConnector()

        return instance
    }()
    
    private func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }

    func getImage(imgName: String, completion: @escaping (UIImage?)->Void) {
        let storage = Storage.storage()
        let reference  = storage.reference()
        let pathRef = reference.child("Locations")
        
        var image: UIImage?
        
        let fileRef = pathRef.child(imgName + ".jpeg")
        fileRef.getData(maxSize: 5000*5000, completion: { data, error in
            guard error == nil else {return}
            
            image = UIImage(data: data!)!
            completion(image)
        })
         
    }
    
    func setImage(imgName: String, img: UIImage) {
        let storage = Storage.storage()
        let reference  = storage.reference()
        let pathRef = reference.child("driftfiles/Locations")
        
        
        
        let fileRef = pathRef.child(imgName + ".jpeg")
        fileRef.putData(img.jpegData(compressionQuality: 1)!)
    }
    
    func getName(docName: String, completion: @escaping (String?)->Void) {
        let db = configureFB()
        db.collection("Locations").document("000000001").getDocument(completion: {(document, error) in
            guard error == nil else {completion(nil); return}
            
            completion(document?.get("name") as? String)
        })
    }
    
    func setName(docName: String, name: String) {
        let db = configureFB()
        db.collection("Locations").document(docName).setData(["name":name])
    }

}
