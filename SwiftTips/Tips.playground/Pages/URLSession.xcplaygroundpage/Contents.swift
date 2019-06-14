import Foundation

// coable protocal for JSON encode/decode
struct People: Codable {
    var age: Int
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case age
    }
}

// seperate protocal implement to make code simple
extension People: CustomStringConvertible {
    var description: String {
        return "{\n  firstName: \(firstName),\n  lastName: \(lastName),\n  age: \(age)\n}"
    }
}


// a simple example for HTTP Request and JSON decode
let session = URLSession.shared
let url = URL(string:"https://learnappmaking.com/ex/users.json")!

let task = session.dataTask(with: url, completionHandler: { data, response, error in
    do {
        let decoder = JSONDecoder()
        let guys = try decoder.decode([People].self, from: data!)
        print(guys)
    } catch {
        print("JSON error: \(error.localizedDescription)")
    }
})

task.resume()




