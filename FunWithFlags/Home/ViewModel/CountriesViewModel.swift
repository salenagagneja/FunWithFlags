//
//  CountriesViewModel.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation

protocol CountriesViewModelDelegate: NSObject {
    func countriesViewModel(didReceive error: Error)
    func countriesViewModel(startedGettingDataOf viewModel: CountriesViewModel)
    func countriesViewModel(didUpdateDataOf viewModel: CountriesViewModel)
}

class CountriesViewModel: NSObject {
    
    weak var delegate: CountriesViewModelDelegate?
    var data: [Country] = []
    
    override init() {
        super.init()
        getAllCountries()
    }
    
    private func resetData() {
        data.removeAll()
        self.delegate?.countriesViewModel(didUpdateDataOf: self)
    }
    
    @objc func getAllCountries() {
        self.resetData()
        delegate?.countriesViewModel(startedGettingDataOf: self)
        HomeService.shared.getAllCountries { [weak self] (countries, error) in
            guard let self = self else { return }
            if let countries = countries {
                self.data = countries
            } else if let error = error {
                self.delegate?.countriesViewModel(didReceive: error)
            }
            self.delegate?.countriesViewModel(didUpdateDataOf: self)
        }
    }
    
    func searchCountry(by name: String) {
        self.resetData()
        delegate?.countriesViewModel(startedGettingDataOf: self)
        HomeService.shared.searchCountry(by: name, completion: { [weak self] (countries, error) in
            guard let self = self else { return }
            if let countries = countries {
                self.data = countries
            } else if let error = error {
                self.delegate?.countriesViewModel(didReceive: error)
            }
            self.delegate?.countriesViewModel(didUpdateDataOf: self)
        })
    }
    
    func searchCountry(by region: HomeViewController.RegionFilter) {
        self.resetData()
        delegate?.countriesViewModel(startedGettingDataOf: self)
        HomeService.shared.searchCountry(by: region, completion: { [weak self] (countries, error) in
            guard let self = self else { return }
            if let countries = countries {
                self.data = countries
            } else if let error = error {
                self.delegate?.countriesViewModel(didReceive: error)
            }
            self.delegate?.countriesViewModel(didUpdateDataOf: self)
        })
    }
}
