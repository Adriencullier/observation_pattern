/// Aims to list all the possible service states
public enum ServiceState: Sendable {
    case none
    case loading
    case error(error: Error)
    case success
}
