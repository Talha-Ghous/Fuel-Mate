//
//  VehicalTableViewCell.swift
//  Fuel Mate
//
//  Created by Talha Ghous on 2/5/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class VehicalTableViewCell: UITableViewCell {
   
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var yearOfManufacturing: UILabel!
    @IBOutlet weak var tankCapacity: UILabel!
    @IBOutlet weak var model: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCel(obj vehicleObject:Vehicle)  {
        brand.text = "Vehical Brand = \(vehicleObject.brand!)"
        yearOfManufacturing.text = "Year = \(vehicleObject.yearOfManufacturing)"
        tankCapacity.text = "Fual Tank = \(vehicleObject.fuelTankCapacity)"
        model.text = "Model = \(vehicleObject.model!)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
