//
//  MovieDetailsModelViewTest.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

import XCTest
@testable import MoviesBrowser

class MovieDetailsModelViewTest: XCTestCase {
    
    var sut : MovieDetailModelView!
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
    
    override func setUp() {
        
        super.setUp()
        
        mocMovie = MovieMoc(identifier: iD,
                            name: movieName,
                            descript: descrip,
                            plot: plot,
                            releaseDateEpochTime:dateTimeInterval,
                            rating: 10.0,
                            year: year)
        
        mocApiService = MocApiService()
        mocApiService.movieToMoc = mocMovie
        
        sut = MovieDetailModelView(aMovie: mocMovie, labrairyAPI: mocApiService)
        
        sut.getMovieDetail()
    }
    
    override func tearDown() {
        
        sut = nil
        mocMovie = nil
        mocApiService = nil
        
        super.tearDown()
        
    }
    
    func testMovieId() throws {
        XCTAssertEqual(sut.movie.value.identifier, iD)
    }
    
    func testMovieName() throws {
        XCTAssertEqual(sut.movieName.value, movieName)
    }
      
    func testMovieDescription() throws {
        XCTAssertEqual(sut.description.value, descrip)
    }
    
    func testMoviePlot() throws {
        XCTAssertEqual(sut.plot.value, plot)
    }
    
    func testMovieReleaseDate() throws {
        XCTAssertEqual(sut.releaseDate.value, "Release date : 25 of April 2019")
    }
    
    //TODO: testing Image size calculation
    // 
    
}
