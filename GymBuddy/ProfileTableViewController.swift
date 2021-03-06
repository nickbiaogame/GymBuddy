//
//  ProfileTableViewController.swift
//  GymBuddy
//
//  Created by Justin (Zihao) Zhang on 11/28/14.
//  Copyright (c) 2014 Duke 2014 Fall CS316. All rights reserved.
//

import UIKit
import CoreData

class ProfileTableViewController:UITableViewController {
    
    let attributeItems = ["First Name", "Last Name", "Gender", "Contact Info", "Password"]

    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributeItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ProfileAttributeCell") as UITableViewCell
        let row = indexPath.row
        var attribute = attributeItems[row]
        cell.textLabel?.text = attribute
        var attributeText = ""
        
        let fetchRequest = NSFetchRequest(entityName: "UserData")
        if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [UserData] {
            var user:UserData = fetchResults[0];
            switch attribute {
            case "First Name":
                cell.detailTextLabel?.text = user.first_name
            case "Last Name":
                cell.detailTextLabel?.text = user.last_name
            case "Gender":
                cell.detailTextLabel?.text = user.gender
            case "Contact Info":
                cell.detailTextLabel?.text = user.signature
                cell.detailTextLabel?.numberOfLines = 5
            default:
                cell.detailTextLabel?.text = ""
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var attribute = attributeItems[indexPath.row]
        switch attribute {
            case "First Name":
                self.performSegueWithIdentifier("EditFirstNameSegue", sender: self)
            case "Last Name":
                self.performSegueWithIdentifier("EditLastNameSegue", sender: self)
            case "Contact Info":
                self.performSegueWithIdentifier("EditSignatureSegue", sender: self)
            case "Gender":
                self.performSegueWithIdentifier("EditGenderSegue", sender: self)
            case "Password":
                self.performSegueWithIdentifier("EditPasswordSegue", sender: self)
            default:
                break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("Ready to launch segue with name " + segue.identifier!)
        if segue.identifier == "EditFirstNameSegue" {
            var viewController = segue.destinationViewController as ProfileEditViewController
            viewController.myEditThing = EditAttribute.EditFirstName
        } else if segue.identifier == "EditLastNameSegue" {
            var viewController = segue.destinationViewController as ProfileEditViewController
            viewController.myEditThing = EditAttribute.EditLastName
        } else if segue.identifier == "EditSignatureSegue" {
            var viewController = segue.destinationViewController as ProfileEditViewController
            viewController.myEditThing = EditAttribute.EditSignature
        } else if segue.identifier == "EditGenderSegue" {
            var viewController = segue.destinationViewController as ProfileChoiceOverallViewController
            viewController.myEditThing = EditAttribute.EditGender
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //set to only support portrait, too lazy to do the landscape
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
}
