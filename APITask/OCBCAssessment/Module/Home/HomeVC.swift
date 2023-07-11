//
//  HomeVC.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var accountNoLabel: UILabel!
    @IBOutlet weak var accountHolderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeTransferCustomButton: CustomButton!
    
    //MARK: - Properties
    var presenter: HomePresenter?
    
    lazy var refreshControl : UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return rc
    }()
    
    var tableData : [Date : [TransactionDataResponseModel]] = [:]
}

//MARK: - UIViewController
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
        self.setupTableView()
        self.setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getHomeData()
    }
}

//MARK: - Functions
extension HomeVC {
    
    private func setupNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction))
        self.navigationController?.navigationBar.tintColor = Color.defaultBlack
    }
    
    @objc func logoutAction() {
        self.logout()
    }
    
    private func setupUI(){
        accountInfoView.layer.cornerRadius = accountInfoView.bounds.height/6
        accountInfoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        accountInfoView.addShadow()

        scrollView.refreshControl = refreshControl
        
        self.setupData()
        self.setupCustomButton()
    }
    
    @objc func didPullToRefresh() {
        self.refreshControl.endRefreshing()
        self.presenter?.getHomeData()
    }
    
    private func setupData(){
        let balance = UserData.shared.balance ?? 0
        let accountNo = UserData.shared.accountNo ?? "-"
        let username = UserData.shared.username ?? "-"
        self.moneyLabel.text = CurrencyFormatter.currency(number: balance)
        self.accountNoLabel.text = accountNo
        self.accountHolderLabel.text = username
    }
    
    private func setupCustomButton(){
        self.makeTransferCustomButton.button.addTarget(self, action: #selector(makeTransferCustomButtonAction(sender:)), for: .touchUpInside)
    }
    
    @objc func makeTransferCustomButtonAction(sender: UIButton) {
        self.navigationController?.pushViewController(TransferVC(), animated: true)
    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNIB(with: TransactionCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.reloadTableView()
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            
            if self.tableData.isEmpty {
                self.tableView.setEmptyMessage("No Data")
            }else{
                self.tableView.restore()
            }
        }
    }
    
    private func setupPresenter(){
        self.presenter = HomePresenter(delegate: self)
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: TransactionCell.self)!
        let data = Array(self.tableData)[indexPath.row]
        cell.configure(title: data.key, data: data.value)
        cell.layoutIfNeeded()
        return cell
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeVC: HomePresenterDelegate {
    
    func getBalanceSuccess(model: BalanceResponseModel) {
        guard let balance = model.balance,
              let accountNo = model.accountNo,
              let username = UserData.shared.username
        else { return self.showErrorMessage(message: "Error") }
        UserData.shared.saveBalance(balance)
        UserData.shared.saveAccountNo(accountNo)
        DispatchQueue.main.async {
            self.moneyLabel.text = CurrencyFormatter.currency(number: balance)
            self.accountNoLabel.text = accountNo
            self.accountHolderLabel.text = username
        }
    }
    
    func getTransactions(model: TransactionResponseModel){
        guard let data = model.data else { return self.showErrorMessage(message: "Error") }
        let empty: [Date : [TransactionDataResponseModel]] = [:]
        let groupedData = data.reduce(into: empty) { acc, cur in
            let components = Calendar.current.dateComponents([.day, .year, .month], from: (cur.transactionDate.toDate())!)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        self.tableData = groupedData
        self.reloadTableView()
    }
    
    func fail(error: ErrorType) {
        if error == .missingToken {
            URLSession.shared.invalidateAndCancel()
            self.logout()
        }else{
            self.showErrorMessage(message: error.errorDescription)
        }
    }
    
}
