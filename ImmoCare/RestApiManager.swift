//
//  RestApiManager.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 04/07/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIManager {
    let baseURL = Constants.apiBaseUrl;
    static let sharedInstance = APIManager()
    static let registerEndpoint = "/register/"
    static let loginEndpoint = "/login/"
    static let getMyProfile = "/myProfil/"
    static let addAdvertEndpoint = "/addAdvert/"
    static let listAdvertsEndpoint = "/advertslist/"
    static let getAdvertEndpoint = "/advert/"
    static let addEventEndpoint = "/addEvent/"
    static let getUserProfile = "/user/"
    
    func registerUser(_email: String, _password: String, _name: String, _firstName: String, _zipcode: String, _country: String, _type: Int, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.registerEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let dict = ["email": _email, "password": _password, "firstname": _firstName, "name": _name, "zipcode": _zipcode, "country": _country, "type": _type] as [String: Any]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonData
        } catch{
            print(error)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "message": "Error"])
                    } else {
                        result = try JSON(["statusCode":statusCode, "message": "Vous êtes inscrit!"])
                    }
                    print(result)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func loginUser(_email: String, _password: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.loginEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dict = ["email": _email, "password": _password] as [String: Any]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonData
        } catch{
            print(error)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "message": "Error"])
                    } else {
                        //let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                        result = try JSON(["statusCode":statusCode, "message": "Vous êtes connecté!"])
                    }
                    print(result)
                    print(HTTPCookieStorage.shared.cookies)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func getMyProfile(_json: Dictionary<String, Any>, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.getMyProfile) else {
            print("Error: cannot create URL")
            return
        }
        apiRequest(_url: url, _method: "GET", _params: nil, onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
            onSuccess(json)
            return json
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    func getUserProfile(_id: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.getUserProfile + _id) else {
            print("Error: cannot create URL")
            return
        }
        apiRequest(_url: url, _method: "GET", _params: nil, onSuccess: { json in
            if let string = json.rawString() {
                print(string)
            }
            onSuccess(json)
            return json
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    func addAdvert(_title: String, _body: String, _tags: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.addAdvertEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let dict = ["title": _title, "body": _body, "pictures": "", "tags": _tags] as [String: Any]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonData
        } catch{
            print(error)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    print(httpResponse)
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "message": "Error"])
                    } else {
                        result = try JSON(["statusCode":statusCode, "message": "Vous avez posté une annonce!"])
                    }
                    print(result)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func listAdverts(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.listAdvertsEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "result": "Error"])
                    } else {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        result = try JSON(["statusCode":statusCode, "result": json])
                    }
                    print(result)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func getAdvert(_id: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.getAdvertEndpoint + _id) else {
            print("Error: cannot create URL")
            return
        }
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "result": "Error"])
                    } else {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        result = try JSON(["statusCode":statusCode, "result": json])
                    }
                    print(result)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func addEvent(_title: String, _body: String, _startDate: String, _endDate: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.addEventEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let dict = ["title": _title, "body": _body, "start": _startDate, "end": _endDate ] as [String: Any]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonData
        } catch{
            print(error)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    print(httpResponse)
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "message": "Error"])
                    } else {
                        result = try JSON(["statusCode":statusCode, "message": "Vous avez ajouté un évènement!"])
                    }
                    print(result)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func apiRequest(_url: URL, _method: String, _params: Dictionary<String, Any>?, onSuccess: @escaping(JSON) -> JSON, onFailure: @escaping(Error) -> Void){
        print("Url: ", _url)
        var urlRequest = URLRequest(url: _url)
        urlRequest.httpMethod = _method
        
        if(_params != nil){
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: _params, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch{
                print(error)
            }
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    var result = try JSON(["statusCode":500, "message": "Internal Error"])
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "message": "Error"])
                    } else {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        result = try JSON(["statusCode":statusCode, "message": "OK", "result": json])
                    }
                    print(result)
                    onSuccess(result)
                    
                } catch{
                    print(error)
                }
            }
        })
        task.resume()
    }


    
}
