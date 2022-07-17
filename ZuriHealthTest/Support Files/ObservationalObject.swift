//
//  ObservationalObject.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation

class ObservationalObject<T>{
  
  var value: T?
  // we could make our listeners an array for multiple classes can observe
  private var listener: ((T?) -> Void)?
  init(_ value: T?){
    self.value = value
  }
  
  func bind(_ listener: @escaping(T?) -> Void){
    listener(value)
    self.listener = listener
  }
  
}
