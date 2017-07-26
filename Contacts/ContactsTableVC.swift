//
//  ContactsTableVC.swift
//  Contacts
//
//  Created by Lu Yu on 7/23/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableVC: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var allContacts = [Contact]()
    
    override func viewDidLoad() {
        fetchAllContacts()
    }
    
    func fetchAllContacts() {
        do {
            let results = try context.fetch(Contact.fetchRequest())
            allContacts = results as! [Contact]
            print("fetched", allContacts.count)
        } catch {
            print(error)
        }
    }
    
    @IBAction func cancelSegue(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveSegue(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! DetailViewController
        var theContact: Contact?
        if let indexPath = controller.indexPath {
            theContact = allContacts[indexPath.row]
        } else {
            theContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context) as? Contact
        }
        do {
            theContact?.fName = controller.fNameText.text!
            theContact?.lName = controller.lNameText.text!
            theContact?.number = controller.numberText.text!
            print("Success, \(String(describing: theContact)) added!")
            try context.save()
        } catch {
            print("Failure to save: \(error)")
        }
        fetchAllContacts()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        let cellText = allContacts[indexPath.row].fName! + " " + allContacts[indexPath.row].lName!
        cell.textLabel?.text = cellText
        cell.detailTextLabel?.text = allContacts[indexPath.row].number!
        cell.detailTextLabel?.textColor = UIColor.blue
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        
        let viewActionButton = UIAlertAction(title: "View", style: .default) { _ in
//            print("View")
            self.performSegue(withIdentifier: "viewSegue", sender: indexPath)
        }
        actionSheetControllerIOS8.addAction(viewActionButton)
        
        let editActionButton = UIAlertAction(title: "Edit", style: .default)
        { _ in
//            print("Edit")
            self.performSegue(withIdentifier: "editSegue", sender: indexPath)
        }
        actionSheetControllerIOS8.addAction(editActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Delete", style: .default)
        { _ in
//            print("Delete")
            let theContact = self.allContacts.remove(at: indexPath.row)
            self.context.delete(theContact)
            do {
                try self.context.save()
                print("\(String(describing: theContact)) deleted")
            } catch {
                print("Error in deleting \(String(describing: theContact))")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.fetchAllContacts()
            tableView.reloadData()
            
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
//            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editSegue" {
            let indexPath = sender as! NSIndexPath
            let navigationController = segue.destination as! UINavigationController
            let detailViewController = navigationController.topViewController as! DetailViewController
            detailViewController.theContact = allContacts[indexPath.row]
            detailViewController.indexPath = indexPath
        } else if segue.identifier == "viewSegue" {
            let indexPath = sender as! NSIndexPath
            let navigationController = segue.destination as! UINavigationController
            let viewViewController = navigationController.topViewController as! ViewVC
            viewViewController.theContact = allContacts[indexPath.row]
        }
    }
}
