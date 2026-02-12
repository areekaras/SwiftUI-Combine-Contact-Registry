//
//  Contact.swift
//  UnifiedContacts
//
//  Created by Shibili Areekara on 12/02/26.
//

import Foundation

struct Contact: Equatable, Identifiable, Sendable {
    // Computed property to satisfy Identifiable using the unique email
    var id: String { emailAddress }
    
    let firstName: String
    let lastName: String
    let emailAddress: String
}
