//
//  Global.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 26/12/23.
//
import UIKit
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func load(url: URL) {
        let urlString = url.absoluteString
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension Optional where Wrapped == String {
    /// Garantiza el retorno de un String, si es opcional será una cadena vacia.
    var valueOrEmpty: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}
extension Date {
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }
}
