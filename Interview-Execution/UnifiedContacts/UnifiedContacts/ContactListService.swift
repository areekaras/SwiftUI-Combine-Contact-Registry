//
//  ContactListService.swift
//  UnifiedContacts
//
//  Created by Shibili Areekara on 12/02/26.
//

/// Protocol for fetching a list of contacts to be displayed in the app.
///
/// Use this protocol to define the interface for retrieving contact data.
///
/// Notes:
/// - Do **not** create a concrete implementation unless necessary; treat this as an abstraction only.
public protocol ContactListService {
    func fetchContacts() async throws -> [Contact]
}
