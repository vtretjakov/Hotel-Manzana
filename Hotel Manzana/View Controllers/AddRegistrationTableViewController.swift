//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Владимир on 16.01.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    
    @IBOutlet var checkInDatePicker: UIDatePicker!
   
    @IBOutlet var checkOutDateLabel: UILabel!
    
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    // MARK: - Properties
    
    let checkInDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelIndexPath = IndexPath(row: 2, section: 1) // AddRegistrationTableViewController
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
    didSet {
        checkInDatePicker.isHidden = !isCheckInDatePickerShown // обратное значение
    }
}
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    // чтобы изначально были спрятанны в сторибоард ставим хидден
    
    
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        updateDateViews()
    }
    
    // MARK: - UI Methods
    
    func updateDateViews() /* будет устанавливать значения лэйблов в зависимости от значения пикеров */ {
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        // добавили 24 часа и это минимальное значение (сек мин час)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
    }
    
    // MARK: - Action
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? "" // получение данных
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAdress: email,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
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

extension AddRegistrationTableViewController /* UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case checkInDatePickerIndexPath:
            return isCheckInDatePickerShown ? UITableView.automaticDimension : 0
        case checkOutDatePickerIndexPath:
            return isCheckOutDatePickerShown ? UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
            
        }
    }
}

extension AddRegistrationTableViewController /*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case checkInDateLabelIndexPath:
            isCheckInDatePickerShown.toggle() // меняет положение
             isCheckOutDatePickerShown = false
        case checkOutDateLabelIndexPath:
            isCheckOutDatePickerShown.toggle()
            isCheckInDatePickerShown = false
        default:
            return
        }
    }
}
// после нажатия на дэйт появляется дэйт пикер
