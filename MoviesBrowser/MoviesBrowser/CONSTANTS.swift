//
//  CONSTANTS.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation

import Foundation

final class CONSTACTS {
    
    static let MOVIES_BASE_URI = "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/"
    
    // Data URI to download json
    static let MOVIES_LIST_DATA_URI = MOVIES_BASE_URI + "list.json"
    
    static let MOVIE_DETAILS_DATA_URI = MOVIES_BASE_URI + "details/" //{id}.json
    
    static let MOVIE_RECOMMENDED_LIST_DATA_URI = MOVIE_DETAILS_DATA_URI + "recommended/" //{id}.json
    
    
    static let DATA_DOWNLOAD_CONNECTION_TIMEOUT_DURATION = 10.0
    
    
}
