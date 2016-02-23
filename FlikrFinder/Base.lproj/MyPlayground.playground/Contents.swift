//: Playground - noun: a place where people can play

class Place {
    
}

protocol PhotoAPIDelegate {
    func getTopPlaces() -> [Place]
}

var a: protocol<PhotoAPIDelegate>

class PhotoAPI: PhotoAPIDelegate {
    var a1: String = ""
    func getTopPlaces() -> [Place] {
        var result =  [Place]()
        result.append(Place())
        result.append(Place())
        return result
    }
}

a = PhotoAPI()
a.getTopPlaces()
