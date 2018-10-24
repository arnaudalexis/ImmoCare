//
//  PostAnnounceViewCtrl.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 07/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class AddAdvertViewCtrl: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var body: UITextView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postAction(_ sender: Any) {
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
    
    func isValidString(str: String) -> Bool
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{7,18}$", options: .caseInsensitive)
            if regex.matches(in: str, options: [], range: NSMakeRange(0, str.characters.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
}
