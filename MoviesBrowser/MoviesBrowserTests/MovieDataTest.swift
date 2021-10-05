//
//  MovieDataTest.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

import Foundation

import XCTest
@testable import MoviesBrowser

class MovieDataTest: XCTestCase {
    
    var exampleJSONData: Data!
    var movieDetail: MovieDetail!

    override func setUp() {
      let bundle = Bundle(for: type(of: self))
      let url = bundle.url(forResource: "detailsMovieExample-1", withExtension: "json")!
      exampleJSONData = try! Data(contentsOf: url)
    
      let decoder = JSONDecoder()
        movieDetail = try! decoder.decode(MovieDetail.self, from: exampleJSONData)
    }
      
    func testDecodeId() throws {
      XCTAssertEqual(movieDetail.identifier, 777)
    }
    
    func testDecodeName() throws {
      XCTAssertEqual(movieDetail.name, "Avengers: Endgame")
    }
    
    func testDecodeDescription() throws {
      XCTAssertEqual(movieDetail.descript, "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.")
    }
    
    func testDecodePlot() throws {
      XCTAssertEqual(movieDetail.plot, "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos's actions and undo the chaos to the universe, no matter what consequences may be in store, and no matter who they face...")
    }
    
    func testDecodeRating() throws {
      XCTAssertEqual(movieDetail.rating, 8.4)
    }
    
    func testDecodePicture() throws {
      XCTAssertEqual(movieDetail.picture, "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/1.jpg")
    }
    
    func testDecodeReleaseDate() throws {
      XCTAssertEqual(movieDetail.releaseDateEpochTime, 1556236800)
    }
    
}
