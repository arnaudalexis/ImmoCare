//
//  TableController.swift
//  uitableview_load_data_from_json_swift_3
//

import UIKit
import SwiftyJSON
import TagListView

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCodePostal: UILabel!
    @IBOutlet weak var cellVille: UILabel!
    @IBOutlet weak var cellCreateur: UILabel!
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var tagType: TagListView!
    @IBOutlet weak var bandeauView: UIImageView!
    
}

class TableController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct Item {
        let id: String
        let title : String
        let date : String
        let image : String
        let tags : String
        let idUser : String
        let username : String
        let cp : String
        let ville : String
        let type : Int
        let email : String
    }
    

    @IBOutlet weak var tableview: UITableView!
    
    var items = [Item]()
    var images:Array = ["plante", "appart", "chien"]
    var selBody:String = ""
    var selTitle:String = ""
    var selImage:UIImage = #imageLiteral(resourceName: "immocare")
    var selTags:String = ""
    var selName:String = ""
    var selCP:String = ""
    var selVille:String = ""
    var selType:Int = 0
    var selMail:String = ""

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
        cell.cellCodePostal?.text = item.cp
        cell.cellVille?.text = item.ville
        cell.cellCreateur?.text = item.username
        
        let decodedimage = UIImage(named: item.image)
        cell.cellImageView?.image = decodedimage
        let tags = (item.tags.count > 0 ? item.tags.components(separatedBy: ",") : ["Animal", "Chez moi", "Plante"])
        cell.tagList.removeAllTags()
        cell.tagList.addTags(tags)
        cell.tagType.removeAllTags()
        let tag = cell.tagType.addTag((item.type == 0 ? "Vacancier" : "Gardien"))
        tag.tagBackgroundColor = (item.type == 0 ? UIColor(red:117/255, green:253/255, blue:206/255, alpha: 1) : UIColor(red:251/255, green:104/255, blue:109/255, alpha: 1))
        cell.bandeauView.backgroundColor = (item.type == 0 ? UIColor(red:117/255, green:253/255, blue:206/255, alpha: 1) : UIColor(red:251/255, green:104/255, blue:109/255, alpha: 1))
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
        let item = items[indexPath.row]
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
                        self.selTags = item.tags
                        self.selName = item.username
                        self.selVille = item.ville
                        self.selCP = item.cp
                        self.selType = item.type
                        self.selMail = item.email
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
            let tags = (aItem["tags"].stringValue.count > 0 ? aItem["tags"].stringValue : "Animal,Chez moi,Plante")
            let idUser = aItem["id_user"].stringValue
            APIManager.sharedInstance.getUserProfile(_id: idUser, onSuccess: { json in
                if let string = json.rawString() {
                    print(string)
                }
                let firstname = json["result"]["firstname"].stringValue
                let city = json["result"]["city"].stringValue
                let cp = json["result"]["zipcode"].stringValue
                let type = json["result"]["type"].intValue
                let email = json["result"]["email"].stringValue
                let item = Item(id: id, title: title, date: date, image: image, tags: tags, idUser: idUser, username: firstname, cp: cp, ville: city, type: type, email: email)
                self.items.append(item)
                print(item)
                if(self.items.count == data_list.count){
                    DispatchQueue.main.async(execute: {self.do_table_refresh()})
                }
            }, onFailure: { error in
                DispatchQueue.main.async(execute: {
                    let item = Item(id: id, title: title, date: date, image: image, tags: tags, idUser: idUser, username: "", cp: "", ville: "", type: 0, email: "")
                    self.items.append(item)
                })
            })
        }
        
        
        //DispatchQueue.main.async(execute: {self.do_table_refresh()})
        

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
            vc?.tags = selTags
            vc?.city = selVille
            vc?.name = selName
            vc?.cp = selCP
            vc?.email = selMail
        }
    }

}
