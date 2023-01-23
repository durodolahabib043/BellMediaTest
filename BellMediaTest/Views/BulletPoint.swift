//
//  BulletPoint.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/22/23.
//

import UIKit

class BulletPoint: UIView {
    var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    var point: UIView = {
        let point = UIView()
        point.backgroundColor = UIColor().bellOrange
        point.translatesAutoresizingMaskIntoConstraints = false
        return point
    }()
    
    var title: UILabel = {
        let title = UILabel()
        title.text = "carPriceLabel"
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
       addSubview(container)
        [point,title].forEach({
            container.addSubview($0)
        })
        self.container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.point.layer.cornerRadius = 5
        self.point.clipsToBounds = false
        addAutolayout()
    }
    
    func addAutolayout(){
        
        NSLayoutConstraint.activate([
            ///container
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            ////point
            point.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            point.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            point.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -20),
            point.heightAnchor.constraint(equalToConstant: 10),
            point.widthAnchor.constraint(equalToConstant: 10),
            
            ////title
            title.topAnchor.constraint(equalTo: container.topAnchor),
            title.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])

    }
    
    public func configure(text: String) {
        
        self.title.text = text
    }
}
