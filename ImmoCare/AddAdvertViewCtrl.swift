//
//  PostAnnounceViewCtrl.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 07/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class AddAdvertViewCtrl: UIViewController {
    
    // container post
    var container: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 100
        let my_view = UIView(frame:CGRect(x:0, y:0, width:screenWidth, height:screenHeight))
        my_view.backgroundColor = UIColor(red:1, green:1, blue:1, alpha: 1.0)
        my_view.contentMode = .scaleAspectFit
        return my_view
    }()
    
    // title
    lazy var titleField: MyTextField = {
        let content = MyTextField(frame:CGRect(x:10, y:50, width:250, height:20))
        content.backgroundColor = .white
        content.keyboardType = .emailAddress
        content.font = UIFont.systemFont(ofSize:16)
        content.leftViewMode = .always
        content.autocorrectionType = .no
        content.spellCheckingType = .no
        content.leftView = self.getLeftView(labelText: "Titre")
        return content
    }()
    
    // body label
    lazy var labelBody: UILabel = {
        let content = UILabel(frame:CGRect(x:0, y:80, width:90, height:20))
        content.backgroundColor = .white
        content.font = UIFont.systemFont(ofSize:16)
        content.isUserInteractionEnabled = false
        content.text = "Description"
        content.textAlignment = .right
        return content
    }()
    
    // body
    lazy var body: UITextView = {
        let content = UITextView(frame:CGRect(x:95, y:75, width:250, height:85))
        content.isSecureTextEntry = true
        content.backgroundColor = .white
        content.keyboardType = .default
        content.font = UIFont.systemFont(ofSize:16)
        content.autocorrectionType = .no
        content.spellCheckingType = .no
        return content
    }()
    
    // photo label
    lazy var labelPhoto: UILabel = {
        let content = UILabel(frame:CGRect(x:0, y:170, width:90, height:20))
        content.backgroundColor = .white
        content.font = UIFont.systemFont(ofSize:16)
        content.isUserInteractionEnabled = false
        content.text = "Photos"
        content.textAlignment = .right
        return content
    }()
    
    
    // set left container
    func getLeftView(labelText: String) -> UILabel
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        label.font = UIFont.systemFont(ofSize:16)
        label.textAlignment = .right
        label.text = labelText
        return label
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 100
        
        // set color background
        self.view.backgroundColor = UIColor(red:1, green:1, blue:1, alpha: 1.0)
        
        // set container
        
        self.view.addSubview(self.container)
        
        // set logo circle in container
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 14))
        title.contentMode = .scaleAspectFill
        title.textAlignment = .center
        title.text = "Nouvelle Annonce"
        self.container.addSubview(title)
        
        // set email textfield
        self.container.addSubview(self.titleField)
        
        
        // set label textfield
        self.container.addSubview(self.labelBody)
        
        // set body textfield
        self.container.addSubview(self.body)
        
        // set photo textfield
        self.container.addSubview(self.labelPhoto)
        
        // set btn post
        let btnPost = UIButton(frame:CGRect(x:40, y:(screenHeight-100), width:280, height:40))
        btnPost.setBackgroundImage(UIImage(color:UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)), for: .normal)
        btnPost.setTitle("POSTER", for: .normal)
        btnPost.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        self.container.addSubview(btnPost)
        
        let btnList = UIButton(frame:CGRect(x:40, y:screenHeight-50, width:280, height:40))
        btnList.setBackgroundImage(UIImage(color:UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)), for: .normal)
        btnList.setTitle("LISTE", for: .normal)
        btnList.addTarget(self, action: #selector(listAction), for: .touchUpInside)
        self.container.addSubview(btnList)
        
        
        // set position container on center
        self.container.center = self.view.center
        
        //show keyboard
        self.titleField.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listAction(){
        self.present(ListAdvertsViewCtrl(), animated: true, completion:nil)
    }
    
    func postAction()
    {
        if(titleField.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre titre.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if(body.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre description.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else{
            APIManager.sharedInstance.addAdvert(_title: titleField.text!, _body: body.text!, onSuccess: { json in
                if let string = json.rawString() {
                    print(string)
                }
                DispatchQueue.main.async(execute: {
                    
                    
                    if(json["statusCode"] != 200){
                        let alertController = UIAlertController(title: "Oops!", message: "Vous n'etes pas connecté", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion:nil)
                    } else {
                        let alertController = UIAlertController(title: "Super!", message: String(describing: json["message"]), preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion:nil)
                    }
                })
            }, onFailure: { error in
                DispatchQueue.main.async(execute: {
                    print(error)
                    let alertController = UIAlertController(title: "Error!", message: String(describing: error), preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
                })
            })
        }
    }
    
    func registerAction()
    {
        self.present(RegisterViewController(), animated: true, completion: nil)
    }
}
