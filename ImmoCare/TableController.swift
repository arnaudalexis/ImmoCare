//
//  TableController.swift
//  uitableview_load_data_from_json_swift_3
//

import UIKit
import SwiftyJSON

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
}

class TableController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct Item {
        let id: String
        let title : String
        let date : String
        let image : String
    }
    

    @IBOutlet weak var tableview: UITableView!
    
    var items = [Item]()
    var images:Array = ["plante", "appart", "chien"]
    var selBody:String = ""
    var selTitle:String = ""
    var selImage:UIImage = #imageLiteral(resourceName: "immocare")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "myCell")

        APIManager.sharedInstance.listAdverts(onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
                if(json["statusCode"] != 200){
                    print("Error")
                } else {
                    print(json["result"])
                    DispatchQueue.main.async(execute: {self.extract_json(json: json)})
                    
                }
        }, onFailure: { error in
            DispatchQueue.main.async(execute: {
                print("Error")
            })
        })
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MyTableViewCell
        let item = items[indexPath.row]
        cell.cellTitleLabel?.text = item.title
        cell.cellDateLabel?.text = item.date
        let decodedimage = UIImage(named: item.image)
        cell.cellImageView?.image = decodedimage
        if(item.image != "") {
//            let base64Str = item.image
//            let decodedData = Data(base64Encoded: base64Str, options: .ignoreUnknownCharacters)
//            let decodedimage:UIImage = UIImage(data: decodedData!)!
            //let decodedimage = UIImage(named: images[number])
            cell.cellImageView?.image = decodedimage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("User selected table row \(indexPath.row) and item \(items[indexPath.row].id)")
        idAdvert = items[indexPath.row].id
        APIManager.sharedInstance.getAdvert(_id: idAdvert!, onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
            DispatchQueue.main.async(execute: {
                
                if(json["statusCode"] != 200){
                    self.present(TableController(), animated: true, completion:nil)
                } else {
                    if(json["result"].exists()){
                        print(json["result"]["title"].stringValue)
                        self.selBody = json["result"]["body"].stringValue;
                        self.selTitle = json["result"]["title"].stringValue;
                        print(self.items[indexPath.row].image)
                        self.selImage = UIImage(named: self.items[indexPath.row].image)!
                        self.performSegue(withIdentifier: "DetailsAdvertCtrl", sender: self)
                    }
                }
            })
        }, onFailure: { error in
            DispatchQueue.main.async(execute: {
                print(error)
                self.present(TableController(), animated: true, completion:nil)
            })
        })
        //self.present(DetailsAdvertCtrl(), animated: true, completion: nil)
    }
  
    
    func extract_json(json: JSON)
    {
        
        
        let data_list = json["result"].arrayValue
        
        print("an array")
        for aItem in data_list {
            
            let id = aItem["id"].stringValue
            let title = aItem["title"].stringValue
            let date = aItem["creation_date"].stringValue
            //let image = aItem["pictures"].stringValue
            
            let number = Int(arc4random_uniform(3))
            let image = images[number]
            let item = Item(id: id, title: title, date: date, image: image)
            self.items.append(item)
        }
        
        
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})

    }

    func do_table_refresh()
    {
        print("refresh")
        self.tableview.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "DetailsAdvertCtrl")
        {
            let vc = segue.destination as? DetailsAdvertCtrl
            vc?.body = selBody
            vc?.titleAdvert = selTitle
            vc?.image = selImage
        }
    }

}
