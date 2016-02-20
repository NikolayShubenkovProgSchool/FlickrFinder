//
// Класс содержит информацию о месте.
// С помощью его ИД можно найти фотки 
// которые к этому месту относятся.
//

import UIKit
import MapKit

class Place: NSObject
{
    var placeId: String = ""
    var coordinate:CLLocationCoordinate2D
    var placeType: (id: String, value: String) = ("","")
    var placeURL: String = ""
    var photoCount: Int32 = 0
    var placeName: String = ""
    
    var jsonForDebug: [String:AnyObject] = [String: AnyObject]()
    
    init(info:[String:AnyObject])
    {
        if let idValue = info["place_id"] as? String
        {
            placeId = idValue
        }
        
        if let url = info["place_url"] as? String
        {
            placeURL = url
        }
        
        if let placeNameVal = info["_content"] as? String
        {
            placeName = placeNameVal
        }
        
        guard let lon = info["longitude"] as? String,
              let lat  = info["latitude"] as? String
        else
        {
            coordinate = CLLocationCoordinate2D(latitude: -500, longitude: -500)
            super.init()
            return
        }
        coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        
        if let placeTypeIdVal = info["place_type_id"] as? String
        {
            placeType.id = placeTypeIdVal
        }
        
        if let placeTypeVal  = info["place_type_id"] as? String
        {
            placeType.value = placeTypeVal
        }
        
        super.init()
    }
    
}
