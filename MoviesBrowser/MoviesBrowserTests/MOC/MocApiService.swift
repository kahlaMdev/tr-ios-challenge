//
//  MocApiService.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

class MocApiService: APIServiceProtocol {
    
    var movieToMoc:MovieMoc?
    
    func getFromStorageRecommendedMovies(forId: Int16) -> [MovieProtocol] {
        
        return []
    }
    
    
    func downloadMoviesList(completionHandler: @escaping ([MovieProtocol], DownloadError) -> ()){
        
    }
    
    func downloadMovieDetails(forId: Int16, completionHandler: @escaping (MovieProtocol?, DownloadError) -> ()) {
        return completionHandler(movieToMoc, .noError)
    }
    
    func downloadRecommendedMovies(forId: Int16, completionHandler: @escaping ([MovieProtocol], DownloadError) -> ()) {
        
    }
    
}
