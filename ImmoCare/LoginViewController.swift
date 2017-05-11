//
//  SecondViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 10/05/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

//TEST

import UIKit

class LoginViewController: UIViewController {
    
    // container login
    var container: UIView = {
        let my_view = UIView(frame:CGRect(x:0, y:0, width:300, height:300))
        my_view.backgroundColor = UIColor(red:0.26, green:0.72, blue:0.72, alpha: 1.0)
        return my_view
    }()
    
    // email
    var email: MyTextField = {
        let lemail = MyTextField(frame:CGRect(x:10, y:100, width:280, height:40))
        lemail.backgroundColor = .white
        lemail.placeholder = "Email"
        lemail.keyboardType = .emailAddress
        lemail.font = UIFont.systemFont(ofSize:14)
        return lemail
    }()

    // password
    var password: MyTextField = {
        let pwd = MyTextField(frame:CGRect(x:10, y:160, width:280, height:40))
        pwd.backgroundColor = .white
        pwd.placeholder = "Password"
        pwd.font = UIFont.systemFont(ofSize:14)
        return pwd
    }()
    
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
}
