//
//  ImagesTableViewController.swift
//  FlikrFinder
//
//  Created by Andrey on 16.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    
    //MARK:- properties
    var filteredImages = [Photo]()
    var searchedImages = [Photo]()
    let searchController = UISearchController(searchResultsController: nil)
    let photoManager = PhotoManager()
    
    //MARK:- lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Setup the Search Controller
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск картинок"
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
}

// MARK: - Table view data source
extension ImagesTableViewController
{
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.searchedImages.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "row = " + String(indexPath.row)
        return cell
    }
}

//MARK:- logic
extension ImagesTableViewController
{
    func filterContentForSearchText(searchText: String)
    {
        print(searchText)
        
//        filteredCandies = candies.filter({( candy : Candy) -> Bool in
//            let categoryMatch = (scope == "All") || (candy.category == scope)
//            return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
//        })
//        tableView.reloadData()
    }

}

// MARK: - UISearchBar Delegate
extension ImagesTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        filterContentForSearchText(searchBar.text!)
    }
}

//extension ImagesTableViewController: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
////        let searchBar = searchController.searchBar
////        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//}

