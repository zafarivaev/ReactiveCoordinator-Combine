import Combine

open class Coordinator<CoordinationResult> {
    
    public var cancellables = Set<AnyCancellable>()
    
    public init() {}
    
    @discardableResult
    open func coordinate<T>(
        to coordinator: Coordinator<T>
    ) -> AnyPublisher<T, Never> {
        
        return coordinator.start()
    }
    
    open func start() -> AnyPublisher<CoordinationResult, Never> {
        fatalError("start() method must be implemented")
    }
}
