//
//  ListAdvertsViewCtrl.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 07/09/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class ListAdvertsViewCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var container: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 100
        let my_view = UIView(frame:CGRect(x:0, y:0, width:screenWidth, height:screenSize.height))
        my_view.backgroundColor = UIColor(red:1, green:1, blue:1, alpha: 1.0)
        my_view.contentMode = .scaleAspectFit
        return my_view
    }()
    
    var myTableView: UITableView  =   UITableView()
    var itemsToLoad: [String] = ["One", "Two", "Three"]
    
    struct Item {
        let id: String
        let title : String
        let date : String
    }
    
    var items = [Item]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APIManager.sharedInstance.listAdverts(onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
            DispatchQueue.main.async(execute: {
                
                
                if(json["statusCode"] != 200){
                    print("Error")
                } else {
                    print(json["result"])
                        
                        let itemsArray = json["result"].arrayValue
                        for aItem in itemsArray {
                            
                            let id = aItem["id"].stringValue
                            let title = aItem["title"].stringValue
                            let date = aItem["creation_date"].stringValue
                            
                            let item = Item(id: id, title: title, date: date)
                            self.items.append(item)
                        }
                    
                    self.myTableView.reloadData()
                }
            })
        }, onFailure: { error in
            DispatchQueue.main.async(execute: {
                print("Error")
            })
        })
        
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 100
        
        myTableView.frame = CGRect(x:0, y:20, width:screenWidth, height:screenHeight);
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        self.view.addSubview(container)
        self.container.addSubview(myTableView)
        
        let btnAdd = UIButton(frame:CGRect(x:40, y:screenHeight, width:280, height:40))
        btnAdd.setBackgroundImage(UIImage(color:UIColor(red:0.27, green:0.83, blue:0.76, alpha: 1.0)), for: .normal)
        btnAdd.setTitle("Nouvelle Annonce", for: .normal)
        btnAdd.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        self.container.addSubview(btnAdd)
    }
    
    @objc func addAction(){
        self.present(AddAdvertViewCtrl(), animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("User selected table row \(indexPath.row) and item \(items[indexPath.row].id)")
        idAdvert = items[indexPath.row].id
        self.present(DetailsAdvertCtrl(), animated: true, completion: nil)
    }
}
