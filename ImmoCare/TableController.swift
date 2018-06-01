//
//  TableController.swift
//  uitableview_load_data_from_json_swift_3
//

import UIKit
import SwiftyJSON

class TableController: UITableViewController {

    struct Item {
        let id: String
        let title : String
        let date : String
    }
    
    
    @IBAction func ajouter(_ sender: Any) {
        self.present(AddAdvertViewCtrl(), animated: false, completion: nil)
    }
    
    var items = [Item]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        APIManager.sharedInstance.listAdverts(onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
                if(json["statusCode"] != 200){
                    print("Error")
                } else {
                    print(json["result"])
                    
                    self.extract_json(json: json)
                }
        }, onFailure: { error in
            DispatchQueue.main.async(execute: {
                print("Error")
            })
        })
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("User selected table row \(indexPath.row) and item \(items[indexPath.row].id)")
        idAdvert = items[indexPath.row].id
        self.present(DetailsAdvertCtrl(), animated: true, completion: nil)
    }
  
    
    func extract_json(json: JSON)
    {
        
        
        let data_list = json["result"].arrayValue
        
        print("an array")
        for aItem in data_list {
            
            let id = aItem["id"].stringValue
            let title = aItem["title"].stringValue
            let date = aItem["creation_date"].stringValue
            
            let item = Item(id: id, title: title, date: date)
            self.items.append(item)
        }
        
        
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})

    }

    func do_table_refresh()
    {
        self.tableView.reloadData()
        
    }
    

}
