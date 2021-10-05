//
//  GetRequest.swift
//  YTMovides
//
//  Created by Cédric Bahirwe on 05/10/2021.
//

import Foundation


struct GetRequest<ResponseStruct: Decodable>{
    var routeUrl: URL
    
    init(_ routeString: String){
        guard let url =  URL(string: routeString) else {
            fatalError("BASE_URL_ERROR_MESSAGE")
        }
        routeUrl = url
        
        print("Hitting: ", routeUrl)
    }
    
    func get(headers: [String: String] = [:],
             completion: @escaping(Result<ResponseStruct, NetworkErrors>) -> Void){
        
        var request = URLRequest(url: self.routeUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        let dataTask = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let error = error{
                // Request failure is sent here with localized Description.
                // Bad request and internet failures or unreachable server often exits here
                completion(.failure(.unknownError(message: error.localizedDescription)))
            } else{
                // convert the response to httpUrlResponse
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.serverError))
                    return
                }
                if !(200...299).contains(response.statusCode){
                    if let responseString = String(bytes: data!, encoding: .utf8) {
                        // The response body seems to be a valid UTF-8 string, so print that.
                        completion(.failure(.unknownError(message: responseString)))
                        print(responseString)
                    } else {
                        // Otherwise print a hex dump of the body.
                        completion(.failure(.serverError))
                        print(data! as NSData)
                    }
                } else{
                    // Request is successful and we've gotten the data, we try to decode the data here
                    do{
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                            print(json)
                        }
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseStruct.self, from: data!)
                        completion(.success(data))
                    } catch let error as NSError{
                        // If server's response structure is different from local structure, error occurs
                        print("An error occured when trying to decode the data >>>", error.localizedDescription)
                        completion(.failure(.unableToDecodeData))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
