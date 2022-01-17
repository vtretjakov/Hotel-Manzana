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

