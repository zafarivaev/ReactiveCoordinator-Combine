//
//  AppViewController.swift
//  ExampleApp
//
//  Created by Zafar Ivaev on 07/05/22.
//

import UIKit
import Combine

class AppViewController: UIViewController {
    
    public var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
    }
}
