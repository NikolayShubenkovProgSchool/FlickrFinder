//
//  PhotoViewController.swift
//  FlikrFinder
//
//  Created by Andrey on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit


//MARK:- lifecycle
class PhotoViewController: UIViewController
{
    //MARK: properties
    var photo: Photo?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        assert(photo != nil)
        setupViews()
        savePhotoInHistory()
    }
}

//MARK:- logic
extension PhotoViewController
{
    func setupViews() {
        scrollView.delegate = self
        imageView.updateImageWith(photo)
        self.title = photo?.title
    }
    
    func savePhotoInHistory() {
        let ud = NSUserDefaults.standardUserDefaults()
        var jsonAry: [[String:AnyObject]]
        if let jsonAryTmp = ud.objectForKey(Constants.UserDefatulsHistoryName) as? [[String: AnyObject]] {
            jsonAry = jsonAryTmp
        } else {
            jsonAry = [[String:AnyObject]]()
        }
        
        var isAdd = true
        for item in jsonAry {
            if item["url_s"] as? String == photo?.photoURL {
                isAdd = false
                break
            }
        }
        if jsonAry.count == 30 {
            jsonAry.removeFirst()
        }
        jsonAry.append((photo?.jsonDebug)!)        
        ud.setObject(jsonAry, forKey: Constants.UserDefatulsHistoryName)
        ud.synchronize()
    }
}

//MARK:- scrollview delegate
extension PhotoViewController: UIScrollViewDelegate
{
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return imageView
    }
}

