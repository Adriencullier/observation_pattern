import Combine

/// Aims to define an observable actor service
public protocol ObservableService: Actor {
    /// Current value subject which will own service state
    var currentValueSubject: CurrentValueSubject<ServiceState?, Never> { get }
    /// Set of any cancellables to own task cancellation logic
    var cancellables: Set<AnyCancellable> { get set }
}

/// Public extension with updateObservers & observe
public extension ObservableService {
    /// Aims to update all the observers with the new state
    /// - Parameter state: new state to send to observers
    func updateObservers(_ state: ServiceState) {
        self.currentValueSubject.send(state)
    }
    
    /// Aims to observe the state of the service
    /// - Returns: AsyncStream<ServiceState>
    func observe() -> AsyncStream<ServiceState> {
        AsyncStream { continuation in
            Task {
                for await state in self.publisherState {
                    continuation.yield(state)
                }
            }
            .store(in: &self.cancellables)
        }
    }
}
