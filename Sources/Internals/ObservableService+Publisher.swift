import Combine

/// Private extension with asyncpublisher
extension ObservableService {
    /// Async publisher which will be observed in observe function
    var publisherState: AsyncPublisher<AnyPublisher<ServiceState, Never>> {
        return self.currentValueSubject
            .compactMap({ $0 })
            .eraseToAnyPublisher()
            .values
    }
}
