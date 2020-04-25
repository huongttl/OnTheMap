//
//  Client.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/29/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import Foundation

class Client {
    static let apiKey = ""
    
    struct Auth {
        static var sessionId = ""
        static var key = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        static let apiKeyParam = "?api_key=\(Client.apiKey)"
        static let imageBase = "https://image.tmdb.org/t/p/w500/"
        
        case getStudentLocations
        case getCurrentStudentLocation
        case login
        case logout
        case addStudentLocation
        
        var stringValue: String {
            switch self {
            case .getStudentLocations:
                return Endpoints.base + "/StudentLocation?order=-updatedAt"
            case .login:
                return Endpoints.base + "/session"
            case .getCurrentStudentLocation:
                return Endpoints.base + "/StudentLocation?uniqueKey=\(Auth.key)"
            case .addStudentLocation:
                return Endpoints.base + "/StudentLocation"
            case .logout:
                return Endpoints.base + "/session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult class func taskForGETRequest<ResponseType: Codable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void ) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch {
//                do {
//                    let errorResponse = try decoder.decode(TMDBResopnse.self, from: data)
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
//                }
            }
        }
        task.resume()
        return task
    }

    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            data, response, error in
          if error != nil { // Handle error…
//            print(error)
              return
          }
            guard let data = data else {
                print("there is no data")
                return
            }
          let range = 5..<data.count
          let newData = data.subdata(in: range)
          print(String(data: newData, encoding: .utf8)!)
            let decoder = JSONDecoder()
        do {
           let dataDecoded = try decoder.decode(Session.self, from: newData)
            Auth.sessionId = dataDecoded.session.id
            Auth.key = dataDecoded.account.key
           completion (true, nil)
           print("The login is done successfuly!")
        } catch {
            print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    class func addStudentLocation(firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longtitude: Double, completion: @escaping (Bool, Error?) -> Void){
        var request = URLRequest(url: Endpoints.addStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(Auth.key)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longtitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            data, response, error in
          if error != nil { // Handle error…
//            print(error)
              return
          }
            guard let data = data else {
                print("there is no data")
                return
            }
          let range = 5..<data.count
          let newData = data.subdata(in: range) /* subset response data! */
          print(String(data: newData, encoding: .utf8)!)
            let decoder = JSONDecoder()
        do {
           let _ = try decoder.decode(AddStudentLocation.self, from: data)
           completion (true, nil)
           print("Student location posted!")
        } catch {
            print("local error")
            print(error.localizedDescription)
            }
        }
        task.resume()
    }
   
    class func logout(completion: @escaping () -> Void){
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          let range = 5..<data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        completion()
        }
        task.resume()
    }
    
    class func getStudentLocations(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentLocations.url, response: StudentLocations.self) {
            (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
//                print(error)
            }
        }
    }
    
        class func getCurrentStudentLocation(completion: @escaping ([StudentLocation], Error?) -> Void) {
            taskForGETRequest(url: Endpoints.getCurrentStudentLocation.url, response: StudentLocations.self) {
                (response, error) in
                if let response = response {
                    completion(response.results, nil)
                } else {
                    completion([], error)
                }
            }
        }
}
