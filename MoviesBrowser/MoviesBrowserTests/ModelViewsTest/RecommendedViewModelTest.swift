//
//  RecommendedViewModelTest.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

import XCTest
@testable import MoviesBrowser

class RecommendedViewModelTest: MovieModelViewTest {
    
    var sut : RecommendedViewModel!
    
    override func setUp() {
        
        super.setUp()
        
        mocApiService.recomendedMoviesToMoc = [movie777]
        
        sut = RecommendedViewModel(aMovie: mocMovie, librairyAPI: mocApiService)
        
        sut.getRecommended()
    }

    func testMovieId() throws {
        XCTAssertEqual(sut.movie.value.identifier, iD)
    }
    
    func testRecommendMovieIds() throws {
        
        XCTAssertEqual(sut.movie.value.identifier, iD)
        
        if let recommendedFirst = sut.recommendedMovies.value.first {
            XCTAssertEqual(recommendedFirst.identifier, 777)
        }else {
            XCTAssertThrowsError("Recommended Movies list is not assigned!")
        }
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

