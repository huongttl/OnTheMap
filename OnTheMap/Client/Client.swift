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
//        static var accountId = 0
        static var sessionId = ""
        static var key = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        static let apiKeyParam = "?api_key=\(Client.apiKey)"
        static let imageBase = "https://image.tmdb.org/t/p/w500/"
        static let limit = 100
        
        case getStudentLocations
//        case getRequestToken
        case login
//        case createSessionId
//        case webAuth
//        case logout
//        case getFavorites
//        case search(String)
//        case markWatchlist
//        case markFavorite
//        case posterImageURL(String)
        
        var stringValue: String {
            switch self {
            case .getStudentLocations: return Endpoints.base + "/StudentLocation?limit=\(Endpoints.limit)?order=-updatedAt"// + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
//            case .getRequestToken:
//                return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
            case .login:
                return Endpoints.base + "/session"// + Endpoints.apiKeyParam
//            case .createSessionId:
//                return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam
//            case .webAuth:
//                return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"
//            case .logout:
//                return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
//            case .getFavorites:
//                return Endpoints.base + "/account/\(Auth.accountId)/favorite/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
//            case .search(let query):
//                return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
//            case .markWatchlist:
//                return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
//            case .markFavorite:
//                return Endpoints.base + "/account/\(Auth.accountId)/favorite" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
//            case .posterImageURL(let posterPath):
//                return Endpoints.imageBase + posterPath + Endpoints.apiKeyParam
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
//        task.cancel()
        return task
    }

    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
//        let boday = LoginRequest(udacity: Udacity(username: username, password: password))
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
          let newData = data.subdata(in: range) /* subset response data! */
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
    
    class func getStudentLocations(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentLocations.url, response: StudentLocations.self) {
            (response, error) in
            if let response = response {
//                print(response)
                completion(response.results, nil)
            } else {
                completion([], error)
//                print(error)
            }
        }
    }
    
//    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
//        taskForPOSTRequest(url: Endpoints.login.url, responseType: Session.self, body: LoginRequest(udacity: Udacity(username: username, password: password))) {
//            (response, error) in
//            if let response = response {
////                Auth.requestToken = response.requestToken
//                Auth.key = response.account.key
//                Auth.sessionId = response.session.id
//                completion(true, nil)
//            } else {
//                completion(false, error)
//            }
//        }
//    }
}
