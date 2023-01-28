//
//  TeamModel.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import Foundation

struct ClubModel: Codable, Identifiable, Hashable {
  let id: Int

  let team: Team
  let venue: Venue

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}

struct ClubResponseModel: Codable {
  let team: Team
  let venue: Venue
}

struct Team: Codable, Identifiable, Equatable {
  let id: Int
  let name, code, country, logo: String
  let founded: Int
  let national: Bool
}

struct Venue: Codable, Identifiable, Equatable {
  let id: Int
  let name, address, city, surface, image: String
  let capacity: Int
}
