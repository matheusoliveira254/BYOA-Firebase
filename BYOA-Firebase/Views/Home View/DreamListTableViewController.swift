//
//  TableViewController.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import UIKit

class DreamListTableViewController: UITableViewController {
    
    var viewModel: DreamListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DreamListViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.dreams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dreamCell", for: indexPath)
        let dream = viewModel.dreams[indexPath.row]
        cell.textLabel?.text = dream.dreamTitle
        cell.detailTextLabel?.text = dream.dreamDate.stringValue()
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // MARK: - IIDOO
        /// Destination - Verifying the segues destination leads to the *ViewController* we want. This also allows us to access the properties on that *ViewController*
        guard let destination = segue.destination as? DreamDetailViewController else {return}
        /// Identifier - We are checking to see if the identifier of our segue matches "toDetailVC". If it does then we will run the code inside, if not then we will just pass over it.
        if segue.identifier == "toDetailVC" {
            // They are accessing via the cell
            /// Index - Discovering what row the user has seleceted
            guard let index = tableView.indexPathForSelectedRow else {return}
            /// Object to send - Using the index we discovered earlier we retrieve the *Log* that matches in our *logs* array.
            let dream = viewModel.dreams[index.row]
            /// Object to receive - Sets the value of the optional *log* on the *destination* to the *Log* we just retrived.
            destination.viewModel = DreamDetailViewModel(dream: dream)
        } else {
            // They are NOT accessing the detailVC via the cell
            destination.viewModel = DreamDetailViewModel()
        }
    }
}

extension DreamListTableViewController: DreamListViewModelDelegate {
    func dreamsLoadedSuccessfully() {
        tableView.reloadData()
    }
}
