//
//  Basket.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 28.01.2023.
//

import Foundation

struct BasketModel {
    var tea: TeaModel
    var count: Int
    
    init(tea: TeaModel, count: Int) {
        self.tea = tea
        self.count = count
    }
}
