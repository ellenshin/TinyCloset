//
//  SearchVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/25/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var contents: [AnyObject]!
    var contentKind: String!
    var inSearchMode = false
    var filteredContents: [AnyObject]!
    
    let peopleTitle = "New Friend"
    let peopleSubtitle = "Add a new friend's name!"
    let eventTitle = "New Event"
    let eventSubtitle = "Add a new event!"
    let typeTitle = "New Type of Clothing"
    let typeSubtitle = "Add a new type of clothing!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        assignPlaceholder()
        fetchAndSetResult()
        searchTableView.reloadData()
        
    }
    
    func fetchAndSetResult() {
        
        let context = ad.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: contentKind)
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            contents = []
            if contentKind == "Event" {
                contents = results as! [Event]
            } else if contentKind == "People" {
                contents = results as! [Person]
            } else {
                contents = results as! [Type]
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    func assignPlaceholder() {
        if contentKind == "Event" {
            searchBar.placeholder = "Search for an event"
        } else if contentKind == "People" {
            searchBar.placeholder = "Search for a friend"
            contentKind = "Person"
        } else {
            searchBar.placeholder = "Search for a type of clothing"
            contentKind = "Type"
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredContents.count
        } else {
            return contents.count
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if inSearchMode {
            if let content = filteredContents[indexPath.row] as? NSObject {
                contentSelected(content)
            }
        } else {
            if let content = contents[indexPath.row] as? NSObject {
                contentSelected(content)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = searchTableView.dequeueReusableCellWithIdentifier("ContentCell", forIndexPath: indexPath) as? ContentCell {
            
            var content: String!
            if inSearchMode {
                content = filteredContents[indexPath.row].name!
            } else {
                content = contents[indexPath.row].name!
            }
            
            cell.configureCell(content)
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            view.endEditing(true)
            searchTableView.reloadData()
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            let request = NSFetchRequest(entityName: contentKind)
            let predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", lower)
            request.predicate = predicate
            let context = ad.managedObjectContext
            do {
                let results = try context.executeFetchRequest(request)
                filteredContents = results
                print("\(filteredContents.count)")
            } catch let err as NSError {
                print(err.debugDescription)
            }
            searchTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func contentSelected(content: NSObject) {
        //DataService.instance.addedContent = content
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "contentAdded", object: content))
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addBtnPressed(sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!, kTextFont: UIFont(name: "HelveticaNeue", size: 14)!, kButtonFont: UIFont(name: "HelveticaNeue-Medium", size: 20)!, kCircleTopPosition: -300.0,hideWhenBackgroundViewIsTapped: true)
        let alert = SCLAlertView(appearance: appearance)
        if contentKind == "Person" {
            let textField = alert.addTextField("Enter a friend's name")
            textField.becomeFirstResponder()
            alert.addButton("Done") {
                if textField.text != nil && textField.text != "" {
                    let person = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: ad.managedObjectContext) as! Person
                    person.name = textField.text
                    alert.hideView()
                    self.contentSelected(person)
                }
            }
            alert.alertType = .Edit
            alert.viewWillLayoutSubviews()
            alert.showEdit(peopleTitle, subTitle:peopleSubtitle)
        } else if contentKind == "Event" {
            let textField = alert.addTextField("Enter an event name")
            textField.becomeFirstResponder()
            alert.addButton("Done") {
                if textField.text != nil && textField.text != "" {
                    let event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: ad.managedObjectContext) as! Event
                    event.name = textField.text
                    alert.hideView()
                    self.contentSelected(event)
                }
            }
            alert.alertType = .Edit
            alert.viewWillLayoutSubviews()
            alert.showEdit(eventTitle, subTitle:eventSubtitle)
        } else {
            let textField = alert.addTextField("Enter a clothing type")
            textField.becomeFirstResponder()
            alert.addButton("Done") {
                if textField.text != nil && textField.text != "" {
                    let type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: ad.managedObjectContext) as! Type
                    type.name = textField.text
                    alert.hideView()
                    self.contentSelected(type)
                }
            }
            alert.alertType = .Edit
            alert.viewWillLayoutSubviews()
            alert.showEdit(typeTitle, subTitle:typeSubtitle)
        }
    }

    
}



