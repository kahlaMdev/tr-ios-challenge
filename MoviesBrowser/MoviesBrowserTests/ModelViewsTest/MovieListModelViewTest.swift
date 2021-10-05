//
//  MovieListModelViewTest.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

import XCTest
@testable import MoviesBrowser

class MovieListModelViewTest: MovieModelViewTest {
    
    var sut : MovieListViewModel!
    
    override func setUp() {
        
        super.setUp()
        
        mocApiService.moviesToMoc = [mocMovie, movie777]
        
        sut = MovieListViewModel(librairyAPI: mocApiService)
        
        sut.getMoviesList()
    }
    
    func testMovieId() throws {
        XCTAssertEqual(sut.movies.value.count, 2)
    }
    
    func testMovieError() throws {
        XCTAssertEqual(sut.error.value, nil)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
