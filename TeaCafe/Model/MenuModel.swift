//
//  MenuModel.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 26.01.2023.
//

import Foundation

struct MenuModel {
    var name:String = ""
    var teaList: [TeaModel] = [TeaModel]()
    
    
    init(name: String, teaList: [TeaModel]) {
        self.name = name
        self.teaList = teaList
    }
    
    init() {}
    
    func getAll() -> [TeaModel] {
        var teaList = [TeaModel]()
        teaList.append(.init(name: "Turkish Tea", description: "Classic Turkish Tea", price: 3))
        teaList.append(.init(name: "China Tea", description: "Smooth taste with sugar", price: 20))
        teaList.append(.init(name: "French Tea", description: "Classic French Tea", price: 1.2))
        teaList.append(.init(name: "English Tea", description: "Tea with milk", price: 5))
        teaList.append(.init(name: "Acai Tea", description: "Igghy", price: 14.5))
        teaList.append(.init(name: "Black Tea", description: "Woody taste", price: 3.3))
        teaList.append(.init(name: "ChaiTeaLatte", description: "idk", price: 45))
        return teaList
    }
}
