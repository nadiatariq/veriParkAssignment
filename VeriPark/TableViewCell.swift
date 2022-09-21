//
//  TableViewCell.swift
//  VeriPark
//
//  Created by sameeltariq on 09/09/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var previous: UILabel!
    
    @IBOutlet weak var totalBillOfConsumption: UILabel!
    
    @IBOutlet weak var serviceNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
