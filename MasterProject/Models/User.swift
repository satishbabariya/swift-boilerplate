import Foundation

typealias Users = [User]

struct User: Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    let xxx: String?
}

class MyCodable: Codable {
    let name: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Default Appleseed"
    }
}

//required init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    self.name = try container.decodeWrapper(key: .name, defaultValue: "Default Appleseed")
//}

//extension KeyedDecodingContainer {
//    func decodeWrapper<T>(key: K, defaultValue: T) throws -> T
//        where T : Decodable {
//            return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
//    }
//}

//https://www.swiftbysundell.com/posts/type-inference-powered-serialization-in-swift

//struct Video {
//    let url: URL
//    let containsAds: Bool
//    var comments: [Comment]
//}
//
//extension Video: Decodable {
//    enum CodingKey: String, Swift.CodingKey {
//        case url
//        case containsAds = "contains_ads"
//        case comments
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKey.self)
//        url = try container.decode(forKey: .url)
//        containsAds = try container.decode(forKey: .containsAds, default: false)
//        comments = try container.decode(forKey: .comments, default: [])
//    }
//}
//
//extension KeyedDecodingContainerProtocol {
//    func decode<T: Decodable>(forKey key: Key) throws -> T {
//        return try decode(T.self, forKey: key)
//    }
//
//    func decode<T: Decodable>(
//        forKey key: Key,
//        default defaultExpression: @autoclosure () -> T
//        ) throws -> T {
//        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
//    }
//}

struct FailableDecodable<T: Swift.Decodable>: Swift.Decodable {
    let value: T?
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try? container.decode(T.self)
    }
}

extension KeyedDecodingContainer {
    public func decodeSafely<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        guard let decoded = try? decode(T.self, forKey: key) else { return nil }
        return decoded
    }
    
    public func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        guard let decoded = try? decodeIfPresent(T.self, forKey: key) else { return nil }
        return decoded
    }
}

//items = try values.decode([FailableDecodable<Item>].self, forKey: .items).flatMap({ $0.value })
//
//items = try values.decodeIfPresent([FailableDecodable<Item>].self, forKey: .items).flatMap({ $0.value })
