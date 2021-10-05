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
    private let labrairyAPI : APIServiceProtocol // For DI

    // Depency Injection: constructor/Interface Injection
    init(labrairyAPI : APIServiceProtocol) {
        self.labrairyAPI = labrairyAPI
    }
    
    public func getMoviesList() {
        
        labrairyAPI.downloadMoviesList { [weak self] (movies: [MovieProtocol], error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                self.error.value = "Failed to get Movies List Data."
            }
            
            self.movies.value = movies
        }
    }
    
    public func getStoredMovies() ->  [MovieProtocol] {
        
        if let MyMovies = CoreDataMoviesHelper.shared.fetchMoviesFromStorage() {
            self.movies.value = MyMovies
            return MyMovies
        }else {
            return [MovieProtocol]()
        }
    }
}

