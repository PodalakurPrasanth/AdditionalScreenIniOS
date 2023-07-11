//
//  TransactionDetailCell.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import UIKit

class TransactionDetailCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountNoLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

//MARK: UITableViewCell
extension TransactionDetailCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


//MARK: Functions
extension TransactionDetailCell{
    func configure(model: TransactionDataResponseModel){
        self.nameLabel.text = model.receipient.accountHolder
        self.accountNoLabel.text = model.receipient.accountNo
        if model.transactionType.lowercased() == "transfer"{
            self.amountLabel.text = "- " + CurrencyFormatter.currency(number: model.amount)
            self.amountLabel.textColor = Color.subheading
        }else{
            self.amountLabel.text = CurrencyFormatter.currency(number: model.amount)
            self.amountLabel.textColor = Color.successGreen
        }
    }
}
