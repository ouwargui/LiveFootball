//
//  Router.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 17/02/23.
//

import SwiftUI

enum Routes: String, View {
  case editFavorites = "Edit Favorites"
  
  var body: some View {
    switch self {
    case .editFavorites:
      EditFavoritesView()
    }
  }
}
