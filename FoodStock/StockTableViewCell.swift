//
//  StockTableViewCell.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/05/28.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var preLabel: UILabel!
    @IBOutlet var numTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
