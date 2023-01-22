//
//  CarFilterCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit

class CarFilterCell: UITableViewCell {
    
    var filterLabel: UILabel = {
        let filterLabel = UILabel()
        filterLabel.text = "Filter "
       // filter.textColor = .white
        //title.font = UIFont.boldSystemFont(ofSize: 40)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        return filterLabel
    }()
    
    var carMakerTextField: UITextField = {
        let carMakerTextField = UITextField()
        carMakerTextField.translatesAutoresizingMaskIntoConstraints = false
        return carMakerTextField
    }()
    
    var carModelTextField: UITextField = {
        let carModelTextField = UITextField()
        carModelTextField.translatesAutoresizingMaskIntoConstraints = false
        return carModelTextField
    }()
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupAutoContrainst() {
        
        let containerView: [UIView] = [filterLabel, carMakerTextField, carModelTextField]
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

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
