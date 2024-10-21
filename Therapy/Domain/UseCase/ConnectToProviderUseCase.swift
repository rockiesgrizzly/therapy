import SwiftUICore

protocol ConnectToProviderUseCaseProtocol {
    static var providerIsReady: Bool { get }
}

struct ConnectToProviderUseCase: ConnectToProviderUseCaseProtocol {
    static var providerIsReady: Bool {
        ProviderRepository.providerIsReady
    }
}
