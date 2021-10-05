//
//  MovieModelViewTest.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

import XCTest
@testable import MoviesBrowser


class MovieModelViewTest: XCTestCase {
    
    var mocMovie:MovieMoc!
    var mocApiService:MocApiService!
    
    let date = Date()
    
    let iD:Int16 = 111
    let movieName = "The computer Science"
    let descrip = "Computer science is very..."
    let plot = "As of today computing is..."
    let dateTimeInterval:Int64 = 1556236800
    let rating:Float = 10.0
    let year:Int16 = 2019
    
    let movie777 = MovieMoc(identifier: 777,
                            name: "777",
                            descript: "The begining of the ..",
                            plot: "When the plot of the time ...",
                            releaseDateEpochTime: 816998400,
                            rating: 8.3,
                            year: 1995,
                            recommendedMovies: [])
    
    override func setUp() {
        
        super.setUp()
        
        mocMovie = MovieMoc(identifier: iD,
                            name: movieName,
                            descript: descrip,
                            plot: plot,
                            releaseDateEpochTime:dateTimeInterval,
                            rating: 10.0,
                            year: year,
                            recommendedIDs: [777],
                            recommendedMovies: [movie777])
        
        mocApiService = MocApiService()
    }
    
    override func tearDown() {
        
        mocMovie = nil
        mocApiService = nil
        super.tearDown()
    }
    
}
