//
//  File.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 26/12/23.
//
import Foundation
import UIKit
class Utils {
    func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         let oldDate = olDateFormatter.date(from: inputDate)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "EEEE, MMM d, yyyy"
         return convertDateFormatter.string(from: oldDate ?? Date())
    }
}
