//
//  Profile+CoreDataProperties.swift
//  CoreData Example
//
//  Created by Vladislav on 24.03.16.
//  Copyright © 2016 Vladislav Prusakov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Profile {
    
    @NSManaged var firstName: String?
    @NSManaged var secondName: String?
    @NSManaged var email: String?
    @NSManaged var notes: String?

}
