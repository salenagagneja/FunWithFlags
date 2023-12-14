//
//  HomeService.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import Alamofire

typealias GetCountriesResult = ([Country]?, Error?) -> Void

final class HomeService {
    private init() {}
    static let shared = HomeService()
    internal var serviceHelper: ServiceHelper = ServiceHelper.shared
    
    func getAllCountries(completion: @escaping GetCountriesResult) {
        AF.request(Router.getAllCountries).responseDecodable { (response: AFDataResponse<[Country]>) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                completion(nil, self.serviceHelper.encodeBackendMessageAsError(from: response.data, statusCode: response.response?.statusCode, responseError: response.error))
                return
            }
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func searchCountry(by name: String, completion: @escaping GetCountriesResult) {
        AF.request(Router.searchCountryBy(name: name)).responseDecodable { (response: AFDataResponse<[Country]>) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                completion(nil, self.serviceHelper.encodeBackendMessageAsError(from: response.data, statusCode: response.response?.statusCode, responseError: response.error))
                return
            }
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func searchCountry(by region: HomeViewController.RegionFilter, completion: @escaping GetCountriesResult) {
        AF.request(Router.searchCountryByRegion(region: region)).responseDecodable { (response: AFDataResponse<[Country]>) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                completion(nil, self.serviceHelper.encodeBackendMessageAsError(from: response.data, statusCode: response.response?.statusCode, responseError: response.error))
                return
            }
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
