//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Lu Yu on 7/23/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var fName: String?
    @NSManaged public var lName: String?
    @NSManaged public var number: String?

}
