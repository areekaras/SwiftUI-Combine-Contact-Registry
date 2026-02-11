//
//  ContactListViewModelTests.swift
//  UnifiedContactsTests
//
//  Created by Shibili Areekara on 12/02/26.
//

import XCTest
@testable import UnifiedContacts

final class ContactListViewModelTests: XCTestCase {
    func test_init_doesNotMessageService() {
        let (_, service) = makeSUT()
        
        XCTAssertTrue(service.messages.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: ContactListViewModel, service: ServiceSpy) {
        let service = ServiceSpy()
        let sut = ContactListViewModel(service: service)
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
