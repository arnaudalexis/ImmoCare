//
//  RestApiManager.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 04/07/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import Foundation

class APIManager {
    
    let baseURL = "http://localhost:3000"
    static let sharedInstance = APIManager()
    static let registerEndpoint = "/register/"
    static let loginEndpoint = "/login/"
    static let addAdvertEndpoint = "/addAdvert/"
    static let listAdvertsEndpoint = "/advertslist/"
    static let getAdvertEndpoint = "/advert/"
    
    func registerUser(_email: String, _password: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.registerEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let dict = ["email": _email, "password": _password] as [String: Any]
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
        
        let dict = ["email": _email, "password": _password] as [String: Any]
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
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "message": "Error"])
                    } else {
                        result = try JSON(["statusCode":statusCode, "message": "Vous êtes connecté!"])
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
    
    func addAdvert(_title: String, _body: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: baseURL + APIManager.addAdvertEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let dict = ["title": _title, "body": _body, "pictures": ""] as [String: Any]
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
                    if(statusCode != 200){
                        result = try JSON(["statusCode":statusCode, "result": "Error"])
                    } else {
                        result = try JSON(["statusCode":statusCode, "result": data])
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
                        result = try JSON(["statusCode":statusCode, "result": data])
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
