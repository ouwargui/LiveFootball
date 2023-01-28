//
//  EditFavoritesView.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import Kingfisher
import SwiftUI

struct EditFavoritesView: View {
  @EnvironmentObject var appContext: AppContext
  @StateObject var viewModel = EditFavoritesViewModel()

  var body: some View {
    List {
      Section("Favorites") {
        ForEach(Array(appContext.favoriteTeams.sorted {
          $0.team.name < $1.team.name
        }.enumerated()), id: \.element) { index, club in
          HStack {
            KFImage(URL(string: club.team.logo))
              .resizable()
              .placeholder {
                ProgressView()
                  .frame(width: 50, height: 50)
              }
              .frame(width: 50, height: 50)
            Text(club.team.name)
              .padding()
            
            Spacer()
            
            CircleButtonView(systemImageName: "minus.circle.fill", color: .red) {
              viewModel.deleteRow(at: index, &appContext.favoriteTeams)
            }
            .disabled(!viewModel.isEditing)
            .offset(x: viewModel.isEditing ? 0 : 60)
          }
        }
        .onDelete { indexSet in
          withAnimation {
            viewModel.deleteRow(at: indexSet, &appContext.favoriteTeams)
          }
        }
      }
      Section("Premier League") {
        ForEach(viewModel.clubs.filter {
          !appContext.favoriteTeams.contains($0)
        }) { club in
          HStack {
            KFImage(URL(string: club.team.logo))
              .resizable()
              .placeholder {
                ProgressView()
                  .frame(width: 50, height: 50)
              }
              .frame(width: 50, height: 50)
            Text(club.team.name)
              .padding()
            
            Spacer()
            
            CircleButtonView(systemImageName: "plus.circle.fill", color: .green) {
              appContext.favoriteTeams.append(club)
            }
            .disabled(!viewModel.isEditing)
            .offset(x: viewModel.isEditing ? 0 : 60)
          }
        }
      }
    }
    .navigationTitle("Favorite teams")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          withAnimation(.easeInOut(duration: 0.15)) {
            viewModel.isEditing.toggle()
          }
        } label: {
          Text(viewModel.isEditing ? "Done" : "Edit")
        }
      }
    }
  }
}

struct EditFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      EditFavoritesView()
        .environmentObject(AppContext())
    }
  }
}
