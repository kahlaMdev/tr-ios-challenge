//
//  MovieDetailsModelViewTest.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

import XCTest
@testable import MoviesBrowser

class MovieDetailsModelViewTest: MovieModelViewTest {
    
    var sut : MovieDetailModelView!
    
    override func setUp() {
        
        super.setUp()
        
        mocApiService.movieToMoc = mocMovie
        
        sut = MovieDetailModelView(aMovie: mocMovie, librairyAPI: mocApiService)
        
        sut.getMovieDetail()
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
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
}
