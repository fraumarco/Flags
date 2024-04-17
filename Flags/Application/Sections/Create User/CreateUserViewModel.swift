//
//  CreateUserViewModel.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation
import Combine

class CreateUserViewModel: ObservableObject {
    
    var viewProtocol: UpdateViewProtocol?
    var countries = [CountryModel]()
    
    private var selectedUser: User?
    
    //Published vars for fields validation
    @Published var name: String = ""
    @Published var country: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    
    init() {
        getCountries()
    }
    
    func getCountries() {
        Task {
            let response = try? await CreateUserApiHandler.shared.getCountries()
            
            guard let response = response else {
                return
            }
            
            countries.append(CountryModel(commonName: "-")) //Used as first element before user selection
            
            countries = response.sorted(by: { $0.name?.common ?? "" < $1.name?.common ?? "" }).compactMap({ CountryModel(commonName: $0.name?.common ?? "") }) //Maps alphabetically ordered countries response on an internal model
            
            countries.removeAll(where: { $0.commonName == "" }) //Removes eventually
            
            viewProtocol?.updateView()
        }
    }
    
    func saveData(name: String, phoneNumber: String, email: String) {
        var user: User!
        if let selectedUser = selectedUser {
            user = selectedUser
            user.id = selectedUser.id
        } else {
            user = User(context: CoreDataManager.shared.viewContext)
            user.id = UUID()
        }
        
        user.name = name
        user.country = self.country
        user.phone = phoneNumber
        user.email = email
        
        CoreDataManager.shared.saveContext()
    }
    
    //Fetch user on DB by id
    func fetchUser(userId: UUID) {
        do {
            let request = User.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", userId as NSUUID)
            self.selectedUser = try CoreDataManager.shared.viewContext.fetch(request).first
            self.name = self.selectedUser?.name ?? ""
            self.country = self.selectedUser?.country ?? ""
            self.phoneNumber = self.selectedUser?.phone ?? ""
            self.email = self.selectedUser?.email ?? ""
        } catch {
            print("Error fetching user from database")
        }
    }
    
    func getSelectedUserName() -> String? {
        return self.selectedUser?.name
    }
    
    func getSelectedUserCountryIndex() -> Int? {
        guard let country = selectedUser?.country else { return nil }
        return countries.firstIndex(where: { $0.commonName == country })
    }
    
    func getSelectedUserPhone() -> String? {
        return self.selectedUser?.phone
    }
    
    func getSelectedUserEmail() -> String? {
        return self.selectedUser?.email
    }
}


//MARK: Puiblishers for fields validation
extension CreateUserViewModel {
    
    var isValidNamePublisher: AnyPublisher<Bool, Never> {
        $name
            .map { $0.isValidName }
            .eraseToAnyPublisher()
    }

    var isValidCountryPublisher: AnyPublisher<Bool, Never> {
        $country
            .map { $0.isValidCountry }
            .eraseToAnyPublisher()
    }
    
    var isValidPhoneNumberPublisher: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.isValidPhoneNumber }
            .eraseToAnyPublisher()
    }
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map{ $0.isValidEmail }
            .eraseToAnyPublisher()
    }
    
    var isButtonEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isValidNamePublisher, isValidCountryPublisher, isValidPhoneNumberPublisher, isValidEmailPublisher)
            .map { $0 && $1 && $2 && $3 }
            .eraseToAnyPublisher()
    }
    
}
