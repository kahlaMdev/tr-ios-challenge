//
//  MocApiService.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

class MocApiService: APIServiceProtocol {
    
    var movieToMoc:MovieMoc!
    var moviesToMoc:[MovieMoc]!
    var recomendedMoviesToMoc:[MovieMoc]!
    
    func downloadMoviesList(completionHandler: @escaping ([MovieProtocol], DownloadError) -> ()){
        
        return completionHandler(moviesToMoc, .noError)
    }
    
    func downloadMovieDetails(forId: Int16, completionHandler: @escaping (MovieProtocol?, DownloadError) -> ()) {
        
        return completionHandler(movieToMoc, .noError)
    }
    
    func downloadRecommendedMovies(forId: Int16, completionHandler: @escaping ([MovieProtocol], DownloadError) -> ()) {
        
        return completionHandler(recomendedMoviesToMoc, .noError)
    }
    
    func getFromStorageRecommendedMovies(forId: Int16) -> [MovieProtocol] {
        
        return recomendedMoviesToMoc
    }
    
    func getMoviesFromStorage() -> [MovieProtocol] {
        return moviesToMoc
    }
    
}
