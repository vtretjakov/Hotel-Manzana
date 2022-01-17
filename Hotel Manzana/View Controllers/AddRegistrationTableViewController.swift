//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Владимир on 16.01.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    
    @IBOutlet var checkInDatePicker: UIDatePicker!
   
    @IBOutlet var checkOutDateLabel: UILabel!
    
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? "" // получение данных
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAdress: email,
            checkInDate: Date(),
            checkOutDate: Date(),
            numberOfAdults: 0,
            numberOfChildren: 0,
            roomType: RoomType(
                id: 0,
                name: "",
                shortName: "",
                price: 0),
            wifi: false)
        
    }
}

