import SwiftUICore

protocol ProviderDataSourceProtocol: ObservableObject {
   static var providerIsReady: Bool { get set }
}

struct ProviderDataSource {
    static var providerIsReady = true
}
