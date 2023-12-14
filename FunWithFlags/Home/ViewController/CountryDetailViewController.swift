//
//  CountryDetailViewController.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import UIKit

protocol CountryDetailPresenting: NSObject {
    func presentCountryDetail(country: Country)
}

class CountryDetailViewController: FWFPopupViewController, Storyboarded {

    var country: Country?
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subregionLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var demonymLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var timezonesLabel: UILabel!
    
    override func viewDidLoad() {
        self.containerView = popupView
        super.viewDidLoad()
        shouldDismissOnSwipeDown = false
        configureUI()
    }
    
    private func configureUI() {
        if let alpha2Code = country?.alpha2Code {
            flagImageView.image = UIImage(named: "\(alpha2Code.lowercased()).png")
        }
        countryNameLabel.text = country?.name
        regionLabel.text = country?.region
        subregionLabel.text = country?.subregion
        capitalLabel.text = country?.capital
        populationLabel.text = FWFNumberFormatter.shared.formatNumberForPopulation(number: country?.population)
        demonymLabel.text = country?.demonym
        languagesLabel.text = getLanguagesAsString(country: country)
        timezonesLabel.text = getTimeZonesListAsString(country: country)
        currenciesLabel.text = getCurrenciesAsString(country: country)
    }
    
    private func getTimeZonesListAsString(country: Country?) -> String? {
        guard let country = country else { return nil }
        return country.timezones?.joined(separator: "\n")
    }
    
    private func getLanguagesAsString(country: Country?) -> String? {
        guard let country = country else { return nil }
        let languagesArray = country.languages?.compactMap({ $0.name })
        return languagesArray?.joined(separator: "\n")
    }
    
    private func getCurrenciesAsString(country: Country?) -> String? {
        guard let country = country else { return nil }
        let currenciesArray = country.currencies?.compactMap({ return "\($0.name ?? "") (\($0.symbol ?? ""))"})
        return currenciesArray?.joined(separator: "\n")
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
