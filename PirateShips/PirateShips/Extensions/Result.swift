//
//  Result.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

/// Type to represent, in an exclusive way, an successful value or an error
///
extension Result {
    /// Convenience initializer
    ///
    /// - Parameter value: a generic value of type `T`
    init(_ value: Success) {
        self = Result.success(value)
    }

    /// Convenience initializer
    ///
    /// - Parameter value: an instance of any type conforming to `Error` protocol
    init(_ value: Failure) {
        self = Result.failure(value)
    }
}
