//
//  TransactionCell.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import UIKit

class TransactionCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var container: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: DynamicHeightTableView!
    //MARK: Properties
    
    var tableData: [TransactionDataResponseModel] = []
}

//MARK: UITableViewCell
extension TransactionCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: Functions
extension TransactionCell{
    private func setupUI(){
        self.container.layer.cornerRadius = 10
        self.container.addShadow()
    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNIB(with: TransactionDetailCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configure(title: Date, data : [TransactionDataResponseModel]){
        self.titleLabel.text = title.toString()
        self.tableData = data
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.layoutIfNeeded()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TransactionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: TransactionDetailCell.self)!
        cell.configure(model: self.tableData[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
}
