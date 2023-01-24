//
//  CarFilterCell.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit

class CarFilterCell: UITableViewCell, UITextFieldDelegate {
    
    private var carMakes: [String]?
    private var carModels: [String]?
    
    weak var delegate: FilterCellDelegate?
    
    var filterLabel: UILabel = {
        let filterLabel = UILabel()
        filterLabel.text = "Filter "
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        return filterLabel
    }()
    
    var carMakerTextField: UITextField = {
        let carMakerTextField = UITextField()
        carMakerTextField.translatesAutoresizingMaskIntoConstraints = false
        carMakerTextField.backgroundColor = UIColor.white
        carMakerTextField.borderStyle = UITextField.BorderStyle.roundedRect
        carMakerTextField.keyboardType = .emailAddress
        carMakerTextField.placeholder = "Any Maker"
        carMakerTextField.isUserInteractionEnabled = true
        return carMakerTextField
    }()
    
    var carModelTextField: UITextField = {
        let carModelTextField = UITextField()
        carModelTextField.translatesAutoresizingMaskIntoConstraints = false
        carModelTextField.backgroundColor = UIColor.white
        carModelTextField.borderStyle = UITextField.BorderStyle.roundedRect
        carModelTextField.keyboardType = .emailAddress
        carModelTextField.placeholder = "Any Model"
        carModelTextField.isUserInteractionEnabled = true
        return carModelTextField
        
    }()
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().bellDarkGray
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carMakePickerView = UIPickerView()
    private let carModelPickerView = UIPickerView()
 
    func setupAutoContrainst() {
        
        let containerView: [UIView] = [filterLabel, carMakerTextField, carModelTextField]
        let fullStackView = UIStackView(arrangedSubviews: containerView)
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        fullStackView.spacing = 15
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(fullStackView)
        
        layer.cornerRadius = 7
        NSLayoutConstraint.activate([
            
            ///container
            container.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
 
            fullStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            fullStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 25),
            fullStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -25),
            fullStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
        ])
        
    }
    
    func setupViews() {
        contentView.addSubview(container)
        carMakePickerView.delegate = self
        carModelPickerView.delegate = self
        carMakerTextField.delegate = self
        carModelTextField.delegate = self
        carMakerTextField.inputView = carMakePickerView
        carModelTextField.inputView = carModelPickerView
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
    
    
    func configure(data: Data, delegate: FilterCellDelegate ) {
        self.delegate = delegate
        self.carMakes = data.carMakes
        self.carModels = data.carModels
    }
    
    struct Data {
        let carMakes: [String]
        let carModels: [String]
    }
    
}

extension CarFilterCell : UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.carMakePickerView:
            return self.carMakes?.count ?? 0
        case self.carModelPickerView:
            return self.carModels?.count ?? 0
        default: return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.carMakePickerView:
            return self.carMakes?[row] ?? ""
        case self.carModelPickerView:
            return self.carModels?[row] ?? ""
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.carMakePickerView:
            self.carMakerTextField.text = self.carMakes?[row]
            self.carMakerTextField.resignFirstResponder()
            self.delegate?.didSelectCarMake(value: self.carMakes?[row])
        case self.carModelPickerView:
            self.carModelTextField.text = self.carModels?[row]
            self.carModelTextField.resignFirstResponder()
            self.delegate?.didSelectCarModel(value: self.carModels?[row])
        default: break
        }
    }
}

extension CarFilterCell {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

protocol FilterCellDelegate: AnyObject {
    func didSelectCarMake(value: String?)
    func didSelectCarModel(value: String?)
}


