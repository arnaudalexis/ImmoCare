//
//  DetailsAdvert.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 08/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit
    var idAdvert: String!
class DetailsAdvertCtrl: UIViewController {
    
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
    
    // title label
    var titleAd: UILabel = {
        let content = UILabel(frame:CGRect(x:40, y:50, width:90, height:20))
        content.backgroundColor = .white
        content.font = UIFont.systemFont(ofSize:16)
        content.isUserInteractionEnabled = false
        content.textAlignment = .left   
        return content
    }()
    
    // body
    var bodyAd: UITextView = {
        let content = UITextView(frame:CGRect(x:36, y:75, width:250, height:85))
        content.isSecureTextEntry = true
        content.backgroundColor = .white
        content.keyboardType = .default
        content.font = UIFont.systemFont(ofSize:16)
        content.autocorrectionType = .no
        content.spellCheckingType = .no
        content.isEditable = false
        return content
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APIManager.sharedInstance.getAdvert(_id: idAdvert!, onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
            DispatchQueue.main.async(execute: {
                
                if(json["statusCode"] != 200){
                    self.present(ListAdvertsViewCtrl(), animated: true, completion:nil)
                } else {
                    self.titleAd.text = json["result"]["title"].stringValue
                    self.bodyAd.text = json["result"]["body"].stringValue
                }
            })
        }, onFailure: { error in
            DispatchQueue.main.async(execute: {
                print(error)
                self.present(ListAdvertsViewCtrl(), animated: true, completion:nil)
            })
        })
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
        title.text = "Details de l'annonce"
        self.container.addSubview(title)
        
        
        // set email textfield
        self.container.addSubview(titleAd)
        
        
        // set label textfield
        self.container.addSubview(bodyAd)
        
        
        // set btn post
        
        let btnList = UIButton(frame:CGRect(x:40, y:screenHeight-50, width:280, height:40))
        btnList.setBackgroundImage(UIImage(color:UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)), for: .normal)
        btnList.setTitle("LISTE", for: .normal)
        btnList.addTarget(self, action: #selector(listAction), for: .touchUpInside)
        self.container.addSubview(btnList)
        
        
        // set position container on center
        self.container.center = self.view.center
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listAction(){
        self.present(ListAdvertsViewCtrl(), animated: true, completion:nil)
    }
    
    
    func registerAction()
    {
        self.present(RegisterViewController(), animated: true, completion: nil)
    }
}
