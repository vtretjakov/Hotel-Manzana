//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Владимир on 16.01.2022.
//

// import Foundation нужен если price: Decimal

struct RoomType {
    var id: Int
    var name: String
    var shortName: String // короткое название
    var price: Int
}

extension RoomType: Equatable {
    // мы хотим чтобы сравнивались только идентификаторы:
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
} // нужно сказать что наш тип удавлетворяет данному протоколу (необходимо для использования в сравнении)

extension RoomType {
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
        ]
    }
} // вычеслимое свойство которое возвращает все типы комнат
