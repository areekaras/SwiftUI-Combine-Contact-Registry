//
//  ContactListViewModel.swift
//  UnifiedContacts
//
//  Created by Shibili Areekara on 12/02/26.
//

import Combine

/// `ContactListViewModel`
///
/// Responsible for managing and preparing contact data for the view.
///
/// TODO:
/// - Fetches the list of contacts from a REST API.
/// - Caches contacts locally for performance and offline access.
/// - Exposes formatted data to the `ContactListView` for presentation.
///
public final class ContactListViewModel: ObservableObject {
    let service: ContactListService
    
    @Published public private(set) var contacts: [Contact] = []
    @Published public private(set) var errorMessage: FetchError?
    
    public enum FetchError: Error, Equatable {
        case error(message: String)
        case unknown
    }
    
    public init(service: ContactListService) {
        self.service = service
    }
    
    public func fetchContacts() async {
        do {
            contacts = try await service.fetchContacts()
            errorMessage = nil
        } catch {
            if let error = error as? FetchError {
                errorMessage = error
            } else {
                errorMessage = .unknown
            }
        }
    }
}
