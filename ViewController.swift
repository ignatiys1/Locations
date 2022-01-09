//
//  ViewController.swift
//  Locations
//
//  Created by Ignat Urbanovich on 3.01.22.
//

import UIKit

class ViewController: UIViewController {
    
    //var mainLabel = UILabel(text: "Локации", font: .avenirNext20, textAlignment: .center)
    
    var widthCoef: CGFloat = 1
    var heightCoef: CGFloat = 1
    var topPadding = CGFloat(50)
    
    lazy var mainLabel: UILabel =  {
        UILabel()
    }()
    var labelImg = UIImageView()
    var mainTextField = UITextField()
    var addButton = UIButton()
    
    var cardWithImages: UIView?
    
    var imagePicker = UIImagePickerController()
    
    var locations: [Location] = []
    var selectedIndex: Int?
    var second = false
    
    var refreshControl: UIRefreshControl?
    var refreshAlert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FirebaseConnector.shared.getLocations() { locationsFromFS in
            self.locations = locationsFromFS
            self.reloadImages()
        }
        
        widthCoef = CGFloat(view.frame.width/750)
        heightCoef = CGFloat(view.frame.height/1702)
        
        view.backgroundColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
        
        addButton.addTarget(self, action: #selector(self.addAction), for: .touchUpInside)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        
        setVectorsFromFigma()
        setLabelFromFigma()
        setCardFromFigma()
    }
    
}

//MARK: Figma

extension ViewController {
    
    func setVectorsFromFigma() {
        let image = UIImage(named: "Vectors")!
        
        labelImg.frame.size = image.size
        labelImg.image = image
        //labelImg.backgroundColor = .red
        
        view.addSubview(labelImg)
        labelImg.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 89*heightCoef+topPadding),
            labelImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 156*widthCoef),
            labelImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -128.5*widthCoef),
            labelImg.heightAnchor.constraint(equalToConstant: 85.5*heightCoef)
            //labelImg.widthAnchor.constraint(equalToConstant: 465.6)
        ])
        
    }
    
    func setLabelFromFigma() {
        mainLabel.frame = CGRect(x: 0, y: 0, width: 460*widthCoef, height: 49*heightCoef)
        
        mainLabel.textColor = UIColor(red: 0.129, green: 0.126, blue: 0.125, alpha: 1)
        mainLabel.font = UIFont(name: "Oswald-Light", size: 50*heightCoef)
        mainLabel.isUserInteractionEnabled = true
        mainLabel.tag = 1
        
        let tapPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        mainLabel.addGestureRecognizer(tapPressRecognizer)
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 0.88
        paragraphStyle.alignment = .center
        
        
        
        mainLabel.attributedText = NSMutableAttributedString(string: "ЛОКАЦИИ", attributes: [NSAttributedString.Key.kern: 2, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.heightAnchor.constraint(equalToConstant: 49*heightCoef).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145*widthCoef).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -145*widthCoef).isActive = true
        mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 107*heightCoef+topPadding).isActive = true
        
    }
    
    func setCardFromFigma() {
        let parent = setCardBackgroung()

        let card = setCardFrame(for: parent)
        cardWithImages = card
        setFieldTo(card: card)
        setButtonTo(card: card)
        
        setImageFieldsTo(card: card)
    }
    
    fileprivate func setCardBackgroung() -> UIView{
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 750*widthCoef, height: 615*heightCoef)
        view.backgroundColor = .none
        
        let shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 33)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.38, green: 0.417, blue: 0.415, alpha: 0.17).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 8
        layer0.shadowOffset = CGSize(width: -10, height: 16)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        
        let shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)
        
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        
        shapes.layer.cornerRadius = 33
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 750*widthCoef).isActive = true
        view.heightAnchor.constraint(equalToConstant: 615*heightCoef).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 227*heightCoef+topPadding).isActive = true
        
        return view
    }
    
    fileprivate func setCardFrame(for parent: UIView) -> UIView {
        
        
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 690*widthCoef, height: 550*heightCoef)
        view.backgroundColor = .none
        
        
        view.layer.backgroundColor = UIColor(red: 0.929, green: 0.953, blue: 0.957, alpha: 1).cgColor
        view.layer.cornerRadius = 23
        
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 690*widthCoef).isActive = true
        view.heightAnchor.constraint(equalToConstant: 550*heightCoef).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 30*widthCoef).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 33*heightCoef).isActive = true
        
        
        return view
        
    }
    
    fileprivate func setFieldTo(card: UIView) {
        mainTextField.frame = CGRect(x: 0, y: 0, width: 652*widthCoef, height: 40*heightCoef)
        mainTextField.backgroundColor = .none
        
        mainTextField.textColor = UIColor(red: 0.525, green: 0.58, blue: 0.584, alpha: 1)
        mainTextField.font = UIFont(name: "Ubuntu", size: 38*heightCoef)
        mainTextField.placeholder = "Название локации"
        
        self.view.addSubview(mainTextField)
        mainTextField.translatesAutoresizingMaskIntoConstraints = false
        mainTextField.widthAnchor.constraint(equalToConstant: 652*widthCoef).isActive = true
        mainTextField.heightAnchor.constraint(equalToConstant: 40*heightCoef).isActive = true
        mainTextField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 27*widthCoef).isActive = true
        mainTextField.topAnchor.constraint(equalTo: card.topAnchor, constant: 18*heightCoef).isActive = true
        
        
        
        
    }
    
    fileprivate func setButtonTo(card: UIView) {
        
        addButton.frame = CGRect(x: 0, y: 0, width: 50*widthCoef, height: 50*heightCoef)
        addButton.backgroundColor = .none
        let image = UIImage(named: "addButton")!
        addButton.setImage(image, for: .normal)
        
        
        self.view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.widthAnchor.constraint(equalToConstant: 50*widthCoef).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50*heightCoef).isActive = true
        addButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20*widthCoef).isActive = true
        addButton.topAnchor.constraint(equalTo: card.topAnchor, constant: 20*heightCoef).isActive = true
        
        
    }
    
    fileprivate func setImageFieldsTo(card: UIView, indexToHighlight: Int? = nil) {
        for (index,location) in locations.enumerated() {
            if location.image == nil { return} else {
                location.image!.removeFromSuperview()
                location.image!.isUserInteractionEnabled = true
                
                let tapPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
                location.image!.addGestureRecognizer(tapPressRecognizer)
               
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.imageLongTapped(sender:)))
                longPressRecognizer.minimumPressDuration = 0.5
                location.image!.addGestureRecognizer(longPressRecognizer)
                
                var horizontalPosition: CGFloat = 20*widthCoef
                switch ((index+1)%3) {
                case 0: horizontalPosition += (203*widthCoef+20*widthCoef)*2
                case 2: horizontalPosition += (203*widthCoef+20*widthCoef)*1
                case 1: horizontalPosition += (203*widthCoef+20*widthCoef)*0
                default: horizontalPosition += 0
                }
                
                var verticalPosition: CGFloat = 90*heightCoef
                switch ((index+1)%6) {
                case 0: verticalPosition += 203*widthCoef+20*widthCoef
                case ...3: verticalPosition += 0
                default: verticalPosition += 203*widthCoef+20*widthCoef
                }
                location.image!.alpha = 1
                
                if let indexToHighlight = indexToHighlight {
                    if index == indexToHighlight {
                        
                        location.image!.frame = CGRect(x: 0, y: 0, width: 203*widthCoef, height: 203*widthCoef)
                        
                        self.view.addSubview(location.image!)
                        location.image!.translatesAutoresizingMaskIntoConstraints = false
                        location.image!.widthAnchor.constraint(equalToConstant: 203*widthCoef).isActive = true
                        location.image!.heightAnchor.constraint(equalToConstant: 203*widthCoef).isActive = true
                        location.image!.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: horizontalPosition).isActive = true
                        location.image!.topAnchor.constraint(equalTo: card.topAnchor, constant: verticalPosition-(15*heightCoef)).isActive = true
                        
                        continue
                    } else {
                        location.image!.alpha = 0.5
                    }
                }
                
                
                
                self.view.addSubview(location.image!)
                location.image!.translatesAutoresizingMaskIntoConstraints = false
                location.image!.widthAnchor.constraint(equalToConstant: 203*widthCoef).isActive = true
                location.image!.heightAnchor.constraint(equalToConstant: 203*widthCoef).isActive = true
                location.image!.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: horizontalPosition).isActive = true
                location.image!.topAnchor.constraint(equalTo: card.topAnchor, constant: verticalPosition).isActive = true
            }
        }
    }
    
}


//MARK: Constraints

extension ViewController {
    
    func setConstraints() {
        view.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 145),
            mainLabel.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        
        
    }
    
}


//MARK: ImagePicker Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        
        let newName = mainTextField.text!
        mainTextField.text = ""
        DispatchQueue.global(qos: .userInteractive).async {
            if let image = image {
                let imageName = "\(NSDate())"
                FirebaseConnector.shared.saveLocation(location: Location(name: newName, imgName: imageName))
                FirebaseConnector.shared.saveImage(imgName: imageName, img: image)
            }
        }
        
        if let image = image {
            locations.append(Location(name: newName, img: UIImageView(image: image, widthCoef: widthCoef)))
            reloadImages(withoutUploading: true)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
}


//MARK: Actions
extension ViewController {

    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.view!.tag == mainLabel.tag {
            refresh(sender: self)
        } else {
            let imageView = sender.view as! UIImageView
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
            swipe.direction = .down
            newImageView.addGestureRecognizer(swipe)
            self.view.addSubview(newImageView)
        }
    }

    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    @objc func addAction(button: UIButton) {
        if mainTextField.text == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Необходимо ввести название", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imageLongTapped(sender: UIGestureRecognizer) {
        if !second {
            second = true
            for (index, location) in locations.enumerated() {
                if location.image == sender.view {
                    if selectedIndex == index {
                        mainTextField.text = ""
                        self.selectedIndex = nil
                        setImageFieldsTo(card: cardWithImages!)
                    } else {
                        mainTextField.text = location.name
                        selectedIndex = index
                        setImageFieldsTo(card: cardWithImages!, indexToHighlight: index)
                    }
                    break
                }
            }
        } else {
            second = false
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        print("refreshStart")
        refreshAlert = UIAlertController(title: "Обновление...", message: nil, preferredStyle: .actionSheet)
        present(refreshAlert!, animated: true, completion: nil)
        refreshBegin(newtext: "Refresh",
                     refreshEnd: {(x:Int) -> () in
            
            self.refreshControl?.endRefreshing()
            guard let refreshAlert = self.refreshAlert else {return}
            refreshAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd: @escaping (Int) -> ()) {
        DispatchQueue.global(qos: .default).async(execute: {
            print("refreshing")
            sleep(2)
            
            self.reloadImages()
            
            DispatchQueue.main.async(execute: {
                refreshEnd(0)
            })
        })
    }
}

//MARK: functions
extension ViewController {
    
    func reloadImages(withoutUploading: Bool = false) {
        var count = 0
        if withoutUploading {
            self.setImageFieldsTo(card: self.cardWithImages!)
        } else {
            for (index,location) in locations.enumerated() {
                guard let imgName = location.imgName else {return}
                FirebaseConnector.shared.getImage(imgName: imgName) { image in
                    count += 1
                    if imgName == self.locations[index].imgName {
                        guard let image = image else {
                            return
                        }
                        location.image = UIImageView(image: image, widthCoef: self.widthCoef)
                    }
                    
                    self.setImageFieldsTo(card: self.cardWithImages ?? self.view)
                }
                
                
            }
        }
    }
    
}
