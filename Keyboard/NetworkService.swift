import Foundation
import UIKit

struct RequestBody: Encodable {
    let text: String
    let rhythms: String?
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
    func sendPhonemicsRequest(text: String, rhythms: String? = nil, completion: ((PhonemicsResponseBody) -> Void)?) {
        print("[NetworkService] Starting request for text: \(text), rhythms: \(rhythms ?? "nil")")
        
        // Check if keyboard has full access (required for network)
        let hasFullAccess = UIPasteboard.general.hasStrings || UIPasteboard.general.hasImages || UIPasteboard.general.hasURLs || true
        print("[NetworkService] Has Full Access: \(hasFullAccess)")
        
        guard let url = URL(string: "https://phonemics.net/api/search/") else { 
            print("[NetworkService] Failed to create URL")
            return 
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30

        let body = RequestBody(text: text, rhythms: rhythms)
        guard let httpBody = try? JSONEncoder().encode(body) else {
            print("[NetworkService] Failed to encode request body")
            return
        }
        request.httpBody = httpBody
        print("[NetworkService] Request body: \(String(data: httpBody, encoding: .utf8) ?? "")")

        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[NetworkService] Network error:", error.localizedDescription)
                print("[NetworkService] Error code:", (error as NSError).code)
                print("[NetworkService] Error domain:", (error as NSError).domain)
                completion?(PhonemicsResponseBody(data: .init(suggestions: [], rhythms: [], isHamza: false)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("[NetworkService] HTTP Status Code:", httpResponse.statusCode)
                print("[NetworkService] Response headers:", httpResponse.allHeaderFields)
            }

            guard let data = data else {
                print("[NetworkService] No data received.")
                completion?(PhonemicsResponseBody(data: .init(suggestions: [], rhythms: [], isHamza: false)))
                return
            }

            print("[NetworkService] Received data of size:", data.count)
            
            do {
                let result = try JSONDecoder().decode(PhonemicsResponseBody.self, from: data)
                completion?(result)
                print("[NetworkService] Success - Suggestions:", result.data.suggestions)
                print("[NetworkService] Success - Rhythms:", result.data.rhythms)
            } catch {
                completion?(PhonemicsResponseBody(data: .init(suggestions: [], rhythms: [], isHamza: false)))
                print("[NetworkService] Failed to decode JSON:", error)
                print("[NetworkService] Raw response:", String(data: data, encoding: .utf8) ?? "")
            }
        }.resume()
    }
}


