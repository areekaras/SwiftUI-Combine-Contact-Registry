//
//  ContactListViewModelSwiftTests.swift
//  UnifiedContactsTests
//
//  Created by Shibili Areekara on 13/02/26.
//

import Testing
import Foundation
@testable import UnifiedContacts

@MainActor
struct ContactListViewModelSwiftTests {
    
    @Test("Initial state does not message service")
    func initState_doesNotMessageService() {
        let (_, service) = makeSUT()
        #expect(service.messages.isEmpty)
    }
    
    @Test("Fetch contacts triggers service request")
    func fetchContacts_requestsDataFromService() async {
        let (sut, service) = makeSUT()
        
        await sut.fetchContacts()
        
        #expect(service.messages == [.fetchContacts])
    }
    
    @Test("Successful fetch delivers contacts to state")
    func fetchContacts_deliversContactsOnSuccess() async {
        let contacts = [Contact(firstName: "Shibili", lastName: "Areekara", emailAddress: "test@test.com")]
        let (sut, service) = makeSUT()
        service.fetchResult = .success(contacts)
        
        await sut.fetchContacts()
        
        if case .success(let receivedContacts) = sut.state {
            #expect(receivedContacts == contacts)
        } else {
            Issue.record("Expected .success state, got \(sut.state)")
        }
    }
    
    @Test("Service error updates state to error message")
    func fetchContacts_deliversErrorOnServiceError() async {
        let (sut, service) = makeSUT()
        let error = NSError(domain: "TestError", code: 0)
        service.fetchResult = .failure(error)
        
        await sut.fetchContacts()
        
        if case .error(let message) = sut.state {
            #expect(!message.isEmpty)
        } else {
            Issue.record("Expected .error state, got \(sut.state)")
        }
    }

    // MARK: - Helpers
    
    private func makeSUT() -> (sut: ContactListViewModel, service: ServiceSpy) {
        let service = ServiceSpy()
        let sut = ContactListViewModel(service: service)
        // Swift Testing handles lifecycle differently; memory leak tracking
        // is typically handled at the integration/XCTest level for now.
        return (sut, service)
    }
    
    private final class ServiceSpy: ContactListService {
        enum Message: Equatable {
            case fetchContacts
        }
        var messages: [Message] = []
        var fetchResult: Result<[Contact], Error> = .success([])
        
        func fetchContacts() async throws -> [Contact] {
            messages.append(.fetchContacts)
            return try fetchResult.get()
        }
    }
}
