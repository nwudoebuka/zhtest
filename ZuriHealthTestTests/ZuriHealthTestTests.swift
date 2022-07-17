//
//  ZuriHealthTestTests.swift
//  ZuriHealthTestTests
//
//  Created by ANTHONY NWUDO WEMABANK on 16/07/2022.
//

import XCTest
@testable import ZuriHealthTest

class ZuriHealthTestTests: XCTestCase {
  var viewModel : ItemsViewModel!
  var mockNetworkingService: MockService!
  
  override func setUp()  {
      super.setUp()
      mockNetworkingService = MockService()
      viewModel = ItemsViewModel.init(apiLoader: mockNetworkingService)
  }
  
  override func tearDown()  {
      viewModel = nil
      mockNetworkingService = nil
      super.tearDown()
  }
  
  func test_getReferrals() {
      viewModel.getItems()
      mockNetworkingService.getAllItemsSuccess()
      //Here we check if the method in the network service was indeed called
      XCTAssert(mockNetworkingService.didCallGetAllItems)
    XCTAssertNotNil(viewModel.items)
  }
  
  func test_getReferralsFailure() {
      viewModel.getItems()
      mockNetworkingService.getAllItemsFailure()
      //Here we check if the method in the network service was indeed called
      XCTAssert(mockNetworkingService.didCallGetAllItems)
      XCTAssertNotNil(viewModel.items)
  }
  

}
