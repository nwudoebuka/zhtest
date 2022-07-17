//
//  NetworkError.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation
public enum NetworkError :  Error, LocalizedError {
  case badRequestData
  case badUrl
  case endpointError(message: String)
  case emptyResponseData
  case unDecodableResponse
  case unknownError
  case successfulButCouldNotDecode
  
  
  public var errorDescription: String? {
      switch self {
      case .badRequestData:
          return "Something isn't right. It's not you, it's us. Please try again."
      case .badUrl:
          return "Incorrect destination"
      case .endpointError(let message):
          return message
      case .emptyResponseData:
          return "Something isn't right. It's not you, it's us. Please try again."
      case .unDecodableResponse:
          return "The response could not be decoded"
      case .unknownError:
          return "Something isn't right. It's not you, it's us. Please try again."
      case .successfulButCouldNotDecode:
          return "Successful"
      }
  }
  
}

struct errorMessages {
    static let networkDefault = "Something isn't right. Please try again."
    static let noInternet = "It looks like you're offline. Please check your internet connection and try again."
    static let error400 = "Something isn't right. Please try again."
    static let error401 = "Sorry, something isn't right. We'll sign you out and you can sign in again."
    static let error408 = "Sorry, we couldn't make that happen. Please check your internet connection and try again."
    static let error500 = "Something isn't right. It's not you, it's us. Please try again."
}
