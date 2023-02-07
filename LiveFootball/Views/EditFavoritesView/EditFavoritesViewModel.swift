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

    if let cachedResult = self.getCachedData(url: request.url) as ResponseModel<[ClubResponseModel]>? {
      self.clubs = cachedResult.response
        .map { .init(id: $0.team.id, team: $0.team, venue: $0.venue) }
        .sorted { $0.team.name < $1.team.name }

      return
    }

    do {
      let result = try await Service.shared.execute(request, expecting: ResponseModel<[ClubResponseModel]>.self)

      self.saveToCache(url: request.url, data: result)

      self.clubs = result.response
        .map { .init(id: $0.team.id, team: $0.team, venue: $0.venue) }
        .sorted { $0.team.name < $1.team.name }
    } catch {
      print(String(describing: error))
    }
  }

  private func getCachedData<T: Codable>(url: URL?) -> T? {
    guard let url = url else { return nil }

    return Cache.shared.get(url: url)
  }

  private func saveToCache<T: Codable>(url: URL?, data: T) {
    guard let url = url else { return }

    let expiringDate = Date.now.addingTimeInterval(24 * 60 * 60)

    Cache.shared.save(url: url, expiringDate: expiringDate, data: data)
  }

  func deleteRow(at index: Int, _ list: inout [ClubModel]) {
    list.remove(at: index)
  }

  func deleteRow(at indexSet: IndexSet, _ list: inout [ClubModel]) {
    list.remove(atOffsets: indexSet)
  }
}
