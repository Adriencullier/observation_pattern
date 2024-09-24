import Combine

extension Task {
    /// Aims to store and cancel all initiated tasks when the observer is dealocated
    /// Whithout it, the tasks will never finish, since the async stream tasks will never finish.
    /// - Parameter cancellables: inout Set<AnyCancellable>
    func store(in cancellables: inout Set<AnyCancellable>) {
        cancellables.insert(
            AnyCancellable({
                self.cancel()
            })
        )
    }
}
