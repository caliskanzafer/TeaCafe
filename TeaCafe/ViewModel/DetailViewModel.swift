//
//  DetailViewModel.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 27.01.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    
    var tea: TeaModel!
    var count = BehaviorRelay<Int>(value: 0)
    var basket = BehaviorRelay<[BasketModel]>(value: [BasketModel]())
    
    func set(tea: TeaModel) {
        self.tea = tea
    }
    
    private func addItem() {
        count.accept(count.value + 1)
    }
    
    private func removeItem() {
        if count.value > 0 {
            count.accept(count.value - 1)
        }
    }
    
    private func addBasket(_ basketItem: BasketModel) {
        var tempBasket = basket.value
        tempBasket.append(basketItem)
        basket.accept(tempBasket)
    }
    
    func getCountFromView(_ text: String) -> Int{
        let index = text.index(text.startIndex, offsetBy: 1)
        let tempText = String(text[index...])
        return Int(tempText)!
        
    }
    
    func decreaseButtonTapped() {
        removeItem()
    }
    func increaseButtonTapped() {
        addItem()
    }
    
    func addButtonTapped(_ basketItem: BasketModel) {
        addBasket(basketItem)
    }
}
