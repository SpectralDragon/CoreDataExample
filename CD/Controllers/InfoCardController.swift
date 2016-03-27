//
//  InfoCardController.swift
//  CoreData Example
//
//  Created by Vladislav on 24.03.16.
//  Copyright © 2016 Vladislav Prusakov. All rights reserved.
//

import UIKit
import CoreData

private let coreDataHelper = CoreDataHelper()
private let context = coreDataHelper.managedObjectContext

class InfoCardController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var secondNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var notesField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.target = self
        saveButton.action = #selector(saveInfoAboutPersone)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveInfoAboutPersone() {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Profile", inManagedObjectContext: context) as! Profile
        
        //set value in CoreData
        newItem.setValue(firstNameField.text, forKey: "firstName")
        newItem.setValue(secondNameField.text, forKey: "secondName")
        newItem.setValue(emailField.text, forKey: "email")
        newItem.setValue(notesField.text, forKey: "notes")
        
        do {
            try context.save()
            
            //sends a signal to update table
            NSNotificationCenter.defaultCenter().postNotificationName("updateTable", object: nil)
            
            //return to root view
            navigationController?.popToRootViewControllerAnimated(true)
        } catch let error as NSError {
            NSLog("saved error \(error), \(error.userInfo)")
        }
    }

}

