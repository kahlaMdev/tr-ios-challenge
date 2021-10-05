//
//  RecommendedViewModel.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

class RecommendedViewModel {
    
    let recommendedMovies: Box<[MovieProtocol]> = Box([MovieProtocol]())
    let movie: Box<MovieProtocol>
    private let labrairyAPI : APIServiceProtocol // For DI
    
    // Depency Injection: constructor/Interface Injection
    init(aMovie: MovieProtocol, labrairyAPI : APIServiceProtocol) {
        self.movie = Box(aMovie)
        self.labrairyAPI = labrairyAPI
    }
    
    public func getStoredRecommended() -> [MovieProtocol] {
        return labrairyAPI.getFromStorageRecommendedMovies(forId: self.movie.value.identifier)
    }
    
    public func getRecommended(){
        
        labrairyAPI.downloadRecommendedMovies(forId:self.movie.value.identifier, completionHandler: { [weak self] (movies: [MovieProtocol], error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                //TODO: Handle error
                
            }
            
            self.recommendedMovies.value = movies
        })
    }
    
}
