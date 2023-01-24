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
    func getListOfCars(car: [Car])-> [SectionType]
    func getFilteredCar(cars: [Car]) -> SectionType
    func didSelectCarModel(make: String?, model: String?)
}


class CarViewModel : CarViewModelling {
    var cars: [Car]?
    var displaySectionData: (([Section<SectionType>]) -> Void)?
    
    let carService: CarsProtocol
    
    init(carService: CarsProtocol = CarService()){
        self.carService = carService
    }
    func fetchCarDetails() async {
        let result =  await carService.getCars(fileName: "car_list")
        switch result {
        case .success(let car):
            self.cars = car.map { $0 }
            let cars = getListOfCars(car: car)// here to get all call
            let refilterCars = getFilteredCar(cars: car)
            displaySectionData?([
                .init(rows: [refilterCars]),
                .init(rows: cars)
            ])
        case .failure(let err):
            print("err") // todo
        }
        
    }
    
    func getListOfCars(car: [Car])-> [SectionType] {
        
        var mergedCar = car.flatMap({
            [  SectionType.CarSection(data: .init(carName: $0.model, carPrice: "\($0.customerPrice / 1000)K", carImage: $0.image, isExpanded: false, carRating: Double($0.rating), carProsList: $0.prosList, carConsList: $0.consList)), SectionType.SeparationSection]
        })
        
        
        switch mergedCar.first {
        case var .CarSection(data: data):
            data.isExpanded = true
            mergedCar[0] = .CarSection(data: data)
        default:
            break
        }
        return mergedCar
    }
    
    func getFilteredCar(cars: [Car]) -> SectionType {
        return .FilterSection(data: .init(carMakes: cars.map({$0.make}), carModels: cars.map({$0.model})))
    }
    
    func didSelectCarModel(make: String?, model: String?) {
        guard  let filterCar = self.cars else {return}
        let filter = filterCar.filter({
            if let filteringMake = make, $0.make != filteringMake{
                return false
            }
            if let filteringModel = model, $0.model != filteringModel {
                return false
            }
            return true
        })
        
        let cars = getListOfCars(car: filter)
        let resultOfFilteredCar = getFilteredCar(cars: filterCar)
        
        displaySectionData?([
            .init(rows: [resultOfFilteredCar]),
            .init(rows: cars)
        ])
    }
    
    
}

struct Section<T> {
    var rows: [T] = []
}


enum SectionType {
    case CarSection(data: CarCell.Data)
    case FilterSection(data: CarFilterCell.Data)
    case SeparationSection
}
