# ReactiveCoordinator
ReactiveCoordinator is a framework based on the Coordinator pattern. Implemented in Combine.

## Requirements

- iOS 14.0
- Swift 5

## How To Use

Inherit from ReactiveCoordinator in Coordinator subclasses:

```swift
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
}
```

## Replace Delegation with ReactiveCoordinator

In presented Coordinator:

```swift
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
```

In presenting Coordinator:

```swift
final class FirstCoordinator: Coordinator<Void> {
    
    ...
    
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
```

In presenting Coordinator's view controller:

```swift
override func viewDidLoad() {
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
```

## License

ReactiveCoordinator is released under the MIT license. [See LICENSE](https://github.com/zafarivaev/ReactiveCoordinator/blob/master/LICENSE) for details.

