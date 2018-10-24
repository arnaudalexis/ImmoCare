//
//  DetailsAdvert.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 08/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit
import MessageUI
    var idAdvert: String!
class DetailsAdvertCtrl: UIViewController, MFMailComposeViewControllerDelegate {
    
    var titleAdvert:String = ""
    var body:String = ""
    var image:UIImage = #imageLiteral(resourceName: "immocare")
    
    @IBOutlet weak var titleAd: UITextField!
    @IBOutlet weak var bodyAd: UITextView!
    @IBOutlet weak var imageAd: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(body)
        titleAd.text = titleAdvert
        bodyAd.text = body
        imageAd.image = image
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["alexis.arnaud@saaswedo.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    func registerAction()
    {
        self.present(RegisterViewController(), animated: false, completion: nil)
    }
}
