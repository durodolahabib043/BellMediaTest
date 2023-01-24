//
//  ViewController.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 750
        tableView.separatorStyle = .none
        return tableView
        
    }()
    let carViewModel: CarViewModelling
    
    private var sectionsData: [Section<SectionType>] = []
    private var expandedIndexPath: IndexPath?
    let cellIndentifier = "cellId"
    let separatorCellIndentifier = "separatorCellIndentifier"
    let filterCellIndentifier = "filterCellIndentifier"
    
    
    init(carViewModel: CarViewModelling = CarViewModel()){
        self.carViewModel = carViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "GUIDOMIA"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor().bellOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        configureView()
        getCarList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    //
    func getCarList() {
        
        carViewModel.displaySectionData = { [weak self] sectionData in
            self?.sectionsData = sectionData
            DispatchQueue.main.async {
                self?.expandedIndexPath = IndexPath(row: 0, section: 1)
                self?.tableView.reloadData()
            }
            
        }
        Task {
            await carViewModel.fetchCarDetails()
        }
    }
    
    
    private func configureView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = HeaderCell()
        tableView.tableHeaderView = header
        
        tableView.register(CarCell.self, forCellReuseIdentifier: cellIndentifier)
        tableView.register(SeparatorCell.self, forCellReuseIdentifier: separatorCellIndentifier)
        tableView.register(CarFilterCell.self, forCellReuseIdentifier: filterCellIndentifier)
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            header.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            header.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 10),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutTableHeader()
    }
}



extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.sectionsData[indexPath.section].rows[indexPath.row]
        
   
        
        switch row {
        case let .CarSection(data: data):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! CarCell
            cell.selectionStyle = .none
            cell.configure(data: data)
            return cell
            
        case .SeparationSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: separatorCellIndentifier, for: indexPath) as! SeparatorCell
            return cell
        case let .FilterSection(data: data):
            let cell = tableView.dequeueReusableCell(withIdentifier: filterCellIndentifier, for: indexPath) as! CarFilterCell
            cell.configure(data: data, delegate: self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.sectionsData[indexPath.section].rows[indexPath.row]
        
        switch row {
        case var .CarSection(data: data):
            print(data.carName)
            data.isExpanded.toggle()
            self.sectionsData[indexPath.section].rows[indexPath.row] = .CarSection(data: data)
            // We need to collapse the previously expanded item
            if let expandedIndexPath = self.expandedIndexPath, expandedIndexPath != indexPath {
                let previousExpandedRow = self.sectionsData[expandedIndexPath.section].rows[expandedIndexPath.row]
                switch previousExpandedRow {
                case var .CarSection(data: data):
                    data.isExpanded = false
                    self.sectionsData[expandedIndexPath.section].rows[expandedIndexPath.row] = .CarSection(data: data)
                default: break
                }
            }
            tableView.reloadRows(at: [indexPath, expandedIndexPath].compactMap({ $0 }), with: .automatic)
            self.expandedIndexPath = data.isExpanded ? indexPath : nil
        default:
            break
        }
        
    }
    
}

extension UITableView {
    func layoutTableHeader(autoLayout: Bool = false) {
        
        guard let headerView = tableHeaderView else {
            
            return
            
        }
        let oldSize = headerView.frame.size
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let newSize: CGSize
        if autoLayout {
            // If autoLayout is enabled(when translatesAutoresizingMaskIntoConstraints = false), sizeThatFits provides more accurate result
            newSize = headerView.sizeThatFits(CGSize(width: oldSize.width, height: CGFloat.greatestFiniteMagnitude))
            
        } else {
            newSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        }
        if oldSize.height != newSize.height {
            headerView.frame.size.height = newSize.height
            tableHeaderView = headerView
        }
        layoutIfNeeded()
        
    }
}

extension ViewController: FilterCellDelegate {
    func didSelectCarMake(value: String?) {
        carViewModel.didSelectCarModel(make: value, model: nil)
    }
    
    func didSelectCarModel(value: String?) {
        carViewModel.didSelectCarModel(make: nil, model: value)
    }
}





