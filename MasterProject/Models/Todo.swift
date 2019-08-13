import Foundation

typealias Todos = [Todo]

struct Todo: Codable, Equatable {
    let userID: Int
    let id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
        case completed
    }
}
