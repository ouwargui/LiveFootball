//
//  FavoritesView.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject var appContext: AppContext
  @EnvironmentObject var router: Router

  @State private var height: CGFloat = 0

  var body: some View {
    NavigationStack {
      ScrollView {
        TabView {
          ForEach(appContext.favoriteTeams) { club in
            FavoriteClubView(club: club, height: $height)
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: height)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink(value: Routes.editFavorites) {
            Text("Edit Favorites")
          }
        }
      }
      .navigationDestination(for: Routes.self) { $0 }
    }
  }
}

struct FavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppContext())
      .environmentObject(Router())
  }
}
