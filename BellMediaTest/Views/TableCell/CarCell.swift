//
//  CarCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit

class CarCell: UITableViewCell {

    
    var carMakerLabel: UILabel = {
        let carMakerLabel = UILabel()
        carMakerLabel.translatesAutoresizingMaskIntoConstraints = false
        return carMakerLabel
    }()
    
    
    var carPriceLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return carPriceLabel
    }()
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupAutoContrainst() {
        
        let containerView: [UIView] = [carMakerLabel, carPriceLabel]
        let fullStackView = UIStackView(arrangedSubviews: containerView)
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        fullStackView.spacing = 5
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(fullStackView)
        
        NSLayoutConstraint.activate([
            ///container
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fullStackView.topAnchor.constraint(equalTo: container.topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
    }
    
    func setupViews() {
           addSubview(container)
           setupAutoContrainst()
       }
    
    // MARK: - INIT
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupViews()
       }

       @available(*, unavailable)
       required init?(coder _: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    public func configure(data: Data) {

        self.carMakerLabel.text = data.carName
        self.carPriceLabel.text = data.carPrice
    }


    struct Data {
        let carName:String
        let carPrice: String
        var isExpanded: Bool
    }

}
