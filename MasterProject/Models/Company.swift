import Foundation

struct Company: Codable, Equatable {
    let name: String
    let catchPhrase: String

    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
    }
}
