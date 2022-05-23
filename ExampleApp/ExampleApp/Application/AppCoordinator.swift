//
//  AppCoordinator.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit
import ReactiveCoordinator
import Combine

final class AppCoordinator: Coordinator<Void> {
    unowned let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let navigationController = AppNavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let welcomeCoordinator = WelcomeCoordinator(
            navigationController: navigationController
        )
        return coordinate(to: welcomeCoordinator)
    }
}


