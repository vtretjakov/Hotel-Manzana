//
//  SelectRoomTypeTableViewController.swift
//  Hotel Manzana
//
//  Created by Владимир on 20.01.2022.
//

import UIKit

class SelectRoomTypeTableViewController: UITableViewController {
    var delegate: SelectRoomTypeTableViewControllerProtocol? // опциональный тип так как может и не быть
    var roomType: RoomType?
    
}

extension SelectRoomTypeTableViewController /*: UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        let roomType = RoomType.all[indexPath.row]
        cell.accessoryType = roomType == self.roomType ? .checkmark : .none // совпадает ли наш румтайп с румтайп который мы вычислили если совпадает показываем чекмарк, если нет то ничего (галочка при выделении комнаты)
        cell.textLabel?.text = roomType.name // то что слева
        cell.detailTextLabel?.text = "$ \(roomType.price)" // то что справа
        return cell
    }
    
}

extension SelectRoomTypeTableViewController/*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // развыделяем
        roomType = RoomType.all[indexPath.row] // запоминаем комнату которую выбрали
        delegate?.didSelect(roomType: roomType!)
        tableView.reloadData()
    } // при нажатии
}
