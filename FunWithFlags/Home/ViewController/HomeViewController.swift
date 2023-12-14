//
//  HomeViewController.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, Storyboarded {

    // MARK: - Stored
    enum RegionFilter: Int {
        case all = 0
        case africa = 1
        case americas = 2
        case asia = 3
        case europe = 4
        case oceania = 5
        
        var stringValue: String {
            switch self {
            case .all: return "all"
            case .africa: return "africa"
            case .asia: return "asia"
            case .europe: return "europe"
            case .oceania: return "oceania"
            case .americas: return "americas"
            }
        }
    }
    
    private var countriesViewModel: CountriesViewModel!
    private let refreshControl = UIRefreshControl()
    private let throttler = FWFThrottler(minimumDelay: 0.3)
    private var currentRegionFilterSubject = PublishSubject<RegionFilter>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Stored (IBOutlet)
    @IBOutlet weak var searchTextField: FWFPaddedTextField!
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet var customSegmentedControl: [UIButton]!
    
    // MARK: - App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountriesViewModel()
        configureRefreshControl()
        configureCountryTableView()
        configureSearchTextField()
        configureRegionFilterSubject()
    }

    // MARK: - Instance
    private func configureCountryTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.refreshControl = refreshControl
    }
    
    private func configureCountriesViewModel() {
        countriesViewModel = CountriesViewModel()
        countriesViewModel.delegate = self
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }
    
    @objc private func refreshData() {
        countriesViewModel.getAllCountries()
    }
    
    private func configureSearchTextField() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(didUpdateTextField(_:)), for: .editingChanged)
    }
    
    @objc private func didUpdateTextField(_ textField: UITextField) {
        searchCountry(using: textField)
    }
    
    private func searchCountry(using textField: UITextField) {
        guard let searchText = textField.text, !searchText.replacingOccurrences(of: " ", with: "").isEmpty else {
            countriesViewModel.getAllCountries()
            return
        }
        throttler.throttle { [weak self] in
            self?.countriesViewModel.searchCountry(by: textField.text ?? "")
        }
    }
    
    private func configureRegionFilterSubject() {
        currentRegionFilterSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (value) in
            guard let self = self else { return }
            self.updateSegmentedControl(using: value)
            if value == .all {
                self.countriesViewModel.getAllCountries()
            } else {
                self.countriesViewModel.searchCountry(by: value)
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateSegmentedControl(using regionFilter: RegionFilter) {
        for (index, button) in customSegmentedControl.enumerated() {
            if index == regionFilter.rawValue {
                button.backgroundColor = .systemGreen
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.darkGray, for: .normal)
            }
        }
    }
    
    // MARK: - Instance (IBAction)
    
    @IBAction func didTapAll(_ sender: Any) {
        currentRegionFilterSubject.onNext(.all)
    }
    
    @IBAction func didTapAfrica(_ sender: Any) {
        currentRegionFilterSubject.onNext(.africa)
    }
    
    @IBAction func didTapAsia(_ sender: Any) {
        currentRegionFilterSubject.onNext(.asia)
    }
    
    @IBAction func didTapAmericas(_ sender: Any) {
        currentRegionFilterSubject.onNext(.americas)
    }
    
    @IBAction func didTapEurope(_ sender: Any) {
        currentRegionFilterSubject.onNext(.europe)
    }
    
    @IBAction func didTapOceania(_ sender: Any) {
        currentRegionFilterSubject.onNext(.oceania)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        cell.configure(with: countriesViewModel.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentCountryDetail(country: countriesViewModel.data[indexPath.row])
    }
}

// MARK: - CountriesViewModelDelegate
extension HomeViewController: CountriesViewModelDelegate {
    func countriesViewModel(startedGettingDataOf viewModel: CountriesViewModel) {
        countriesTableView.removeBackgroundMessage()
        refreshControl.beginRefreshing()
    }
    
    func countriesViewModel(didUpdateDataOf viewModel: CountriesViewModel) {
        refreshControl.endRefreshing()
        countriesTableView.reloadData()
    }
    
    func countriesViewModel(didReceive error: Error) {
        countriesTableView.setBackgroundMessage(error.localizedDescription)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTextField {
            searchCountry(using: textField)
        }
    }
}

extension HomeViewController: CountryDetailPresenting {
    func presentCountryDetail(country: Country) {
        let vc = CountryDetailViewController.instantiate()
        vc.country = country
        present(vc, animated: true, completion: nil)
    }
}
