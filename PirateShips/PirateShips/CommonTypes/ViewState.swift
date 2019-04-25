//
//  ViewState.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

enum ViewState<T> {
    case loading
    case content(T)
    case error
}
