//
//  ViewController.swift
//  Contacts
//
//  Created by Lu Yu on 7/23/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var indexPath: NSIndexPath?
    var theContact:Contact?
    @IBOutlet weak var fNameText: UITextField!
    @IBOutlet weak var lNameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    
    func populateContact() {
        if let contact = theContact {
            self.title = "Edit Contact"
            fNameText.text = contact.fName
            lNameText.text = contact.lName
            numberText.text = contact.number
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateContact()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


