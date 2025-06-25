import Foundation

struct RequestBody: Encodable {
    let text: String
}

struct PhonemicsResponseBody: Decodable {
    let data: PhonemicsResponseBodyData
}

struct PhonemicsResponseBodyData: Decodable {
    let suggestions: [String]
    let rhythms: [String]
    let isHamza: Bool
}

final class NetworkService {
    func sendPhonemicsRequest(text: String, completion: ((PhonemicsResponseBody) -> Void)?) {
        guard let url = URL(string: "https://phonemics.net/api/search/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = RequestBody(text: text)
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error)
                return
            }

            guard let data = data else {
                print("No data received.")
                return
            }

            do {
                let result = try JSONDecoder().decode(PhonemicsResponseBody.self, from: data)
                completion?(result)
                print("Suggestions:", result.data.suggestions)
                print("Rhythms:", result.data.rhythms)
            } catch {
                completion?(PhonemicsResponseBody(data: .init(suggestions: [], rhythms: [], isHamza: false)))
                print("Failed to decode JSON:", error)
                print("Raw response:", String(data: data, encoding: .utf8) ?? "")
            }
        }.resume()
    }
}


