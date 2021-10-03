//
//  RecommendedViewModel.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

class RecommendedViewModel {
    
    let recommendedMovies: Box<[Movie]> = Box([Movie]())
    let movie: Box<Movie>
    
    init(aMovie: Movie) {
        self.movie = Box(aMovie)
    }
    
    public func getRecommended(){
        
        LibraryAPI.shared.downloadRecommendedMovies(forId:self.movie.value.identifier, completionHandler: { [weak self] (movies: [Movie], error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                //TODO: Handle error
                
                return
            }
            
            self.recommendedMovies.value = movies
        })
    }
    
}
