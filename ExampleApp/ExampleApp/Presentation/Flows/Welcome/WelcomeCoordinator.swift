//
//  WelcomeCoordinator.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit
import ReactiveCoordinator
import Combine

final class WelcomeCoordinator: Coordinator<Void> {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        let viewController = WelcomeViewController(
            coordinator: self
        )
        navigationController.pushViewController(
            viewController,
            animated: false
        )
        
        return Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Navigation
    public func navigateToMain() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
