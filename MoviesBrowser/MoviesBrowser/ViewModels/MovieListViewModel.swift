//
//  MovieListViewModel.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

public class MovieListViewModel {
    let movies: Box<[MovieProtocol]> = Box([MovieProtocol]())
    let error: Box<String?> = Box(nil)
    private let librairyAPI : APIServiceProtocol // For DI

    // Depency Injection: constructor/Interface Injection
    init(librairyAPI : APIServiceProtocol) {
        self.librairyAPI = librairyAPI
    }
    
    public func getMoviesList() {
        
        librairyAPI.downloadMoviesList { [weak self] (movies: [MovieProtocol], error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                self.error.value = "Failed to get Movies List Data."
            }
            
            self.movies.value = movies
        }
    }
    
    public func getStoredMovies() ->  [MovieProtocol] {
        
        self.movies.value = librairyAPI.getMoviesFromStorage()
        return self.movies.value
    }
}

