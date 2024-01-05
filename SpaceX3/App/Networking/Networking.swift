//
//  Networking.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 26/12/23.
//
import UIKit
enum Result<Value: Decodable> {
    case success(Value)
    case failure(Bool, String)
}
typealias Handler = (Result<Data>) -> Void
enum NetworkError: Error {
    case nullData
}
public enum Method {
    case delete
    case get
    case head
    case post
    case put
    case connect
    case options
    case trace
    case patch
    case other(method: String)
}
enum NetworkingError: String, LocalizedError {
    case jsonError = "JSON error"
    case other
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}
extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "DELETE":
            self = .delete
        case "GET":
            self = .get
        case "HEAD":
            self = .head
        case "POST":
            self = .post
        case "PUT":
            self = .put
        case "CONNECT":
            self = .connect
        case "OPTIONS":
            self = .options
        case "TRACE":
            self = .trace
        case "PATCH":
            self = .patch
        default:
            self = .other(method: method)
        }
    }
}
extension Method: CustomStringConvertible {
    public var description: String {
        switch self {
        case .delete:            return "DELETE"
        case .get:               return "GET"
        case .head:              return "HEAD"
        case .post:              return "POST"
        case .put:               return "PUT"
        case .connect:           return "CONNECT"
        case .options:           return "OPTIONS"
        case .trace:             return "TRACE"
        case .patch:             return "PATCH"
        case .other(let method): return method.uppercased()
        }
    }
}
protocol Requestable {}
extension Requestable {
    internal func request(method: Method, url: String, params: [NSString: Any]? = nil, callback: @escaping Handler) {
        guard let url = URL(string: url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url,  completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let mappedModel = try? JSONDecoder().decode(LaunchesModel.self, from: data!)
                        if mappedModel != nil {
                            callback(.success(data!))
                        } else {
                            callback(.failure(true, error.debugDescription))
                        }
                    } else {
                        callback(.failure(true, error.debugDescription))
                    }
                }
            }
        })
        task.resume()
    }
}
