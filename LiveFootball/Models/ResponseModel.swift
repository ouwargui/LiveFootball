//
//  ResponseModel.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 27/01/23.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
  let results: Int
  let paging: PagingModel
  let response: T
}

struct PagingModel: Codable {
  let current: Int
  let total: Int
}
