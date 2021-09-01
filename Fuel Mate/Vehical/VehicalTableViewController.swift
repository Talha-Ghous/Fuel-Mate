//
//  VehicalTableViewController.swift
//  Fuel Mate
//
//  Created by Talha Ghous on 2/5/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit
import CoreData
import CoreSpotlight
import MobileCoreServices

class VehicalTableViewController: UITableViewController {

    @IBOutlet var vehicalTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
     var vehicalList:[Vehicle] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        self.title = "Fual Mate"
        setupSearchableContent()
    }
    
    
    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        var uniqeId = 0
        for vehical:Vehicle in vehicalList{
            if let expenses = vehical.expense{
                let  expensesList = expenses.allObjects as! [Expenses]
                for expense:Expenses in expensesList{
                   
                    let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
                    
                    searchableItemAttributeSet.title = "Amount = \(expense.expAmount)"
                    searchableItemAttributeSet.contentDescription = "Location = \(expense.location!)"
                   
                    var keywords = [String]()
                    keywords.append(vehical.model!)
                    keywords.append(expense.location!)
                    
                    searchableItemAttributeSet.keywords = keywords
                    let searchableItem = CSSearchableItem(uniqueIdentifier: "com.Fuel Mate.\(uniqeId)", domainIdentifier:  "Fuel Mate",attributeSet: searchableItemAttributeSet)
                    uniqeId = uniqeId + 1
                    searchableItems.append(searchableItem)
                    
                }
            }
            
        }
        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            }}
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        vehicalTableView.reloadData()
    }
    func fetch ()-> Bool{
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        let fetchRequest = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        do{
            vehicalList = try managedContext.fetch(fetchRequest)
            return true
        }catch{
            debugPrint("could not remove: \(error.localizedDescription)")
            return false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vehicalList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VEHICLECELL", for: indexPath) as? VehicalTableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "VEHICLECELL", for: indexPath)}
        
        cell.configureCel(obj: self.vehicalList[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        myVC.vehical = self.vehicalList[indexPath.row]
        navigationController?.pushViewController(myVC, animated: true)
    }
}
