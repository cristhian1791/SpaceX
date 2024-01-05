//
//  WebServiceManager.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 26/12/23.
//
import UIKit
import Alamofire
class WebServiceManager {
    static var instance: WebServiceManager!
    /// SHARED INSTANCE
    class func sharedInstance() -> WebServiceManager {
        self.instance = (self.instance ?? WebServiceManager())
        return self.instance
    }
    /// METHODS
    init() {
        print(#function)
    }
    func fetchLaunchesList (params: [NSString: Any]?, completionHandler: @escaping Handler)   {
        AF.request(Domain.baseUrl() + APIEndpoint.launches)
            .responseDecodable(of: LaunchesModel.self) { response in
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    do{
                        let _ = try JSONDecoder().decode(LaunchesModel.self, from: response.data!)
                        completionHandler(.success(response.data!))
                    }catch{
                        completionHandler(.failure(true, error.localizedDescription))
                        print(error)
                    }
                case .failure(let error):
                    completionHandler(.failure(true, error.errorDescription.valueOrEmpty))
                }
        }
    }
}



