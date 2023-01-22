//
//  CarCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit
import Kingfisher

class CarCell: UITableViewCell {

    
    var carImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    var carMakerLabel: UILabel = {
        let carMakerLabel = UILabel()
        carMakerLabel.text = "carMakerLabel"
        carMakerLabel.translatesAutoresizingMaskIntoConstraints = false
        return carMakerLabel
    }()
    
    
    var carPriceLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.text = "carPriceLabel"
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return carPriceLabel
    }()
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var modelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5.0
        stack.backgroundColor = .orange
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [self.carMakerLabel,
            self.carPriceLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    func setupAutoContrainst() {
        
        let upperView = UIView() //rename
        [self.carImageView,
            self.modelStackView].forEach { upperView.addSubview($0) }
        upperView.backgroundColor = .cyan
        
        let containerView: [UIView] = [upperView]
        let fullStackView = UIStackView(arrangedSubviews: containerView)
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        fullStackView.spacing = 5
        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(fullStackView)
        
//
        NSLayoutConstraint.activate([
            ///container
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            fullStackView.topAnchor.constraint(equalTo: container.topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            fullStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            fullStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
//
            upperView.topAnchor.constraint(equalTo: fullStackView.topAnchor),
            upperView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            upperView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            upperView.bottomAnchor.constraint(equalTo: fullStackView.bottomAnchor),
            
            
            ///carImageView
            carImageView.topAnchor.constraint(equalTo: upperView.topAnchor),
            carImageView.leadingAnchor.constraint(equalTo: upperView.leadingAnchor),
            carImageView.heightAnchor.constraint(equalToConstant: 80),
            carImageView.widthAnchor.constraint(equalToConstant: 130),
            carImageView.trailingAnchor.constraint(equalTo: modelStackView.leadingAnchor, constant: 10),
            carImageView.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: 0),
            
            modelStackView.trailingAnchor.constraint(equalTo: upperView.trailingAnchor)
            
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
        
        
        if let path = Bundle.main.path(forResource: data.carImage, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            let provider = LocalFileImageDataProvider(fileURL: url)
            self.carImageView.kf.indicatorType = .activity
            self.carImageView.kf.setImage(with: provider, options: nil)
        } else {
            self.carImageView.image = UIImage()
        }
        
    }


    struct Data {
        let carName:String
        let carPrice: String
        let carImage: String
        var isExpanded: Bool
    }

}
