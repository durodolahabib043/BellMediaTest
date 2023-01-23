//
//  SeparatorCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/22/23.
//

import UIKit

class SeparatorCell: UITableViewCell {
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews() {
        addSubview(container)
        container.addSubview(separatorView)
        setupAutoContrainst()
    }
    func setupAutoContrainst() {
        
        NSLayoutConstraint.activate([
            ///container
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 50),
            ////separatorView
            separatorView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            separatorView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            separatorView.heightAnchor.constraint(equalToConstant: 4),
            separatorView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            
        ])
        
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
    
}
