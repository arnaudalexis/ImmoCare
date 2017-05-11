//
//  SecondViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 10/05/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // container login
    var container: UIView = {
        let my_view = UIView(frame:CGRect(x:0, y:0, width:300, height:300))
        my_view.backgroundColor = UIColor(red:0.26, green:0.72, blue:0.72, alpha: 1.0)
        return my_view
    }()
    
    // email
    lazy var email: MyTextField = {
        let lemail = MyTextField(frame:CGRect(x:10, y:100, width:280, height:40))
        lemail.backgroundColor = .white
        lemail.placeholder = "Email"
        lemail.keyboardType = .emailAddress
        lemail.font = UIFont.systemFont(ofSize:14)
        lemail.leftViewMode = .always
        lemail.leftView = self.getLeftView(image: #imageLiteral(resourceName: "usernameIcon"))
        return lemail
    }()

    // password
    lazy var password: MyTextField = {
        let pwd = MyTextField(frame:CGRect(x:10, y:160, width:280, height:40))
        pwd.backgroundColor = .white
        pwd.placeholder = "Password"
        pwd.font = UIFont.systemFont(ofSize:14)
        pwd.leftViewMode = .always
        pwd.leftView = self.getLeftView(image: #imageLiteral(resourceName: "pwdIcon"))
        return pwd
    }()
    
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
        
        // set color background
        self.view.backgroundColor = UIColor(red:0.75, green:0.73, blue:0.79, alpha: 1.0)
        
        // set container
        self.view.addSubview(self.container)
        
        // set logo circle in container
        let circleImg = UIImageView(frame:CGRect(x:self.container.frame.midX - 30, y:10, width:60, height:60))
        circleImg.backgroundColor = .white
        circleImg.layer.cornerRadius = 30
        circleImg.clipsToBounds = true
        circleImg.image = #imageLiteral(resourceName: "loginIcon")
        self.container.addSubview(circleImg)
        
        // set email textfield
        self.container.addSubview(self.email)
        
        // set password textfield
        self.container.addSubview(self.password)
        
        // set btn login
        let btnLogin = UIButton(frame:CGRect(x:10, y:210, width:280, height:40))
        btnLogin.setBackgroundImage(UIImage(color:UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)), for: .normal)
        btnLogin.setTitle("LOGIN", for: .normal)
        btnLogin.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.container.addSubview(btnLogin)
        
        // set btn forgot password
        let btnForgotPwd = UIButton(frame:CGRect(x:10, y:260, width:150, height:40))
        btnForgotPwd.setTitle("Forget Password", for: .normal)
        btnForgotPwd.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnForgotPwd.setTitleColor(UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0), for: .normal)
        self.container.addSubview(btnForgotPwd)
        
        // set btn register
        let btnRegister = UIButton(frame:CGRect(x:210, y:260, width:90, height:40))
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnRegister.setTitleColor(UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0), for: .normal)
        btnRegister.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        self.container.addSubview(btnRegister)
        
        // set position container on center
        self.container.center = self.view.center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loginAction()
    {
        
    }
    
    func registerAction()
    {
        
    }
}
