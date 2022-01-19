//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Владимир on 16.01.2022.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAdress: String
    
    var checkInDate: Date // дата заезда
    var checkOutDate: Date // дата выезда
    
    var numberOfAdults: Int // количество гостей
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}


