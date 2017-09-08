//
//  RegisterViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 11/05/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // container register
    var container: UIView = {
        let my_view = UIView(frame:CGRect(x:0, y:0, width:300, height:420))
        my_view.backgroundColor = UIColor(red:0.16, green:0.34, blue:0.56, alpha: 1.0)
        return my_view
    }()
    
    // username
    lazy var userName: MyTextField = {
        let name = MyTextField(frame:CGRect(x:10, y:100, width:280, height:40))
        name.backgroundColor = .white
        name.placeholder = "Nom"
        name.font = UIFont.systemFont(ofSize:14)
        name.leftViewMode = .always
        name.leftView = self.getLeftView(image: #imageLiteral(resourceName: "usernameIcon"))
        return name
    }()
    
    // email
    lazy var email: MyTextField = {
        let lemail = MyTextField(frame:CGRect(x:10, y:160, width:280, height:40))
        lemail.backgroundColor = .white
        lemail.placeholder = "Email"
        lemail.keyboardType = .emailAddress
        lemail.font = UIFont.systemFont(ofSize:14)
        lemail.leftViewMode = .always
        lemail.leftView = self.getLeftView(image: #imageLiteral(resourceName: "mailIcon"))
        return lemail
    }()
    
    // password
    lazy var password: MyTextField = {
        let pwd = MyTextField(frame:CGRect(x:10, y:220, width:280, height:40))
        pwd.isSecureTextEntry = true
        pwd.backgroundColor = .white
        pwd.placeholder = "Mot de passe"
        pwd.font = UIFont.systemFont(ofSize:14)
        pwd.leftViewMode = .always
        pwd.leftView = self.getLeftView(image: #imageLiteral(resourceName: "pwdIcon"))
        return pwd
    }()
    
    lazy var contentPicker:MyTextField = {
        let lpicker = MyTextField(frame:CGRect(x:10, y:280, width:280, height:40))
        lpicker.backgroundColor = .white
        lpicker.placeholder = "Rôle"
        lpicker.font = UIFont.systemFont(ofSize:14)
        lpicker.leftViewMode = .always
        lpicker.leftView = self.getLeftView(image: #imageLiteral(resourceName: "usernameIcon"))
        return lpicker
    }()
    
    var contentViewController = ["vacancier", "bénévole", "auto-entrepreneur"]

    
    // set left container for pwd and username
    func getLeftView(image:UIImage) -> UIView
    {
        let leftV = UIView(frame:CGRect(x:0, y:0, width:40, height:40))
        let img = UIImageView(frame:CGRect(x:5, y:5, width:30, height:30))
        img.image = image
        leftV.backgroundColor = UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)
        leftV.addSubview(img)
        return leftV
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0.49, green:0.73, blue:0.71, alpha: 1.0)
        
        // set logo circle in container
        let circleImg = UIImageView(frame:CGRect(x:self.container.frame.midX - 30, y:10, width:60, height:60))
        circleImg.backgroundColor = .white
        circleImg.layer.cornerRadius = 30
        circleImg.clipsToBounds = true
        circleImg.image = #imageLiteral(resourceName: "registerIcon")
        self.container.addSubview(circleImg)
        
        // set container
        self.view.addSubview(self.container)
        
        // set email textfield
        self.container.addSubview(self.email)
        
        // set name textfield
        self.container.addSubview(self.userName)
        
        // set password textfield
        self.container.addSubview(self.password)
        
        // set textfield for picker
        self.container.addSubview(self.contentPicker)
        
        // set picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        contentPicker.inputView = pickerView
        
        // set button register
        let btnRegister = UIButton(frame:CGRect(x:10, y:340, width:280, height:40))
        btnRegister.setBackgroundImage(UIImage(color:UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)), for: .normal)
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnRegister.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        self.container.addSubview(btnRegister)
        
        // set button login
        let btnLogin = UIButton(frame:CGRect(x:230, y:380, width:70, height:40))
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnLogin.setTitleColor(UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0), for: .highlighted)
        btnLogin.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.container.addSubview(btnLogin)
        
        // set position container on center
        self.container.center = self.view.center
    }
    
    // set number of component in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // set number of line in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentViewController.count
    }
    
    // set title for each line
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentViewController[row]
    }
    
    // update textfield according to the picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        contentPicker.text = contentViewController[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerAction()
    {
//        if(userName.text?.characters.count == 0){
//            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre nom.", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//            alertController.addAction(cancelAction)
//            let OKAction = UIAlertAction(title: "OK", style: .default)
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion:nil)
//        }
        if(email.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre adresse mail.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if(password.text?.characters.count == 0){
            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre mot de passe.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
//        else if(contentPicker.text?.characters.count == 0){
//            let alertController = UIAlertController(title: "Oops!", message: "Rentrez votre rôle.", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//            alertController.addAction(cancelAction)
//            let OKAction = UIAlertAction(title: "OK", style: .default)
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion:nil)
//        }
        else{
            APIManager.sharedInstance.registerUser(_email: email.text!, _password: password.text!, onSuccess: { json in
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
    
    func loginAction()
    {
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}
