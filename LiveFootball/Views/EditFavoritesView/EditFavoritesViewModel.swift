//
//  EditFavoritesViewModel.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import Foundation

@MainActor
class EditFavoritesViewModel: ObservableObject {
  @Published var isEditing: Bool = false
  @Published var clubs: [ClubModel] = []

  init() {
    Task {
      await self.getClubsData()
    }
  }

  func getClubsData() async {
    let request = Request(endpoint: .teams,
                          queryParams: [
                            URLQueryItem(name: "league", value: "39"),
                            URLQueryItem(name: "season", value: "2022"),
                          ])

    do {
      let result = try await Service.shared.execute(request, expecting: ResponseModel<[ClubResponseModel]>.self)
      self.clubs = result.response
        .map { .init(id: $0.team.id, team: $0.team, venue: $0.venue) }
        .sorted { $0.team.name < $1.team.name }
    } catch {
      print(String(describing: error))
    }
  }

  func deleteRow(at index: Int, _ list: inout [ClubModel]) {
    list.remove(at: index)
  }

  func deleteRow(at indexSet: IndexSet, _ list: inout [ClubModel]) {
    list.remove(atOffsets: indexSet)
  }
}
