//: Playground - noun: a place where people can play

class Place {
    var a = 123
}


//protocol PhotoAPIDelegate {
//    func getTopPlaces() -> [Place]
//}
//
//var a: protocol<PhotoAPIDelegate>
//
//class PhotoAPI: PhotoAPIDelegate {
//    var a1: String = ""
//    func getTopPlaces() -> [Place] {
//        var result =  [Place]()
//        result.append(Place())
//        result.append(Place())
//        return result
//    }
//}
//
//a = PhotoAPI()
//a.getTopPlaces()
//
//


var a: Place? = Place()
var b: Place? = Place()

a!.a = 222
b!.a = 333
b = nil

if let c: Place =  a
 , let c1: Place = b
{
    print("c = \(c.a)")
    print("c1 = \(c1.a)")
}
else
{
    print("error")
}









