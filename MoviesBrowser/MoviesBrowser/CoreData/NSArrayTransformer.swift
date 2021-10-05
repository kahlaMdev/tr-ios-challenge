//
//  NSArrayTransformer.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

@objc(NSArrayTransformer)
class NSArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSArray.self]
    }
}
