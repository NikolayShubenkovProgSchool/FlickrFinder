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
        searchController.searchBar.placeholder = "Поиск не реализован"
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        // устанавалием фон
        setupBackground()
    }
}

//MARK: - setupBackground
extension ImagesTableViewController
{
    func setupBackground()
    {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.opaque = false;
//        self.tableView.backgroundView = UIImageView(image: UIImage(named: "logo"))
        let image: UIImage =  self.createImage()
        self.tableView.backgroundView = UIImageView(image: image)
    }
    
    func createImage()->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        drawRadialGradientOfSize(self.tableView.frame.size, context: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func drawRadialGradientOfSize(size:CGSize,context:CGContextRef)
    {
        CGContextSaveGState(context)
        let colors = [UIColor.orangeColor().CGColor, UIColor(red: 1.0, green: 175/255, blue: 105/255, alpha: 1.0).CGColor]
        let positions:[CGFloat]  = [0.7,1.0]
        let startPoint = CGPointMake(size.width / 2, size.height / 2)
        let finishPoint = CGPointMake(size.width / 2, size.height / 2)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorSpace, colors, positions)
        CGContextDrawRadialGradient(context, gradient, startPoint, size.height  * 1.25, finishPoint, 0, [])
        CGContextRestoreGState(context)
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
        return 12 //self.searchedImages.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "row = " + String(indexPath.row)
        return cell
    }
}

//MARK:- Tablew view delegate
extension ImagesTableViewController
{
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

//MARK:- logic
extension ImagesTableViewController
{
    func filterContentForSearchText(searchText: String)
    {
        print("Метод поиска будет реализован в следующей версии")
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
        searchBar.text = ""
    }
}

