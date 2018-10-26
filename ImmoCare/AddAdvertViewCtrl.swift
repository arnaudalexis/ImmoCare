//
//  PostAnnounceViewCtrl.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 07/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit
import SwiftMultiSelect
import TagListView

class AddAdvertViewCtrl: UIViewController, SwiftMultiSelectDelegate, SwiftMultiSelectDataSource {
    
    var items:[SwiftMultiSelectItem] = [SwiftMultiSelectItem]()
    var initialValues:[SwiftMultiSelectItem] = [SwiftMultiSelectItem]()
    var selectedItems:[SwiftMultiSelectItem] = [SwiftMultiSelectItem]()
    var selectedTags:String = ""
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var tagListView: TagListView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createItems()
        SwiftMultiSelect.dataSourceType = .custom
        SwiftMultiSelect.dataSource     = self
        SwiftMultiSelect.delegate       = self
        Config.selectorStyle.selectionHeight = 60
        Config.selectorStyle.avatarScale = 1
        Config.selectorStyle.selectionHeight = 0
        Config.tableStyle.tableRowHeight = 40
        Config.colorArray = [UIColor.clear]
        Config.viewTitle = "Choisir des tags"
        Config.doneString = "OK"
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        body.text = ""
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
            APIManager.sharedInstance.addAdvert(_title: titleField.text!, _body: body.text!, _tags: selectedTags, onSuccess: { json in
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
    
    func swiftMultiSelect(didSelectItems items: [SwiftMultiSelectItem]) {
        
        initialValues   = items
        
        print("you have been selected: \(items.count) items!")
        
        var arrayItems:[String] = []
        
        for item in items{
            print(item.string)
            arrayItems.append(item.title)
        }
        
        selectedTags = arrayItems.joined(separator: ",")
        print(selectedTags)
        tagListView.removeAllTags()
        tagListView.addTags(arrayItems)
        
    }
    
    func swiftMultiSelect(didUnselectItem item: SwiftMultiSelectItem) {
        print("row: \(item.title) has been deselected!")
    }
    
    func swiftMultiSelect(didSelectItem item: SwiftMultiSelectItem) {
        print("item: \(item.title) has been selected!")
    }
    
    func didCloseSwiftMultiSelect() {
        
    }
    
    func userDidSearch(searchString: String) {
        if searchString == ""{
            selectedItems = items
        }else{
            selectedItems = items.filter({$0.title.lowercased().contains(searchString.lowercased()) || ($0.description != nil && $0.description!.lowercased().contains(searchString.lowercased())) })
        }
    }
    
    func swiftMultiSelect(itemAtRow row: Int) -> SwiftMultiSelectItem {
        return selectedItems[row]
    }
    
    func numberOfItemsInSwiftMultiSelect() -> Int {
        return selectedItems.count
    }
    
    /// Create a custom items set
    func createItems(){
        
        self.items.removeAll()
        self.initialValues.removeAll()
        let arrayTags = ["chez moi", "chez toi", "chat", "chien", "plantes", "jardin", "nuit"]
        var i = 0
        while i < arrayTags.count {
            items.append(SwiftMultiSelectItem(row: i, title: arrayTags[i]))
            i = i+1
        }
        
        self.initialValues = [self.items.first!,self.items[1]]
        self.selectedItems = items
    }
    
    @IBAction func launch(_ sender: Any) {
        
        
        SwiftMultiSelect.initialSelected = initialValues
        
        SwiftMultiSelect.Show(to: self)
        
    }
    
}
