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
            guard error == nil else {completion(nil); return}
            
            image = UIImage(data: data!)!
            completion(image)
        })
         
    }
    
    func saveImage(imgName: String, img: UIImage) {
        let storage = Storage.storage()
        let reference  = storage.reference()
        let pathRef = reference.child("Locations")
        
        let compr = Float(1/(img.size.width/1000))
        
        let fileRef = pathRef.child(imgName + ".jpeg")
        fileRef.putData(img.jpegData(compressionQuality: CGFloat(compr))!)
    }
    
    func getLocation(docName: String, completion: @escaping (String?, String?)->Void) {
        let db = configureFB()
        let collection = db.collection("Locations")
        let doc = collection.document(docName)
        doc.getDocument() {(document, error) in
            print(document)
            guard error == nil else {completion(nil, nil); return}
            completion(document?.get("name") as? String, document?.get("img") as? String)
        }
    }
    
    func getLocations(completion: @escaping ([Location])->Void) {
        let db = configureFB()
        let collection = db.collection("Locations")
        collection.getDocuments(){ snapshot, error in
            guard let snapshot = snapshot else {completion([]); return}
            var locations: [Location] = []
            for doc in snapshot.documents {
                locations.append(Location(name: doc.get("name") as? String ?? "", imgName: doc.get("img") as? String))
            }
            completion(locations)
        }
    }
    
    func saveLocation(location: Location) {
        let db = configureFB()
        if let imgName = location.imgName {
            db.collection("Locations").document().setData(["name":location.name, "img":imgName])
        } else {
            db.collection("Locations").document().setData(["name":location.name])
            
        }
    }
    
}
