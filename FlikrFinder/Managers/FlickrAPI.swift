// API для работы с Flickr.com

import UIKit
import Alamofire

class FlickrAPI: NSObject {

    static let apiURL = "https://api.flickr.com/services/rest/"
    
    private func authrize(parametrs: [String: AnyObject]) -> [String: AnyObject]
    {
        var authParams = parametrs
        authParams["api_key"] = "2b2c9f8abc28afe8d7749aee246d951c"
        authParams["format"] = "json"
        authParams["content_type"]   = 1
        authParams["nojsoncallback"] = 1
        return authParams
    }

    private func setupParams(parametrs: [String: AnyObject]) -> [String: AnyObject]
    {
        var authParams = parametrs
        authParams["bbox"] = "bbox"
        authParams["extras"] = "url_l,geo,date_taken,owner_name,url_s,description"
        return authParams
    }
}

//MARK:- PhotoManagerDelegate
extension FlickrAPI: PhotoManagerDelegate
{
    func getTopPlacesWith(placeType: PlaceTypes, complition: PlacesComplition)
    {
        var params = [String: AnyObject]()
        params["method"] = "flickr.places.getTopPlacesList"
        params["place_type_id"] = NSNumber(int: placeType.rawValue)
        params = setupParams(params)
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
                let results = self.parsePlacesFrom(response.result.value as! [String:AnyObject])
                complition(success: results, failure: nil)
        }
    }
    
    func findPlacePhotos(placeId: String, complition: PhotosComplition) {
        var params = [String: AnyObject]()
        params["place_id"] = placeId
        params["method"] = "flickr.photos.search"
        params["page"] = 1
        params["per_page"] = 20
        
        params = setupParams(params)
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
    
    func findUserPhotos(userId: String, complition: PhotosComplition) {
        
    }
}


//MARK:- private function
extension FlickrAPI
{
    private func parsePlacesFrom(info:[String:AnyObject])->[Place]?
    {
        guard let places = info["places"] as? [String : AnyObject],
            let place = places["place"] as? [ [String : AnyObject] ]
            else {
                return [Place]()
        }
        var parsedPlaces = [Place]()
        
        //place - массив словарей
        for info in place {
            parsedPlaces.append(Place(info: info))
        }
        return parsedPlaces
    }

    private func parsePhotosFrom(info:[String:AnyObject])->[Photo] {
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

}