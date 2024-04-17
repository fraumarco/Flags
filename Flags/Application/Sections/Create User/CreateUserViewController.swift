//
//  CreateUserViewController.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation
import UIKit
import Combine

class CreateUserViewController: UIViewController, Storyboarded, UpdateViewProtocol {
    
    var viewModel: CreateUserViewModel?
    
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private var selectedCountry: String = ""
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidationObservers()
    }
    
    //Assigns fields values to published vars on viewmodel for fields validation and button enabling
    private func setupValidationObservers() {
        guard let viewModel = viewModel else { return }
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: nameTextField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: phoneNumberTextField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.phoneNumber, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.isButtonEnabled
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellables)
        
    }
    
    //Updates the view after loading the countries and eventually the selected user's data
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.countryPickerView.reloadAllComponents()
            
            if let name = viewModel?.getSelectedUserName() {
                nameTextField.text = name
            }
            
            if let countryIndex = viewModel?.getSelectedUserCountryIndex() {
                viewModel?.country = viewModel?.countries[countryIndex].commonName ?? ""
                self.countryPickerView.selectRow(countryIndex, inComponent: 0, animated: true)
            }
            
            if let phone = viewModel?.getSelectedUserPhone() {
                self.phoneNumberTextField.text = phone
            }
            
            if let email = viewModel?.getSelectedUserEmail() {
                self.emailTextField.text = email
            }
        }
    }
    
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        viewModel?.saveData(name: nameTextField.text ?? "", phoneNumber: phoneNumberTextField.text ?? "", email: emailTextField.text ?? "")
    }
}

//MARK: Functions for picker delegates
extension CreateUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.countries.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.countries[row].commonName ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.country = viewModel?.countries[row].commonName ?? ""
    }
}
