//
//  AddExpenseViewController.swift
//  Fuel Mate
//
//  Created by Talha Ghous on 28/4/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit
import CoreData

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var uuidTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var litreTF: UITextField!
    
     let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var datePickerView  : UIDatePicker = UIDatePicker()
    
    var vehicle : Vehicle!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        dateTF.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)

    }
    

    @objc func handleDatePicker(sender: UIDatePicker)  {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateTF.text = dateFormatter.string(from: sender.date)
        datePickerView.removeFromSuperview()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        uuidTF.text = UUID().uuidString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveExpense(_ sender: Any) {
        if litreTF.text != "" && amountTF.text != "" && dateTF.text != "" && locationTF.text != "" && uuidTF.text != "" {
            self.saveExpense{(complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }}
        }
    }
    
    func saveExpense(completion: (_ finished:Bool)-> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        let expense = Expenses(context: managedContext)
        expense.expLitre = Double( litreTF.text!)!
        expense.expAmount = Double (amountTF.text!)!
        expense.expDate =  stringToDate( dateObject: dateTF.text!)
        expense.location = locationTF.text
        expense.uuid = UUID(uuidString: uuidTF.text!)
        expense.vehical = vehicle
      
        do{
            try managedContext.save()
            completion(true)
        }catch{
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func stringToDate(dateObject dateObj: String) -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") 
        let date = dateFormatter.date(from:dateObj)!
        return date
    }
  

}
