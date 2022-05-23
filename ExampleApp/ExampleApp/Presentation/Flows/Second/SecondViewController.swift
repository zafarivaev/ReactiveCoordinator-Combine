//
//  SecondViewController.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit

class SecondViewController: AppViewController {

    // MARK: - Initialization
    let coordinator: SecondCoordinator
    
    init(coordinator: SecondCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemFill
        setupSubviews()
        bindActionButtonToCoordinator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Second"
    }
    
    // MARK: - Binding
    private func bindActionButtonToCoordinator() {
        actionButton
            .publisher(for: .touchUpInside)
            .flatMap { [unowned self] _ in
                self.coordinator.presentItems()
            }
            .sink { result in
                if case let .item(title) = result {
                    print(title)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Subviews
    private let actionButton: UIButton = {
        let button = AppButton()
        button.configure(
            with: "Select Item",
            and: .systemIndigo
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Setup Subviews
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
