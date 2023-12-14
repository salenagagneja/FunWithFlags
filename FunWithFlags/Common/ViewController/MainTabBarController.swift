//
//  MainTabBarController.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    private func configureTabs() {
        self.viewControllers = [createHomeView(), createFlashCardsView()]
    }
    
    private func createHomeView() -> UINavigationController {
        let navigationController = UINavigationController()
        let vc = HomeViewController.instantiate()
        vc.navigationItem.title = "🇬🇾🇭🇹🇭🇳 Fun with Flags 🇭🇰🇭🇺🇮🇸"
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
    
    private func createFlashCardsView() -> UINavigationController {
        let navigationController = UINavigationController()
        let vc = FlashCardsViewController.instantiate()
        vc.navigationItem.title = "Flash Cards"
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
}
