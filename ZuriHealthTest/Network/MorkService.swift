//
//  MorkService.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation

final class MockService: ServiceProtocol {
  
  var didCallGetAllItems: Bool = false
  var items: ResponseModel = ResponseModel()
  var itemsClosure: ((Result<ResponseModel, Error>) -> ())!
  func getItems(completion: @escaping (Result<ResponseModel, Error>) -> Void) {
    didCallGetAllItems = true
    itemsClosure = completion
  }
  
    //Closures fo manilupating the state (success or failure) of the request
    func getAllItemsFailure() {
      itemsClosure(.failure(NetworkError.endpointError(message: errorMessages.networkDefault)))
    }
    
    func getAllItemsSuccess() {
      itemsClosure(.success(items))
    }
    
}
