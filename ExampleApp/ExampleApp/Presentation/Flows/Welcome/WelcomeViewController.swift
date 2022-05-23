//
//  WelcomeViewController.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit

class WelcomeViewController: AppViewController {
    
    // MARK: - Initialization
    let coordinator: WelcomeCoordinator
    
    init(coordinator: WelcomeCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        bindButtonToCoordinator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Welcome"
    }
    
    // MARK: - Binding
    private func bindButtonToCoordinator() {
        actionButton.publisher(for: .touchUpInside)
            .sink { [unowned coordinator] in
                coordinator.navigateToMain()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Subviews
    private let actionButton: UIButton = {
        let button = AppButton()
        button.configure(
            with: "To Main",
            and: .systemPurple
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Subviews Setup
    private func setupSubviews() {
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            actionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

