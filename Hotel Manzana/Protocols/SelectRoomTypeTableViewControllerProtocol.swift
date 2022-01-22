//
//  SelectRoomTypeTableViewControllerProtocol.swift
//  Hotel Manzana
//
//  Created by Владимир on 20.01.2022.
//

protocol SelectRoomTypeTableViewControllerProtocol {
    func didSelect(roomType: RoomType)
}
// данный протокол реализует метод румтайп ( для того чтобы работало в class SelectRoomTypeTableViewController + delegate) также делегат в экстеншн - который работает при выборе комнаты
