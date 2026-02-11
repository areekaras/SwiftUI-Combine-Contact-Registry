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
struct ContactListView: View {
    @State var viewModel: ContactListViewModel
    
    
    
    var body: some View {
        List {
            ForEach(viewModel.contacts) { contact in
                VStack {
                    Text("first name\(contact.firstName)")
                    Text("last name \(contact.lastName)")
                    Text("email:  \(contact.emailAddress)")
                }.padding()
            }
        }.onAppear {
            Task {
                await viewModel.fetchContacts()
                await viewModel.fetchContacts()
            }
        }
    }
}
