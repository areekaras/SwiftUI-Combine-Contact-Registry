//
//  Contact.swift
//  UnifiedContacts
//
//  Created by Shibili Areekara on 12/02/26.
//

import Foundation

public struct Contact: Equatable, Identifiable {
    public var id: String {
        return emailAddress
    }
    
    public let firstName: String
    public let lastName: String
    public let emailAddress: String
    
    public init(firstName: String, lastName: String, emailAddress: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
    }
}
