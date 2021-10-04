//
//  MovieListViewModel.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

public class MovieListViewModel {
    let movies: Box<[Movie]> = Box([Movie]())
    private let labrairyAPI : APIServiceProtocol // For DI

    // Depency Injection: constructor/Interface Injection
    init(labrairyAPI : APIServiceProtocol) {
        self.labrairyAPI = labrairyAPI
    }
    
    public func getMoviesList() {
        
        labrairyAPI.downloadMoviesList { [weak self] (movies: [Movie], error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                // TODO: Handle error
                
                return
            }
            
            self.movies.value = movies
        }
    }
    
    public func getStoredMovies(){
        if let MyMovies = CoreDataMoviesHelper.shared.fetchMoviesFromStorage() {
            self.movies.value = MyMovies
        }
    }
}

