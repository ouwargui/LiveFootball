//
//  FavoritesView.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import SwiftUI

struct FavoritesView: View {
  var body: some View {
    NavigationStack {
      Text("Hello world!")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: EditFavoritesView()) {
              Text("Edit favorites")
            }
          }
        }
    }
  }
}

struct FavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesView()
  }
}
