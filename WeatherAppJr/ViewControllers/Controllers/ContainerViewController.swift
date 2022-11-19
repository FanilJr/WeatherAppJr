//
//  ContainerViewController.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 05.11.2022.
//

import UIKit

class ContainerViewController: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    let settingsVC = SettingsViewController()
    lazy var infoVc = InfoViewController()
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        addChildVc()

    }

    private func addChildVc() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
            // Animate the menu
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = 0
            
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .home:
            self.resetToHome()
        case .info:
            // Add info child
            self.addInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .settings:
            self.addSettings()
        }
    }
    
    func addInfo() {
        let vc = infoVc

        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func resetToHome() {
        
        if settingsVC.isViewLoaded {
            settingsVC.view.removeFromSuperview()
            settingsVC.didMove(toParent: nil)
            homeVC.title = "Главная"
        }
        
        if infoVc.isViewLoaded {
            infoVc.view.removeFromSuperview()
            infoVc.didMove(toParent: nil)
            homeVC.title = "Главная"
        }
    }
    
    func addSettings() {
        let vc = settingsVC
        
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
}
