//
//  APIManager.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

class APIManager {
    
    private let queue = DispatchQueue.global(qos: .background)
    private let semaphore = DispatchSemaphore(value: 1) // Change value to allow maximum of concurrent network task
    
    /// Perform API requests with a given route
    ///
    /// - Parameters:
    ///   - route: A RouteConfig value describing the API resource
    func request<T: Codable>(route: RouteConfig, completion: @escaping (Result<T, Error>)->Void) {

        let session = URLSession.shared

        let urlRequest = route.asURLRequest()!
        
        print(urlRequest.curlString) // for debugging
        
        queue.async {
            self.semaphore.wait()
            let task = session.dataTask(with: urlRequest) { data, response, error in
                defer {
                    self.semaphore.signal()
                }
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let object = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(object))
                }
                catch let err {
                    completion(.failure(err))
                }
            }

            task.resume()
        }
    }
}

extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

}
