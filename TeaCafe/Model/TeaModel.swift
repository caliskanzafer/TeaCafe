//
//  Tea.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 26.01.2023.
//

import Foundation

struct TeaModel {
    var name: String
    var description: String
    var price: Double
    
    init(name: String, description: String, price: Double) {
        self.name = name
        self.description = description
        self.price = price
    }
}
