//
//  UITableView+Extension.swift
//  DXP Direct Selling
//
//  Created by ivan.martin on 02/11/21.
//

import Foundation
import UIKit

extension UITableView {
    func register(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: className)
    }
    
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
    
    func dequeueCell<T>(with cellClass: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerHeaderFooter(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(cellClass, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func registerHeaderFooterView(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueHeaderFooterView<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: cellClass)) as? T
    }
}

extension UITableView {
    ///Usage
    ///override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    ///     if items.count == 0 {
    ///         self.tableView.setEmptyMessage("My Message")
    ///     } else {
    ///         self.tableView.restore()
    ///     }
    ///         return items.count
    ///     }
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = Color.defaultBlack
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
