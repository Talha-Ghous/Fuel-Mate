//
//  ViewController.swift
//  Fuel Mate
//
//  Created by Talha Ghous on 12/4/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController{

    
    @IBOutlet var mainTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var expensesList:[Expenses] = Array()
    var vehical : Vehicle!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Expenses"
    }
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        mainTableView.reloadData()
    }
    func removeExpense(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(expensesList[indexPath.row])
        do{
            try managedContext.save()
        }catch{
            debugPrint("could not remove: \(error.localizedDescription)")
        }
    }
    
    func fetch (){
        let expenses = vehical.expense
        expensesList = expenses?.allObjects as! [Expenses]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //tableView funtions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expensesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesCell") as? TableViewCell else {
            return UITableViewCell()
        }
        let expenses = expensesList[indexPath.row]
        cell.configureCell(ObjectOfExpecnces: expenses)
        return cell;
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            
            let refreshAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this Row ?.", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.removeExpense(atIndexPath: indexPath)
                self.fetch()
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in

            }))
            
            self.present(refreshAlert, animated: true, completion: nil)

        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddExpenseViewController
        vc.vehicle = self.vehical
    }


}

