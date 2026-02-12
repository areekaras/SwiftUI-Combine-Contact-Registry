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
class ContactListViewModel: ObservableObject {
    let service: ContactListService
    
    init(service: ContactListService) {
        self.service = service
    }
    
    func fetchContacts() async {
        _ = try? await service.fetchContacts()
    }
}
