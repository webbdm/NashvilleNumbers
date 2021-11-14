import Foundation

struct Note: Decodable, Identifiable{
    let id: Int
    let number: Int
    let noteName: String
}


struct Key: Decodable, Identifiable {
    let id: Int
    let keyName: String
    let notes: [Note]
}
