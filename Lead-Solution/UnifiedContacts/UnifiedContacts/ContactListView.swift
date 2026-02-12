//
//  ContactListView.swift
//  UnifiedContacts
//
//  Created by Shibili Areekara on 12/02/26.
//

import SwiftUI

/// `ContactListView`
///
/// TODO:
///
/// Displays a list of contacts with the following details:
/// - First Name
/// - Last Name
/// - Email Address
///
import SwiftUI

struct ContactListView: View {
    @StateObject var viewModel: ContactListViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Fetching contacts...")
                case .success(let contacts):
                    if contacts.isEmpty {
                        Text("No contacts found.")
                            .foregroundColor(.secondary)
                    } else {
                        List(contacts) { contact in
                            ContactRow(contact: contact)
                        }
                    }
                case .error(let message):
                    VStack(spacing: 16) {
                        Text(message)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Try Again") {
                            Task { await viewModel.fetchContacts() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .navigationTitle("Contacts")
            .task {
                await viewModel.fetchContacts()
            }
        }
    }
}

private struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.headline)
            Text(contact.emailAddress)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContactListView(
        viewModel: ContactListViewModel(
            service: MockContactService()
        )
    )
}
