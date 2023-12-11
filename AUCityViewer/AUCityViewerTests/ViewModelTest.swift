//
//  ViewModelTest.swift
//  Bupa_AUCitiesTests
//
//  Created by VIVEK THAKUR on 08/12/23.
//

import XCTest
@testable import AUCityViewer
final class ViewModelTest: XCTestCase {
    @MainActor func testloadData() async {
        let viewModel = ViewModel()
        let response: () = await viewModel.loadData()
        XCTAssertNotNil(response) // Asserting for response to verify nil response
    }
    
    func testMockedAuthors() async throws {
        let viewModel = await ViewModel()
        let _: () = await viewModel.loadData()
        for item in await viewModel.uscities {
            if let city = item.city {
                XCTAssertNotNil(city) // verifing as in api response city name
            }
        }
    }
    func testMockedArticalsTitle() async throws {
        let viewModel = await ViewModel()
        let _: () = await viewModel.loadData()
        for item in await viewModel.uscities {
            if let country = item.country {
                XCTAssertNotNil(country)
            }
        }
    }
    func testMockedSortedResponse() async throws {
        let viewModel = await ViewModel()
        let _: () = await viewModel.loadData()
        await viewModel.groupData(unsortedCity: viewModel.uscities)
        for item in await viewModel.sortedResponse {
            if let country = item.adminNameSection {
                XCTAssertNotNil(country)
            }
        }
    }
    func testMockedArticalsDescription() async throws {
        let viewModel = await ViewModel()
        let _: () = await viewModel.loadData()
        for item in await viewModel.uscities {
            if let cap = item.capital {
                XCTAssertNotNil(cap)
            }
        }
    }
}
