//
//  Service.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation
import Alamofire
protocol ServiceProtocol {
  func getItems(completion: @escaping (Result<ResponseModel, Error>)-> Void)
}
class Service:ServiceProtocol {
  
  
  func getItems(completion: @escaping (Result<ResponseModel, Error>)-> Void){
  
      let url = "\(BASE_URL)4e23865c-b464-4259-83a3-061aaee400ba"
        debugPrint("photos url is \(url)")
        AF.request(url)
                 .validate()
                 .responseJSON { response in
                       let result = response.result
                      let code = response.response?.statusCode
                   debugPrint("responswe code \(code)")
                       switch result {
                       case .success(_):
                           do {
                               if let data = response.data {
                                   let decodedData = try JSONDecoder().decode(ResponseModel.self, from: data)
                                   debugPrint(decodedData)
                                   completion(.success(decodedData))
                               } else {
                               
                                 completion(.failure(NetworkError.endpointError(message:errorMessages.networkDefault)))
                               }
                           } catch {
                             completion(.failure(NetworkError.unDecodableResponse))
                           }
                       case .failure(let error):
                         completion(.failure(error))
                           }
                       }
                            
             }
    }

  
  
    



