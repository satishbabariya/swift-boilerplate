import Foundation

struct Geo: Codable, Equatable {
    let lat: String
    let lng: String

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
