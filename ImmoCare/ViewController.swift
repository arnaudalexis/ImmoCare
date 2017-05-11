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
        
        // set color background
        self.view.backgroundColor = UIColor(red: 146/255, green: 173/255, blue: 184/155, alpha: 1.0)
        
        // detect left swipe and use swipeLeft() method
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(recognizer:)))
        recognizer.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(recognizer)
        
        // set label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        label.center = CGPoint(x: 180, y: 300)
        label.textAlignment = .center
        label.text = "ImmoCare"
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // change view if left swipe detected
    func swipeLeft(recognizer : UISwipeGestureRecognizer)
    {
        self.present(LoginViewController(), animated: true, completion: nil)
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
