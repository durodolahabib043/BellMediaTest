//
//  BellMediaTestTests.swift
//  BellMediaTestTests
//
//  Created by Habib Durodola on 1/21/23.
//

import XCTest
@testable import BellMediaTest

class BellMediaTestTests: XCTestCase {
    
    var mockModel : CarViewModelMocks!

    override func setUpWithError() throws {
       try super.setUpWithError()
        mockModel = CarViewModelMocks()
    }
    
    override func tearDownWithError() throws {
        mockModel = nil
    }

    func testCarModel() throws {
        let exp = expectation(description: "Testing")
        mockModel.displaySectionData = { sectionData in
            XCTAssertEqual(sectionData.count, 2)
            let row = sectionData[0].rows[0]
            switch row {
            case let .CarSection(data: data):
                XCTAssertEqual(data.carName, "Land Rover" , "test car make " )
                XCTAssertEqual(data.isExpanded,  false, "test car isExpanded " )
                XCTAssertEqual(data.carConsList.count, 1 , "test car carConsList " )
                XCTAssertEqual(data.carRating, 3 , "test car rating " )
            default :
                break
            }
            
            exp.fulfill()
        }
        
        Task{
            await mockModel.fetchCarDetails()
        }
        waitForExpectations(timeout: 3)
    }

}


class MockCarService : CarsProtocol {
    func getCars(fileName: String) async -> Result<[BellMediaTest.Car], Error> {
        return Result.success([Car(consList: ["bad"], customerPrice: 1000, make: "Land Rover", marketPrice: 1000, model: "Range Rover", prosList: ["good"], rating: 3, image: "")])
    }
}

class CarViewModelMocks : CarViewModelling {
    
    let carService: CarsProtocol
    
    var displaySectionData: (([BellMediaTest.Section<BellMediaTest.SectionType>]) -> Void)?
   
    
    init(carService: CarsProtocol =  MockCarService()){
        self.carService = carService
    }
    
    func fetchCarDetails() async {
        
        let result =  await carService.getCars(fileName: "car_list")
        
        switch result {
        case .success(let car):
            let cars = getListOfCars(car: car)
            let refilterCars = getFilteredCar(cars: car)
            displaySectionData?([
                .init(rows: [refilterCars]),
                .init(rows: cars)
            ])
        case .failure(let err):
            print("err") // todo
        }

        await carService.getCars(fileName: "")
    }
    
    
    
    func getListOfCars(car: [BellMediaTest.Car]) -> [BellMediaTest.SectionType] {
        [SectionType.CarSection(data: .init(carName: "Land Rover", carPrice: "1000", carImage: "", isExpanded: false, carRating: 3.0, carProsList: ["good"], carConsList: ["bad"]))
]
    }
    
    func getFilteredCar(cars: [BellMediaTest.Car]) -> BellMediaTest.SectionType {
        SectionType.CarSection(data: .init(carName: "Land Rover", carPrice: "1000", carImage: "", isExpanded: false, carRating: 3.0, carProsList: ["good"], carConsList: ["bad"]))
    }
    
    func didSelectCarModel(make: String?, model: String?) {
        
    }
    
}
