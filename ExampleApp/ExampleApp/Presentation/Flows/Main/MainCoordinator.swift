//
//  MainCoordinator.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit
import ReactiveCoordinator
import Combine

final class MainCoordinator: Coordinator<Void> {
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let firstNavigationController = AppNavigationController()
        firstNavigationController.tabBarItem = UITabBarItem(
            title: "First",
            image: UIImage(systemName: "circle"),
            selectedImage: UIImage(systemName: "circle.fill")
        )
        
        let secondNavigationController = AppNavigationController()
        secondNavigationController.tabBarItem = UITabBarItem(
            title: "Second",
            image: UIImage(systemName: "square"),
            selectedImage: UIImage(systemName: "square.fill")
        )
        
        let tabBarController = MainTabBarController(
            coordinator: self
        )
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.viewControllers = [
            firstNavigationController,
            secondNavigationController
        ]
        
        navigationController.present(
            tabBarController, 
            animated: true, 
            completion: nil
        )
        
        let firstCoordinator = FirstCoordinator(
            navigationController: firstNavigationController
        )
        let secondCoordinator = SecondCoordinator(
            navigationController: secondNavigationController
        )
        
        coordinate(to: firstCoordinator)
        coordinate(to: secondCoordinator)
        
        return Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
}
