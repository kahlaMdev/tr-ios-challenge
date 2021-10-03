//
//  MovieListViewModel.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

public class MovieListViewModel {
    let movies: Box<[Movie]> = Box([Movie]())

//    init() {
//        
//    }
    
    public func getMoviesList(){
        LibraryAPI.shared.downloadMoviesList { [weak self] (movies: [Movie], error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                // TODO: Handle error
                
                return
            }
            
            self.movies.value = movies
        }
    }
}

