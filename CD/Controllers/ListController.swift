
//
//  ViewController.swift
//  CoreData Example
//
//  Created by Vladislav on 24.03.16.
//  Copyright © 2016 Vladislav Prusakov. All rights reserved.
//

import UIKit
import CoreData

private let coreDataHelper = CoreDataHelper()
private let context = coreDataHelper.managedObjectContext

class ListController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var result: [AnyObject]?
    private var searchActive = true
    private var searchPredicat: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delete excess seporator
        let background = UIView(frame: CGRectZero)
        tableView.tableFooterView = background
        
        
        //Observe call in another View
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateTable), name: "updateTable", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        searchBar.barTintColor =  UIColor(red: 2/255.0, green: 17/255.0, blue: 37/255.0, alpha: 1.0)
        updateTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///This method update table
    func updateTable() {
        let request = NSFetchRequest(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        result = try? context.executeFetchRequest(request)
        tableView.reloadData()
    }
}

//MARK: - UISearchBarDelegate
extension ListController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let request = NSFetchRequest(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        
        searchPredicat = NSPredicate(format: "firstName = %@", searchText)
        let compound = NSCompoundPredicate.init(andPredicateWithSubpredicates: [searchPredicat!])
        request.predicate = compound
        
        print(searchPredicat)
        result = try? context.executeFetchRequest(request)
        print(result)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchPredicat = nil
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if searchPredicat == nil {
            updateTable()
        }
    }
}

//MARK: - UITableViewDelegate
extension ListController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailProfile = storyboard?.instantiateViewControllerWithIdentifier("detailProfile") as! DetailProfileController
        detailProfile.fetchedData = result![indexPath.row] as? NSManagedObject
        navigationController?.pushViewController(detailProfile, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: - UITableViewDataSource
extension ListController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard result?.count != nil else {
            return 0
        }
        return (result?.count)!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch  editingStyle {
        case .Delete:
            context.deleteObject(result![indexPath.row] as! NSManagedObject)
            result?.removeAtIndex(indexPath.row)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error \(error), \(error.userInfo)")
            }
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.registerNib(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "infoCard")
        let cell = tableView.dequeueReusableCellWithIdentifier("infoCard", forIndexPath: indexPath) as! InfoCell
        let resultInCell = result![indexPath.row] as! NSManagedObject
        
        cell.label.text = (resultInCell.valueForKey("firstName") as! String) + " " + (resultInCell.valueForKey("secondName") as! String)
        
        return  cell
    }
}