//
//  Cache.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 06/02/23.
//

import Foundation

final class Cache {
  static let shared: Cache = .init()

  private init() {}

  func save<T: Codable>(url: URL, expiringDate: Date, data: T) {
    do {
      let encoder = JSONEncoder()
      let cacheModel = CacheModel(expiringDate: expiringDate, data: data)
      let encodedData = try encoder.encode(cacheModel)

      UserDefaults.standard.set(encodedData, forKey: url.absoluteString)

      print("DEBUG: Set data in cache")
    } catch {
      print("DEBUG: Unable to encode CacheModel \(error.localizedDescription)")
    }
  }

  func get<T: Codable>(url: URL) -> T? {
    guard let data = UserDefaults.standard.data(forKey: url.absoluteString) else { return nil }
    do {
      let decoder = JSONDecoder()
      let cachedData = try decoder.decode(CacheModel<T>.self, from: data)

      if cachedData.expiringDate < Date.now {
        self.delete(url: url)
        return nil
      }

      print("DEBUG: Got data from cache")

      return cachedData.data
    } catch {
      print("DEBUG: Unable to decode CachedData \(error.localizedDescription)")
      return nil
    }
  }

  func delete(url: URL) {
    UserDefaults.standard.removeObject(forKey: url.absoluteString)
  }
}
