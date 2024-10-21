import SwiftUICore

protocol ProviderRepositoryProtocol {
    static var providerIsReady: Bool { get }
}

struct ProviderRepository: ProviderRepositoryProtocol {
    static var providerIsReady: Bool { ProviderDataSource.providerIsReady }
}
