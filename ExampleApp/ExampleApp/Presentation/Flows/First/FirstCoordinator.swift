//
//  FirstCoordinator.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit
import ReactiveCoordinator
import Combine

final class FirstCoordinator: Coordinator<Void> {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        let viewController = FirstViewController(
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
    public func presentItems() -> AnyPublisher<ItemsCoordinationResult, Never> {
        let coordinator = ItemsCoordinator(
            navigationController: navigationController
        )
        
        return coordinate(to: coordinator)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.navigationController.dismiss(animated: true, completion: nil)
            })
            .eraseToAnyPublisher()
    }
}
