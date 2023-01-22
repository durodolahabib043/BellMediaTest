//
//  CarViewModel.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import Foundation

protocol CarViewModelling: AnyObject {
    func fetchCarDetails() async
    var  displaySectionData: ((_ data: [Section<SectionType>]) -> Void)? {get set}
}


class CarViewModel : CarViewModelling {
    var displaySectionData: (([Section<SectionType>]) -> Void)?
    
    let carService: CarsProtocol
    
    init(carService: CarsProtocol = CarService()){
        self.carService = carService
    }
    func fetchCarDetails() async {
        let result =  await carService.getCars(fileName: "car_list")
        
        switch result {
        case .success(let car):
            print("\(car.count)")
            let cars = getListOfCars(car: car)
            displaySectionData?([.init(rows: cars)
                                ])
        case .failure(let err):
            print("err") // todo
        }
        
    }
    
    func getListOfCars(car: [Car])-> [SectionType] {
        return   car.map{(
            SectionType.CarSection(data: .init(carName: $0.make, carPrice: $0.model, carImage: $0.image, isExpanded: false))
        )}
    }
    
}

struct Section<T> {
    var rows: [T] = []
}


enum SectionType {
    case CarSection(data: CarCell.Data)
}