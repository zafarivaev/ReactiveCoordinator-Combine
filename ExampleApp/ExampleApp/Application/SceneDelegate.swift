//
//  SceneDelegate.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.coordinator = AppCoordinator(window: window)
        self.coordinator?.start()
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
    }

}

