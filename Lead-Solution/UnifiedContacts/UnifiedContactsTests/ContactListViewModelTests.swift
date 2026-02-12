//
//  ContactListViewModelTests.swift
//  UnifiedContactsTests
//
//  Created by Shibili Areekara on 12/02/26.
//

import XCTest
@testable import UnifiedContacts

@MainActor
final class ContactListViewModelTests: XCTestCase {
    func test_init_doesNotMessageService() {
        let (_, service) = makeSUT()
        
        XCTAssertTrue(service.messages.isEmpty)
    }
    
    func test_fetchContacts_requestsDataFromService() async {
        let (sut, service) = makeSUT()
        
        await sut.fetchContacts()
        
        XCTAssertEqual(service.messages, [.fetchContacts])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: ContactListViewModel, service: ServiceSpy) {
        let service = ServiceSpy()
        let sut = ContactListViewModel(service: service)
        
        // As a Lead, we ensure the test suite is robust against memory leaks
        trackForMemoryLeaks(service, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, service)
    }
    
    private final class ServiceSpy: ContactListService {
        enum Message: Equatable {
            case fetchContacts
        }
        
        var messages: [Message] = []
        
        // Using Result type allows us to inject success or failure scenarios easily
        var fetchResult: Result<[Contact], Error> = .success([])
        
        func fetchContacts() async throws -> [Contact] {
            messages.append(.fetchContacts)
            return try fetchResult.get()
        }
    }
}
