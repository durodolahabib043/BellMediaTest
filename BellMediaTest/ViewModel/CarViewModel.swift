//
//  CarViewModel.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import Foundation

protocol CarViewModelling: AnyObject {
    func fetchCarDetails() async
}


class CarViewModel : CarViewModelling {
    let carService: CarsProtocol
    
    init(carService: CarsProtocol = CarService()){
        self.carService = carService
    }
    func fetchCarDetails() async {
      let result =  await carService.getCars(fileName: "")
      
    }
    
}
