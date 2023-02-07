//
//  CacheModel.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 06/02/23.
//

import Foundation

struct CacheModel<T: Codable>: Codable {
  let expiringDate: Date
  let data: T
}
