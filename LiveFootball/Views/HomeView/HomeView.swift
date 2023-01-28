//
//  HomeView.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    TabView {
      Text("um")
        .tabItem {
          Label("Games", systemImage: "basketball.fill")
        }
      FavoritesView()
        .tabItem {
          Label("Favorites", systemImage: "star.fill")
        }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
