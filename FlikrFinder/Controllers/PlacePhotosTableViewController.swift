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


//MARK:- lifecycle
class PlacePhotosTableViewController: UITableViewController {
    //MARK:- properties
    var place: Place?
    var photoManager: protocol<PhotoManagerDelegate> = FlickrAPI()
    var photos = [Photo]()
    var isBusy: Bool = false
    
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
        let photo = photos[indexPath.row]
        configureCell(cell,photo: photo)
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
    func updateImageWith(photo:Photo?,completion:(Void->Void)) {
        guard let photoToApply = photo else {
            self.image = nil
            return
        }
        
        let placeholder = UIImage()
        //FIXME: закачка фотографии происходит когда она выбирается в списке или проматывается за пределы экрана
//        sd_setImageWithURL(NSURL(string: photoToApply.photoURL),
//            placeholderImage: placeholder,
//            options: [ .ProgressiveDownload])
        sd_setImageWithURL(NSURL(string: photoToApply.photoURL), placeholderImage: nil) { (image, error, _, _) -> Void in
            if error == nil{
                self.image = image
                completion()
            }
        }
        
    }
}


//MARK:- segue
extension PlacePhotosTableViewController
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let photoVC = segue.destinationViewController as? PhotoViewController
          ,let photo: Photo = photos[(tableView.indexPathForSelectedRow?.row)!]
          
        {
            photoVC.photo = photo
        }
    }
}

//MARK:- TableViewController
extension UITableViewController {
    // configure UITableview cell
    func configureCell(cell: UITableViewCell, photo: Photo) {
        cell.textLabel?.text = photo.name
        //в общем тут не все так просто
        //оказалось, что таблица настраивает фрейм ячейки перед тем как показать на экране.
        //поэтому нужно после закачки картинки
        //перезагрузить конкретную ячейку
        cell.imageView?.updateImageWith(photo)
            {
            
            //если картинка скачается перезагрузим ее. 
            //чтобы перезагрузить нужно узнать индекс ячейки,
            //но если таблица еще не успела вывести ячейку на экран
            //то мы не сможем ее перезагрузить
            //поэтому запросим ячейку через мгновение после закачки
            //обсуждение https://github.com/AFNetworking/AFNetworking/issues/277
            NSOperationQueue.mainQueue().addOperationWithBlock({ ()  -> Void in
                
                
                if let index = self.tableView.indexPathForCell(cell)
                {
                    self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.None)
                }
            })
        }
    }

}





