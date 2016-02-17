//
//  PhotoManager.swift
//  FlikrFinder
//
//  Created by Andrey on 16.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Alamofire

/*
parameters[@"tags"] = @"cats";
parameters[@"bbox"] = @"bbox";
parameters[@"lat"]  = @(self.mapView.centerCoordinate.latitude);
parameters[@"lon"]  = @(self.mapView.centerCoordinate.longitude);
parameters[@"radius"] = @"5";
parameters[@"extras"] = @"url_l,geo,date_taken,owner_name";
parameters[@"format"] = @"json";


parameters[@"content_type"] = @1;
parameters[@"nojsoncallback"] = @1;

parameters[@"method"] = @"flickr.photos.search";

parameters[@"api_key"] = @"2b2c9f8abc28afe8d7749aee246d951c";
*/

class PhotoManager: NSObject {
    static let apiURL = "https://api.flickr.com/services/rest/"
    typealias PhotosComplition = (success:[Photo]?,failure:NSError?)->Void
    func findAllPhotosOfUser(id: String, complition: PhotosComplition)
    {
        var params = [String: AnyObject]()
        params["method"] = "flickr.photos.search"
        params["user_id"] = id
        params["extras"] = "url_l,geo,date_taken,owner_name,url_s,description"
        params = authrize(params)
        
        Alamofire.request(.GET,
            PhotoManager.apiURL,
            parameters: params,
            encoding: .URL,
            headers: nil)
            .responseJSON { response -> Void in
                
                if response.result.error != nil
                {
                    complition(success: nil, failure: response.result.error!)
                    return
                }
                let results = self.parsePhotosFrom(response.result.value as! [String:AnyObject])
                complition(success: results, failure: nil)
        }
    }
    
    func find(searchName:String,
        longitude:Double,
        latitude:Double,
        radius:Double,
        completion: PhotosComplition
        ){
            var params = [String:AnyObject]()
            params["tags"] = searchName
            params["bbox"] = "bbox"
            params["lat"]  = latitude
            params["lon"]  = longitude
            params["radius"] = radius
            params["extras"] = "url_l,geo,date_taken,owner_name,url_s,description"
            params["format"] = "json"
            params["content_type"]   = 1
            params["nojsoncallback"] = 1
            params["method"] = "flickr.photos.search"
            params = authrize(params)
            
            Alamofire.request(.GET,
                PhotoManager.apiURL,
                parameters: params,
                encoding: .URL,
                headers: nil)
                .responseJSON { response -> Void in
                    
                    if response.result.error != nil {
                        completion(success: nil, failure: response.result.error!)
                        return
                    }
                    
                    
                    let results = self.parsePhotosFrom(response.result.value as! [String:AnyObject])
                    
                    completion(success: results, failure: nil)
            }
    }
    
    func parsePhotosFrom(info:[String:AnyObject])->[Photo] {
        //photos
        //photo
        guard let photos = info["photos"] as? [String : AnyObject],
            let photo = photos["photo"] as? [ [String : AnyObject] ]
            else {
                return [Photo]()
        }
        
        var parsedPhotos = [Photo]()
        
        for info in photo {
            parsedPhotos.append(Photo(info: info))
        }
        
        return parsedPhotos
    }
    
    private func authrize(parametrs: [String: AnyObject]) -> [String: AnyObject]
    {
        var authParams = parametrs
        authParams["api_key"] = "2b2c9f8abc28afe8d7749aee246d951c"
        authParams["format"] = "json"
        authParams["content_type"]   = 1
        authParams["nojsoncallback"] = 1
        return authParams
    }
}









