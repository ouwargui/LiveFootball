//
//  Request.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 26/01/23.
//

import Foundation

final class Request {
  /*
   baseUrl: https://v3.football.api-sports.io/
   */
  
  private enum Constants {
    static let baseUrl = "https://v3.football.api-sports.io"
    static let httpMethod = "GET"
    static let headerKey = "d72c9ccc60524e332fbe5aba01ee523f"
    static let headerHost = "v3.football.api-sports.io"
  }
  
  private let endpoint: Endpoint
  private let pathComponents: [String]
  private let queryParams: [URLQueryItem]
  
  private var urlString: String {
    var string = Constants.baseUrl
    string += "/"
    string += endpoint.rawValue
    
    if !pathComponents.isEmpty {
      pathComponents.forEach {
        string += "/\($0)"
      }
    }
    
    if !queryParams.isEmpty {
      string += "?"
      
      let argumentString = queryParams
        .compactMap {
          guard let value = $0.value else { return nil }
          return "\($0.name)=\(value)"
        }
        .joined(separator: "&")
      
      string += argumentString
    }
    
    return string
  }
  
  public var url: URL? {
    return URL(string: urlString)
  }
  
  public let httpMethod = Constants.httpMethod
  public let headerKey = Constants.headerKey
  public let headerHost = Constants.headerHost
  
  init(endpoint: Endpoint, pathComponents: [String] = [], queryParams: [URLQueryItem] = []) {
    self.endpoint = endpoint
    self.pathComponents = pathComponents
    self.queryParams = queryParams
  }
}
