import Foundation

typealias Albums = [Album]

struct Album: Codable, Equatable {
    let userID: Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
    }
}

struct Video {
    let url: URL
    let containsAds: Bool
    var comments: [Comment]
}

extension Video: Decodable {
    enum CodingKey: String, Swift.CodingKey {
        case url
        case containsAds = "contains_ads"
        case comments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKey.self)
        
        url = try container.decode(forKey: .url)
        containsAds = try container.decode(forKey: .containsAds, default: false)
        comments = try container.decode(forKey: .comments, default: [])
    }
}

extension KeyedDecodingContainerProtocol {
    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try decode(T.self, forKey: key)
    }
    
    func decode<T: Decodable>(
        forKey key: Key,
        default defaultExpression: @autoclosure () -> T
        ) throws -> T {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
    }
}
