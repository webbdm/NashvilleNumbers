import Foundation

struct Song: Decodable, Identifiable{
    let id: Int
    let name: String
    let key: String
}

