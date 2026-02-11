//
//  UnifiedContactsTests.swift
//  UnifiedContactsTests
//
//  Created by Shibili Areekara on 12/02/26.
//

import XCTest
import UnifiedContacts

final class ContactListViewModelTests: XCTestCase {
    
    func test_init_doesNotSendMessageToService() {
        let (_, service) = makeSUT()
        
        XCTAssertEqual(service.fetchContactsCount, 0)
    }
    
    func test_fetchContacts_deliverSuccessResultWhenServiceSuccess() async throws {
        let (sut, service) = makeSUT()
        let contact = Contact(firstName: "Abc", lastName: "Last", emailAddress: "email@a.com")
        service.fetchContactResult = .success([contact])
        
        await sut.fetchContacts()
        XCTAssertEqual(sut.contacts, [contact])
    }
    
    func test_fetchContacts_deliverFailureResultWhenServiceFailed() async throws {
        let (sut, service) = makeSUT()
        let error = ContactListViewModel.FetchError.error(message: "Fetch Failed")
        service.fetchContactResult = .failure(error)
        
        await sut.fetchContacts()
        XCTAssertEqual(sut.errorMessage, error)
    }
    
    // Helpers
    private func makeSUT() -> (sut: ContactListViewModel, service: ServiceSpy)  {
        let service = ServiceSpy()
        let sut = ContactListViewModel(service: service)
        
        // trackForMemoryForLeaks for service for sut
        
        return (sut, service)
    }
    
    private final class ServiceSpy: ContactListService {
        var fetchContactsCount = 0
        
        var fetchContactResult: Result<[Contact], Error> = .success([])
        
        func fetchContacts() async throws -> [Contact] {
            fetchContactsCount += 1
            return try fetchContactResult.get()
        }
    }
}
