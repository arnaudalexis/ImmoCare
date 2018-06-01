//
//  SecondViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 10/05/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //show keyboard
        self.emailField.becomeFirstResponder()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any)
    {
        if(emailField.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre adresse mail.", preferredStyle: .alert)
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
        else{
            APIManager.sharedInstance.loginUser(_email: emailField.text!, _password: passwordField.text!, onSuccess: { json in
                if let string = json.rawString() {
                    print(string)
                }
                DispatchQueue.main.async(execute: {
                    
                
                if(json["statusCode"] != 200){
                    let alertController = UIAlertController(title: "Oops!", message: "Utilisateur introuvable", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
                } else {
                    let user = User.sharedInstanceWith(json: json["result"])
                    print(user.name ?? "name");
                    self.performSegue(withIdentifier: "profileSegue", sender: self)

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
}
