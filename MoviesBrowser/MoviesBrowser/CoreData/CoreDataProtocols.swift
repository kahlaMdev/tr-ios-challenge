//
//  CoreDataProtocols.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

public protocol CoreDataMovieServiceProtocol {
    
    func saveContext ()
    
    func getMoviesCount() -> Int
    func deleteAllMovies()
    func fetchMoviesFromStorage() -> [MovieProtocol]?
    func fetchMovieFromStorage(id: Int16) -> MovieProtocol?
    func fetchMoviesFromStorage(forIds: [Int16]) -> [MovieProtocol]
    func updateDataBaseWithMoviesList(movies: MoviesList)
    func updateDataBaseWithMovieModel(movie: MovieModel)
    func updateDataBaseWithMovieDetail(movieDetail: MovieDetail)
    func updateMovie(id: Int16, recommendedMovies:MoviesList)
}
