//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Владимир on 16.01.2022.
//

import UIKit

// UserDefaults

struct KeysDefaults {
    static let keyNew = "new"
}

class AddRegistrationTableViewController: UITableViewController {
    
    // HideKeyboard

        @objc
        private func hideKeyboard() {
            self.view.endEditing(true)
        }
    
    // UserDefaults
    
    let defaults = UserDefaults.standard
    
    // MARK: - Outlets
    
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    
    @IBOutlet var checkInDatePicker: UIDatePicker!
   
    @IBOutlet var checkOutDateLabel: UILabel!
    
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    
    @IBOutlet var numberOfChildrenLabel: UILabel!
    
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    
    // MARK: - Properties
    
    let checkInDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateLabelIndexPath = IndexPath(row: 2, section: 1) // AddRegistrationTableViewController
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
    
    var roomType: RoomType?
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        
        //  UserDefaults
        
        firstNameTextField?.text = defaults.string(forKey: KeysDefaults.keyNew)
        
        // HideKeyboard
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SelectRoomType" else {return}
        let destination = segue.destination as! SelectRoomTypeTableViewController
        destination.delegate = self
        destination.roomType = roomType
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
    
    func updateNumberOfGuests() {
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        numberOfAdultsLabel.text = "\(numberOfAdults)"
        numberOfChildrenLabel.text = "\(numberOfChildren)"
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } /* если есть то ставим текст*/ else {
        roomTypeLabel.text = "Not Set"
    }
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
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let wifi = wifiSwitch.isOn
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAdress: email,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdults: numberOfAdults,
            numberOfChildren: numberOfChildren,
            roomType: roomType,
            wifi: wifi
        )
        print(#line, #function, registration)
    }

    // UserDefaults
    
    @IBAction func saveButton(_ sender: Any) {
        let first = firstNameTextField.text!
        if !first.isEmpty && lastNameTextField.text != firstNameTextField.text && emailTextField.text != firstNameTextField.text {
            defaults.set(first, forKey: KeysDefaults.keyNew)
        }
    }
    
@IBAction func stepperValueChanged(_ sender: UIStepper) {
    updateNumberOfGuests()
} // для того чтобы происходило автоматом, вызывается когда нажимаетмся степпер
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
        /* вместо релоаддата можно:
        tableView.beginUpdates()
        tableView.endUpdates() */
        tableView.reloadData()
    }
}
// после нажатия на дэйт появляется дэйт пикер,если нажимаем на один а второй при этом показан второй должен исчезнуть

// destination.delegate = self    Cannot assign value of type 'AddRegistrationTableViewController' to type 'SelectRoomTypeTableViewControllerProtocol?' - для исправления ошибки добавим:

// MARK: - SelectRoomTypeTableViewControllerProtocol

extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerProtocol {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    
}
