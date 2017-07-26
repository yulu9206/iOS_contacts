//
//  ViewVC.swift
//  Contacts
//
//  Created by Lu Yu on 7/23/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit
class ViewVC: UIViewController {
    var theContact:Contact?
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {

        if let contact = theContact {
            self.title = contact.fName
            nameLabel.text = "\(String(describing: contact.fName!)) \(String(describing: contact.lName!))"
            numberLabel.text = contact.number
        }
    }
}
