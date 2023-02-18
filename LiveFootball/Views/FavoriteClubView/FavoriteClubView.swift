//
//  FavoriteClubView.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 09/02/23.
//

import Kingfisher
import SwiftUI

struct FavoriteClubView: View {
  let club: ClubModel
  @Binding var height: CGFloat

  var body: some View {
    VStack(spacing: 5) {
      KFImage(URL(string: club.team.logo))
        .resizable()
        .frame(width: 70, height: 70)
      Text(club.team.name)
        .font(.system(size: 28, weight: .semibold, design: .rounded))

      Spacer()
    }
    .padding()
    .background(
      GeometryReader { proxy in
        Color.clear
          .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
      }
      .onPreferenceChange(HeightPreferenceKey.self) { height in
        self.height = height
      }
    )
  }
}

struct HeightPreferenceKey: PreferenceKey {
  static let defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

/*
 struct FavoriteClubView_Previews: PreviewProvider {
   static var previews: some View {
     NavigationStack {
       FavoriteClubView(club: .init(id: 1, team: .init(id: 1, name: "Arsenal", code: "123", country: "England", logo: "https://media.api-sports.io/football/teams/42.png", founded: 2023, national: false), venue: .init(id: 1, name: "Etihad Stadium", address: "QPR", city: "England", surface: "Grass", image: "link", capacity: 10000)))
         .toolbar {
           ToolbarItem(placement: .navigationBarTrailing) {
             Button("Edit Favorites") {
               print("teste")
             }
           }
         }
     }
   }
 }
 */
