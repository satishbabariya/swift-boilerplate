import Foundation

typealias Posts = [Post]

struct Post: Codable, Equatable {
    let userID: Int
    let id: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
        case body
    }
}
