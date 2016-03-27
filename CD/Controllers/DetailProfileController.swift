//
//  DetailProfileController.swift
//  CoreData Example
//
//  Created by Vladislav on 24.03.16.
//  Copyright © 2016 Vladislav Prusakov. All rights reserved.
//

import UIKit
import CoreData

class DetailProfileController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var fetchedData: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIView(frame: CGRectZero)
        tableView.tableFooterView = background
        tableView.separatorColor = UIColor.clearColor()
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - UITableViewDelegate
extension DetailProfileController: UITableViewDelegate {

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: - UITableViewDataSource
extension DetailProfileController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! DetailCell
        
        switch indexPath.row {
        case 0:
            cell.headerDetail.text = " "
            cell.descriptionDetail.text = " "
        case 1:
            cell.headerDetail.text = "First Name"
            cell.descriptionDetail.text = fetchedData?.valueForKey("firstName") as? String
        case 2:
            cell.headerDetail.text = "Second Name"
            cell.descriptionDetail.text = fetchedData?.valueForKey("secondName") as? String
        case 3:
            cell.headerDetail.text = "E-mail"
            cell.descriptionDetail.text = fetchedData?.valueForKey("email") as? String
        case 4:
            cell.headerDetail.text = "Notes"
            cell.descriptionDetail.text = fetchedData?.valueForKey("notes") as? String
        default:
            return cell
        }
        return cell
    }
}