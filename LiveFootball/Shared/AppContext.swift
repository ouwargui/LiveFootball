//
//  AppContext.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 25/01/23.
//

import Foundation

@MainActor
class AppContext: ObservableObject {
  @Published var favoriteTeams: [ClubModel] = [] {
    didSet {
      setFavoriteTeamsOnStorage(favoriteTeams: favoriteTeams)
    }
  }
  
  init() {
    self.favoriteTeams = getFavoriteTeamsFromStorage()
  }
  
  func getFavoriteTeamsFromStorage() -> [ClubModel] {
    if let data = UserDefaults.standard.data(forKey: "@LFFavoriteTeams") {
      do {
        let decoder = JSONDecoder()
        
        let favoriteTeams = try decoder.decode([ClubModel].self, from: data)
        return favoriteTeams
      } catch {
        print("DEBUG: Unable to decode favorite teams: \(error.localizedDescription)")
      }
    }
    
    return []
  }
  
  func setFavoriteTeamsOnStorage(favoriteTeams: [ClubModel]) {
    do {
      let encoder = JSONEncoder()
      
      let data = try encoder.encode(favoriteTeams)
      
      UserDefaults.standard.set(data, forKey: "@LFFavoriteTeams")
    } catch {
      print("DEBUG: Unable to encode favorite teams: \(error.localizedDescription)")
    }
  }
}
