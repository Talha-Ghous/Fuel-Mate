//
//  TableViewCell.swift
//  Fuel Mate
//
//  Created by Talha Ghous on 28/4/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
   
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var litre: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(ObjectOfExpecnces expense:Expenses)  {
        self.amount.text =  "Total Amount = $\(expense.expAmount)"
        self.litre.text = "Total Litre = \(expense.expLitre)"
        self.date.text = "Date = "+dateToString(theDate: expense.expDate!)
        self.location.text = "Location = "+expense.location!
    }
    
    func dateToString(theDate date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
