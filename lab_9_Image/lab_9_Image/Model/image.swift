import Foundation

struct FirebaseImage: Identifiable {
    var id: String
    var name: String
    var url: String

    func toDict() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "url": url
        ]
    }

    init(id: String, name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let name = dict["name"] as? String,
              let url = dict["url"] as? String else {
            return nil
        }
        self.id = id
        self.name = name
        self.url = url
    }
}
