import Foundation

struct Owner: Codable {
    let name: String
    let gender: String
    let age: Int
    let pets: [Pet]?
    var numberOfItems: Int {
        return pets?.count ?? 0
    }
    enum CodingKeys: String, CodingKey {

        case name = "name"
        case gender = "gender"
        case age = "age"
        case pets = "pets"
    }
   
}
