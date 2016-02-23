//
//  PlacePhotosTableViewController.swift
//  FlikrFinder
//
//  Created by Andrey Torlopov on 22/02/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage


class PlacePhotosTableViewController: UITableViewController {
    //MARK:- properties
    var place: Place?
    var photoManager: protocol<PhotoManagerDelegate> = FlickrAPI()
    var photos = [Photo]()
    var isBusy: Bool = false
    
    //MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(place)
        self.title = place?.placeName
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupBackground()
        if self.photos.count == 0 {
            refreshPhotos()
        }
    }
}

// MARK: - Table view data source
extension PlacePhotosTableViewController
{

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        configureCell(cell,indexPath: indexPath)
        return cell
    }

}


//MARK:- logic
extension PlacePhotosTableViewController {
    
    //bysy proccess
    func showIsBusy(busy:Bool, animated:Bool)
    {
        if busy
        {
            MBProgressHUD.showHUDAddedTo(view, animated: animated)
            return
        }
        MBProgressHUD.hideHUDForView(view, animated: animated)
    }

    // configure UITableview cell
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        let photo = self.photos[indexPath.row]
        cell.textLabel?.text = photo.name
        cell.imageView?.updateImageWith(photo)
    }

    func refreshPhotos() {
        self.showIsBusy(true, animated: true)
        photoManager.findPlacePhotos(place!.placeId) { (success, failure) -> Void in
            self.photos = success!
            self.tableView.reloadData()
            self.showIsBusy(false, animated: true)
            self.isBusy = false;
            
        }
    }
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        if !isBusy {
            self.isBusy = true
            self.refreshPhotos()
        }        
    }
    
}

//MARK: - UIImageView Extention
extension UIImageView {
    func updateImageWith(photo:Photo?) {
        guard let photoToApply = photo else {
            self.image = nil
            return
        }
        
        sd_setImageWithURL(NSURL(string: photoToApply.photoURL),
            placeholderImage: nil,
            options: [ .ProgressiveDownload])
        
    }
}
