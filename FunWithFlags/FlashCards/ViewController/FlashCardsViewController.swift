//
//  FlashCardsViewController.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import UIKit

class FlashCardsViewController: UIViewController, Storyboarded {

    // MARK: - Stored
    private var isCardOnBack: Bool = false
    private let animationSpeed = 0.5
    
    // MARK: - Stored (IBOutlet)
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet var flagContainerView: UIView!
    @IBOutlet var backCardContainerView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var cardContainerView: UIView!
    
    // MARK: - App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    // MARK: - Instance
    private func initializeUI() {
        getCountriesAndStoreLocally { [weak self] in
            guard let self = self else { return }
            self.setRandomFlagToUI()
        }
        
        cardContainerView.dropShadow()
    }
    
    private func getCountriesAndStoreLocally(completion: @escaping () -> Void) {
        HomeService.shared.getAllCountries { (countries, error) in
            if let countries = countries {
                FWFUserDefaultsManager.shared.storeCountriesData(data: countries)
            }
            completion()
        }
    }
    
    private func getCountriesFromLocalStorage() -> [Country] {
        return FWFUserDefaultsManager.shared.getLocalCountriesData()
    }
    
    private func getRandomCountry() -> Country {
        let countries = getCountriesFromLocalStorage()
        let randomIndex = Int.random(in: 0..<countries.count)
        return countries[randomIndex]
    }
    
    private func setCountryToUI(using country: Country) {
        if let alpha2Code = country.alpha2Code {
            flagImageView.image = UIImage(named: "\(alpha2Code.lowercased()).png")
        }
        
        countryNameLabel.text = country.name
    }
    
    private func setRandomFlagToUI() {
        self.setCountryToUI(using: self.getRandomCountry())
        flipFlashCard()
    }
    
    private func flipFlashCard() {
        UIView.transition(with: self.cardContainerView, duration: self.animationSpeed, options: [.transitionFlipFromTop]) { [weak self] in    self?.backCardContainerView.isHidden = true
            self?.flagContainerView.isHidden = false
        }
        isCardOnBack = false
    }
    
    private func flipFlashCardToBack() {
        UIView.transition(with: cardContainerView, duration: animationSpeed, options: [.transitionFlipFromLeft]) {
            if self.isCardOnBack {
                self.backCardContainerView.isHidden = true
                self.flagContainerView.isHidden = false
            } else {
                self.backCardContainerView.isHidden = false
                self.flagContainerView.isHidden = true
            }
        } completion: { (success) in
            self.isCardOnBack.toggle()
        }
    }
    
    // MARK: - Instance (IBAction)
    @IBAction func didTapNextFlag(_ sender: Any) {
        self.setRandomFlagToUI()
    }
    
    @IBAction func didTapFlashCard(_ sender: Any) {
        flipFlashCardToBack()
    }
}
