//
//  NSAttributedStringTransformer.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSArray.self]
    }
}
