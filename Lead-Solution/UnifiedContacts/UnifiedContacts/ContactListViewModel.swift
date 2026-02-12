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

@MainActor
final class ContactListViewModel: ObservableObject {
    @Published private(set) var state: ViewState = .idle
    
    enum ViewState: Equatable {
        case idle
        case loading
        case success([Contact])
        case error(String)
    }

    private let service: ContactListService
    
    init(service: ContactListService) {
        self.service = service
    }
    
    func fetchContacts() async {
        state = .loading
        do {
            let contacts = try await service.fetchContacts()
            state = .success(contacts)
        } catch {
            
        }
    }
}
