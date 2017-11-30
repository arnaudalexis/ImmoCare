//
//  RegisterViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 11/05/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    
    
    var contentViewController = ["vacancier", "bénévole", "auto-entrepreneur"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if(emailField.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre adresse mail.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if(nameField.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre nom.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if(passwordField.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre mot de passe.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if(firstNameField.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre prénom.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if(!isValidEmailAddress(emailAddressString: emailField.text!)){
            let alertController = UIAlertController(title: "Oops!", message: "Votre adresse mail est invalide.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else{
            APIManager.sharedInstance.registerUser(_email: emailField.text!, _password: passwordField.text!, _name: nameField.text!, _firstName: firstNameField.text!, _city: "", _country: "", onSuccess: { json in
                if let string = json.rawString() {
                    print(string)
                }
                DispatchQueue.main.async(execute: {
                    
                    
                    if(json["statusCode"] != 200){
                        let alertController = UIAlertController(title: "Oops!", message: "Cet utilisateur existe déjà.", preferredStyle: .alert)
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
            })        }
        
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}
