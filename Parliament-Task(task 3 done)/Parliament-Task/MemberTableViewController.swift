//
//  MemberTableViewController.swift
//  Parliament-Task
//
//  Created by iosdev on 4.5.2021.
//

import UIKit
import CoreData

class MemberTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var fetchedResultsController: NSFetchedResultsController<Member>?
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "firstname", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.viewContext, sectionNameKeyPath: "firstname", cacheName: "memberCache")
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        tableView.reloadData()
    }
    
    func controllerDidChange(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controller did change content")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController!.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController!.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        
        // Configure the cell...
        guard let member = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("Member not found in fetched result controller")
        }
        cell.textLabel?.text = "Fullname: \(member.firstname ?? "no name") \(member.lastname ?? "no name") party: \(member.party ?? "no name")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let push = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController" ) as! DetailsViewController
        guard let member_table = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("Member not found in fetched result controller")
        }
        push.member = member_table
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let controller = segue.destination as? DetailsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
    }
}
