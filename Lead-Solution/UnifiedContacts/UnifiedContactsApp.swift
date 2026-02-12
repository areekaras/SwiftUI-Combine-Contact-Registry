//
//  UnifiedContactsApp.swift
//  UnifiedContacts
//
//  Created by Shibili Areekara on 12/02/26.
//

import SwiftUI

@main
struct UnifiedContactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContactListView(
                viewModel: ContactListViewModel(
                    service: MockContactService()
                )
            )
        }
    }
}

struct MockContactService: ContactListService {
    func fetchContacts() async throws -> [Contact] {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        return [
            Contact(firstName: "Shibili", lastName: "Areekara", emailAddress: "hello@shibiliareekara.com"),
            Contact(firstName: "Cristiano", lastName: "Ronaldo", emailAddress: "cristiano@ronaldo.com"),
            Contact(firstName: "Lional", lastName: "Messi", emailAddress: "lional@messi.com")
        ]
    }
}
