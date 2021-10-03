//
//  HTTPClient.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation
import UIKit

public enum DownloadError {
    case noError
    case invalidResponse
    case missingData
    case requestError
}

// A  HTTP client to handle remote communications
class HTTPClient {
    
    public func downoadData(urlStr: String, completionHandler: @escaping (Data?, DownloadError) -> ()) {
        var urlString = urlStr
        //urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlStr
        
        let customAllowedSet =  NSCharacterSet(charactersIn:" ").inverted
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? urlStr
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url,
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, // cache policy Ignores Local and remote cache!
                                        timeoutInterval: CONSTACTS.DATA_DOWNLOAD_CONNECTION_TIMEOUT_DURATION) // Timeout after!
            
            //Networking request
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                
                if let myError = error {
                    print(myError)
                    return completionHandler(nil, .requestError)
                    
                }else {
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        
                        //Handle server error response != 200...299
                        print(response ?? "NIL URL Response!")
                        
                        return completionHandler(nil, .invalidResponse)
                    }
                    
                    guard let data = data else {
                        return completionHandler(nil, .missingData)
                    }
                    
                    return completionHandler(data, .noError)
                    
                }
            })
            
            task.resume()
        }
    }
}
