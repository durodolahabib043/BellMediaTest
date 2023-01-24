//
//  CarCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit
import Kingfisher
import Cosmos

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
        carMakerLabel.translatesAutoresizingMaskIntoConstraints = false
        return carMakerLabel
    }()
    
    
    var carPriceLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return carPriceLabel
    }()
    
    var prosLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.text = "Pros"
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return carPriceLabel
    }()

    
    var ratingView: CosmosView = {
        let ratingView = CosmosView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()
 
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().bellLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var modelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [self.carMakerLabel,
            self.carPriceLabel,
         self.ratingView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    var prosConsView: UIView = {
        let prosConsView = UIView()
        prosConsView.translatesAutoresizingMaskIntoConstraints = false
        return prosConsView
    }()
    
    lazy var prosConsPStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    var consLabel: UILabel = {
        let consLabel = UILabel()
        consLabel.text = "Cons"
        consLabel.translatesAutoresizingMaskIntoConstraints = false
        return consLabel
    }()
    
    lazy var  consStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()

    
    func setupAutoContrainst() {
        
        let upperView = UIView() 
        [self.carImageView,
            self.modelStackView
         ].forEach { upperView.addSubview($0) }
        upperView.backgroundColor = UIColor().bellLightGray
        [self.prosLabel,
            self.prosConsPStackView,
         self.consLabel,
         self.consStackView
         ].forEach { prosConsView.addSubview($0) }
 
        
        let containerView: [UIView] = [upperView, prosConsView]
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

            fullStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            fullStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            fullStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            fullStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            
//
            upperView.topAnchor.constraint(equalTo: fullStackView.topAnchor),
            upperView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            upperView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            upperView.bottomAnchor.constraint(equalTo: prosConsView.topAnchor),
            ///prosConsView
          //  prosConsView.topAnchor.constraint(equalTo: fullStackView.topAnchor),
            prosConsView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            prosConsView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            prosConsView.bottomAnchor.constraint(equalTo: fullStackView.bottomAnchor),
            
            prosConsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            prosLabel.leadingAnchor.constraint(equalTo: prosConsView.leadingAnchor, constant: 20),
            prosLabel.trailingAnchor.constraint(equalTo: prosConsView.trailingAnchor, constant: 20),
            prosLabel.topAnchor.constraint(equalTo: prosConsView.topAnchor),
            prosLabel.bottomAnchor.constraint(equalTo: prosConsPStackView.topAnchor, constant: -10),
            
            prosConsPStackView.leadingAnchor.constraint(equalTo: prosConsView.leadingAnchor),
            prosConsPStackView.bottomAnchor.constraint(equalTo: consLabel.topAnchor, constant: -10),
            prosConsPStackView.trailingAnchor.constraint(equalTo: prosConsView.trailingAnchor),
            
            consLabel.leadingAnchor.constraint(equalTo: prosConsView.leadingAnchor, constant: 20),
            consLabel.trailingAnchor.constraint(equalTo: prosConsView.trailingAnchor, constant: 20),

            consStackView.topAnchor.constraint(equalTo: consLabel.bottomAnchor, constant: 10),
            consStackView.bottomAnchor.constraint(equalTo: prosConsView.bottomAnchor, constant: -10),
            consStackView.leadingAnchor.constraint(equalTo: prosConsView.leadingAnchor),
            consStackView.trailingAnchor.constraint(equalTo: prosConsView.trailingAnchor),
              
            ///carImageView
            carImageView.topAnchor.constraint(equalTo: upperView.topAnchor),
            carImageView.leadingAnchor.constraint(equalTo: upperView.leadingAnchor),
            carImageView.heightAnchor.constraint(equalToConstant: 80),
            carImageView.widthAnchor.constraint(equalToConstant: 130),
            carImageView.trailingAnchor.constraint(equalTo: modelStackView.leadingAnchor, constant: -20),
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
        self.carPriceLabel.text = "Price: \(data.carPrice)"
        self.ratingView.rating = data.carRating
        
        
        
        if let path = Bundle.main.path(forResource: data.carImage, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            let provider = LocalFileImageDataProvider(fileURL: url)
            self.carImageView.kf.indicatorType = .activity
            self.carImageView.kf.setImage(with: provider, options: nil)
        } else {
            self.carImageView.image = UIImage()
        }
        
        self.prosConsView.isHidden = !data.isExpanded
        if data.isExpanded {
            self.prosConsPStackView.removeArrangedSubviews(where: { $0 is BulletPoint })
            self.consStackView.removeArrangedSubviews(where: { $0 is BulletPoint })

            self.prosConsPStackView.isHidden = data.carProsList.isEmpty
            self.consStackView.isHidden = data.carConsList.isEmpty

            let cleanProsData = data.carProsList.filter({!$0.isEmpty})
            let cleanConsData = data.carConsList.filter({!$0.isEmpty})
            
            self.prosConsPStackView.addArrangedSubviews(views: cleanProsData.map({
                let bulletPoint = BulletPoint(frame: .zero)
                bulletPoint.configure(text: $0)
                return bulletPoint
            }))
            self.consStackView.addArrangedSubviews(views: cleanConsData.map({
                let bulletPoint = BulletPoint(frame: .zero)
                bulletPoint.configure(text: $0)
                return bulletPoint
            }))
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        
    }


    struct Data {
        let carName:String
        let carPrice: String
        let carImage: String
        var isExpanded: Bool
        let carRating: Double
        let carProsList: [String]
        let carConsList: [String]
    }

}
