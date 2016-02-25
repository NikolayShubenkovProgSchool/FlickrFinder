//
//  PhotoManagerDelegate.swift
//  FlikrFinder
//
//  Created by Andrey on 23.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation

enum PlaceTypes: Int32 {
    case Country = 12
    case Neighbourhood = 22
    case Locality = 7
    case Region = 8
    case Continent = 29
}

enum FlickrPhotoParams: String {
    case Tags = "tags"
    case Latitude = "lat"
    case Longitude = "lon"
    case Radius = "radius"
    case PlaceId = "place_id"
    case UserId = "user_id"
}

typealias PlacesComplition = (success:[Place]?,failure:NSError?)->Void
typealias PhotosComplition = (success:[Photo]?,failure:NSError?)->Void

protocol PhotoManagerDelegate {
    func getTopPlacesWith(placeType: PlaceTypes, complition: PlacesComplition)
    func findPlacePhotos(placeId: String, complition:  PhotosComplition)
    func findUserPhotos(userId: String, complition:  PhotosComplition)
}


