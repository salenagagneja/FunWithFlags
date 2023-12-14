//
//  Router.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import Alamofire

//swiftlint:disable no_fallthrough_only
enum Router: URLRequestConvertible, URLConvertible {

    case getAllCountries
    case searchCountryBy(name: String)
    case searchCountryByRegion(region: HomeViewController.RegionFilter)
    
    private var baseURLString: String {
        return "https://restcountries.com/"
    }
    
    private var apiVersion: String {
        return "v2"
    }

    private var method: HTTPMethod {
        switch self {
        case .getAllCountries: fallthrough
        case .searchCountryBy: fallthrough
        case .searchCountryByRegion: return .get
        }
    }

    private var path: String {
        switch self {
        case .getAllCountries: return "/all"
        case .searchCountryBy(let name): return "/name/\(name)"
        case .searchCountryByRegion(let region): return "/region/\(region.stringValue)"
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try self.baseURLString.asURL().appendingPathComponent(apiVersion).appendingPathComponent(path)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .getAllCountries, .searchCountryBy, .searchCountryByRegion: break
        }
        return urlRequest
    }
    
    func asURL() throws -> URL {
        return try self.baseURLString.asURL()
    }
}
