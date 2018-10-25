//
//  DetailsAdvert.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 08/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit
import TagListView
import MessageUI
    var idAdvert: String!
class DetailsAdvertCtrl: UIViewController, MFMailComposeViewControllerDelegate {
    
    var titleAdvert:String = ""
    var body:String = ""
    var image:UIImage = #imageLiteral(resourceName: "immocare")
    var name:String = ""
    var city:String = ""
    var cp:String = ""
    var tags:String = ""
    var email:String = ""
    
    @IBOutlet weak var titleAd: UILabel!
    @IBOutlet weak var bodyAd: UITextView!
    @IBOutlet weak var imageAd: UIImageView!
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var cityUser: UILabel!
    @IBOutlet weak var cpUser: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tagArray = tags.components(separatedBy: ",")
        print(body)
        titleAd.text = titleAdvert
        bodyAd.text = body
        imageAd.image = image
        nameUser.text = name
        cityUser.text = city
        cpUser.text = cp
        tagList.addTags(tagArray)
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
    
    @IBAction func profilBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    
    @IBAction func mailtoBtn(_ sender: Any) {
        print("mailto")
        let email = self.email
        let subject = "[Immocare] Prise de contact pour une de vos annonce"
        let body = """
            Bonjour,
            Votre annonce: '\(self.titleAdvert)' m'intéresse.
            Pouriez-vous me répondre pour établir les détails de votre demande?
            Cordialement,
        """
        let coded = "mailto:\(email)?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if let emailURL: NSURL = NSURL(string: coded!) {
            if UIApplication.shared.canOpenURL(emailURL as URL) {
                UIApplication.shared.open(emailURL as URL)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "userProfile")
        {
            let vc = segue.destination as? PinProfileViewController
            vc?.nameStr = name
            vc?.cityStr = city
            vc?.emailStr = email
            vc?.numberStr = ""
        }
    }
    
}
