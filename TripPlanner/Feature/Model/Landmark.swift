import Foundation

struct Landmark: Identifiable, Decodable, Hashable {
    var id: Int
    var name: String
    var continent: String
    var description: String
    var shortDescription: String
}
