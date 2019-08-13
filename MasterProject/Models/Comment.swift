import Foundation

typealias Comments = [Comment]

struct Comment: Codable, Equatable {
    let postID: Int
    let id: Int
    let name: String
    let email: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id
        case name
        case email
        case body
    }
}
