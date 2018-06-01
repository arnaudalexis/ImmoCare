//
//  ViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 10/05/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // detect left swipe and use swipeLeft() method
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(recognizer:)))
        recognizer.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // change view if left swipe detected
    @objc func swipeLeft(recognizer : UISwipeGestureRecognizer)
    {
         self.performSegue(withIdentifier: "initSegue", sender: self)
    }

}

class MyTextField : UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).insetBy(dx: 10, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).insetBy(dx: 10, dy: 0)
    }
}

extension UIImage
{
    public convenience init?(color:UIColor, size:CGSize=CGSize(width:1,height:1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
