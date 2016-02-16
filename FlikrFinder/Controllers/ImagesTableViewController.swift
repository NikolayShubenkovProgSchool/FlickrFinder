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
//        setupBackground()
    }
}

//MARK: - setupBackground
extension ImagesTableViewController
{
    func setupBackground()
    {
//        let image: UIImage =  //self.createImage()
//        self.tableView.backgroundView? = UIImageView(image: UIImage(named: "logo"))
    }
    
    func createImage()->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        drawRadialGradientOfSize(self.view.frame.size, context: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func drawRadialGradientOfSize(size:CGSize,context:CGContextRef)
    {
        CGContextSaveGState(context)

        let clipPath = UIBezierPath(roundedRect: CGRectMake(40, 40, size.width/2, size.width/1.5), byRoundingCorners: [.BottomLeft,.TopLeft], cornerRadii:CGSizeMake(10, 10))
        
        clipPath.addClip()
        let colors = [UIColor.orangeColor().CGColor, UIColor.whiteColor().CGColor]
        let positions:[CGFloat]  = [0.2, 0.4, 0.6, 0.9]
        let startPoint = CGPointMake(40, 40)
        let finishPoint = CGPointMake(60, 60)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorSpace, colors, positions)
        CGContextDrawRadialGradient(context, gradient, startPoint, 100, finishPoint, 20, [])
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
    }
}