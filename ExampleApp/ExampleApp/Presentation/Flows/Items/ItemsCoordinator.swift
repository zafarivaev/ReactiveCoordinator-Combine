//
//  ItemsCoordinator.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 08/05/22.
//

import UIKit
import ReactiveCoordinator
import Combine

enum ItemsCoordinationResult {
    case item(String)
}

final class ItemsCoordinator: Coordinator<ItemsCoordinationResult> {
    unowned let navigationController: UINavigationController
    public let coordinationResult = PassthroughSubject<ItemsCoordinationResult, Never>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> AnyPublisher<ItemsCoordinationResult, Never> {
        let viewController = ItemsViewController(coordinator: self)
        navigationController.present(viewController, animated: true, completion: nil)
        
        return coordinationResult.eraseToAnyPublisher()
    }
}
