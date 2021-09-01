//
//  AddVehicalViewController.swift
//  Fuel Mate
//
//  Created by Talha Ghous on 2/5/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class AddVehicalViewController: UIViewController {
    
       let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfFualCapacity: UITextField!
    @IBOutlet weak var tfYear: UITextField!
    @IBOutlet weak var tfModel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveAllData(_ sender: Any) {
        
        if self.tfBrand.text != "" && self.tfFualCapacity.text != "" && self.tfYear.text != "" && self.tfModel.text != "" {
            
            self.saveVehical{(complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }}
        }
    }
    
    func saveVehical(completion: (_ finished:Bool)-> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        let vehical = Vehicle(context: managedContext)
        vehical.brand = tfBrand.text!
        vehical.yearOfManufacturing = Double ( tfYear.text!)!
        vehical.fuelTankCapacity = Double(tfFualCapacity.text!)!
        vehical.model = tfModel.text!
        vehical.uuid = UUID()
        do{
            try managedContext.save()
            completion(true)
        }catch{
            debugPrint("\(error.localizedDescription)")
        }
    }

}
