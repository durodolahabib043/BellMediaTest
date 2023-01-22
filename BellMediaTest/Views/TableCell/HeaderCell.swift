//
//  HeaderCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit

class HeaderCell: UIView {
    
    var headerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "Tacoma")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var headerTitle: UILabel = {
        let title = UILabel()
        title.text = "Tacoma 2021"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 40)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var HeaderDescription: UILabel = {
        let description = UILabel()
        description.text = "Get yours Now"
        description.textColor = .white
        description.font = .systemFont(ofSize: 25)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    var titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        addSubview(titleContainer)
        titleContainer.addSubview(headerImageView)
        titleContainer.addSubview(headerTitle)
        titleContainer.addSubview(HeaderDescription)
        setupAutoContrainst()
    }
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoContrainst(){
        NSLayoutConstraint.activate([
            ///titleContainer
            titleContainer.topAnchor.constraint(equalTo: topAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            ///headerImageView
            headerImageView.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 260),
            ///headerTitle
            
            headerTitle.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 20),
            headerTitle.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -20),
            headerTitle.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -60),
            
            
            ///HeaderDescription
            HeaderDescription.leadingAnchor.constraint(equalTo: headerTitle.leadingAnchor),
            HeaderDescription.trailingAnchor.constraint(equalTo: headerTitle.trailingAnchor),
            HeaderDescription.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -30),
            
            
        ])
    }
    
}
