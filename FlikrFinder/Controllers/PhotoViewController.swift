//
//  PhotoViewController.swift
//  FlikrFinder
//
//  Created by Andrey on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit


//MARK:- lifecycle
class PhotoViewController: UIViewController {
    //MARK: properties
    var photo: Photo?
    var defaultInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(photo != nil)
        setupViews()
        savePhotoInHistory()
        self.view.backgroundColor =  UIColor.flatOrangeColor()
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
extension PhotoViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


//MARK:- scroll view correct place
extension PhotoViewController {
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        let contentWidth = CGRectGetWidth(imageView.frame)
        let scrollWidth  = CGRectGetWidth(scrollView.frame)
        var horizontalMargin: CGFloat = 0
        
        if contentWidth + defaultInset.left + defaultInset.right < scrollWidth {
            horizontalMargin = (scrollWidth - contentWidth - (defaultInset.left + defaultInset.right )) / CGFloat(2)
            //            print("scrollWidth = \(scrollWidth) contentWidth = \(contentWidth) horizontalMargin = \(horizontalMargin)")
        }
        
        var inset = scrollView.contentInset
        
        inset.left  = horizontalMargin
        inset.right = horizontalMargin
        
        let contentHeight = CGRectGetHeight(imageView.frame)
        let scrollHeight = CGRectGetHeight(scrollView.frame)
        
        var verticalMargin: CGFloat = 0
        
        if contentHeight + defaultInset.top + defaultInset.bottom < scrollHeight {
            verticalMargin = (scrollHeight - contentHeight - (defaultInset.top + defaultInset.bottom)) / CGFloat(2)
        }
        
        inset.top = verticalMargin
        inset.bottom = verticalMargin
        
        if (scrollView.contentInset == inset){
            return
        }
        
        UIView.animateWithDuration(0.5) { () -> Void in
            scrollView.contentInset = inset
            scrollView.layoutIfNeeded()
        }
        
    }
}

