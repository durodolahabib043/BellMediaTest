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
        tableView.estimatedRowHeight = 300
        return tableView
        
    }()
    let carViewModel: CarViewModelling
    
    private var sectionsData: [Section<SectionType>] = []
    let cellIndentifier = "cellId"
    
    
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
        
        configureView()
        getCarList()
        
    }
    
    func getCarList() {
        
        carViewModel.displaySectionData = { [weak self] sectionData in
            self?.sectionsData = sectionData
            DispatchQueue.main.async {
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


