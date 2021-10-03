//
//  MovieDetailModelView.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

class MovieDetailModelView {
    
    let movie: Box<Movie>
    
    init(aMovie: Movie) {
        self.movie = Box(aMovie)
    }

    public func getMovieDetail() {
            
        LibraryAPI.shared.downloadMovieDetails(forId:self.movie.value.identifier, completionHandler: { [weak self] (movie: Movie?, error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                //TODO: Handle error
                
                return
            }
            
            if let myMovie = movie {
                self.movie.value = myMovie
            }
        })
    }
      
}

      

