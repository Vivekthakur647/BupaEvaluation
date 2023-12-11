//
//  ContentViewTest.swift
//  Bupa_AUCitiesTests
//
//  Created by VIVEK THAKUR on 11/12/23.
//

import XCTest
import XCTest
@testable import AUCityViewer

final class ContentViewTest: XCTestCase {
    var viewModel: ViewModel!
    @MainActor func testTotalCountWithSuccess() async {
        viewModel = ViewModel()
        let _: () = await viewModel.loadData()
        let resultCount = viewModel.uscities.count
        XCTAssertEqual(resultCount ,323, "Total record is  matched")// it shroud return 40 record but it return 0.
    }
}

