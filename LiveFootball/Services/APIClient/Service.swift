//
//  Service.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 26/01/23.
//

import Foundation

final class Service {
  static let shared = Service()

  private init() {}

  enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
  }

  public func execute<T: Codable>(
    _ request: Request,
    expecting type: T.Type
  ) async throws -> T {
    guard let urlRequest = self.request(from: request) else {
      throw ServiceError.failedToCreateRequest
    }

    do {
      let (data, _) = try await URLSession.shared.data(for: urlRequest)
      let response = try JSONDecoder().decode(T.self, from: data)
      return response
    } catch {
      throw error
    }
  }

  private func request(from request: Request) -> URLRequest? {
    guard let url = request.url else { return nil }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.httpMethod
    urlRequest.addValue(request.headerKey, forHTTPHeaderField: "x-rapidapi-key")
    urlRequest.addValue(request.headerHost, forHTTPHeaderField: "x-rapidapi-host")

    return urlRequest
  }
}
