//
//  AppURL.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 26/12/23.
//
import UIKit
struct Domain {
    static var dev = "https://api.spacexdata.com/"
    static var assest = "https://api.spacexdata.com/"
}
extension Domain {
    static func baseUrl() -> String {
        print(Domain.dev)
        return Domain.dev
    }
}
struct APIEndpoint {
    static let launches = "v3/launches/past"
}
enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}
enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}
enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}
enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}
enum UploadType: String {
    case avatar
    case file
}
