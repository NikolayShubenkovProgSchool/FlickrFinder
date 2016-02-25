//
//  HistoryTableViewController.swift
//  FlikrFinder
//
//  Created by Andrey on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit


//MARK:- lifevycle
class HistoryTableViewController: UITableViewController {

    //properties
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupBackground()
        
        let ud = NSUserDefaults.standardUserDefaults()
        if let jsonAry = ud.objectForKey(Constants.UserDefatulsHistoryName) as? [[String:AnyObject]] {
            for item in jsonAry {
                photos.append(Photo(info: item ))
            }
        }
        tableView.reloadData()
    }
}

//MARK:- Table view Datasource and delegate
extension HistoryTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let photo = photos[indexPath.row]

        // Если контроллеро будет много, расширение вынести в отдельный файл.
        configureCell(cell,photo: photo)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
