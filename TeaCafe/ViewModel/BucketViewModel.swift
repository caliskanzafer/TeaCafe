//
//  BucketViewModel.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 28.01.2023.
//

import Foundation
import RxCocoa

class BucketViewModel {
    var basketList = BehaviorRelay<[BasketModel]>(value: [BasketModel]())
    
    func set(list: [BasketModel]) {
        basketList.accept(list)
    }
    
    func removeFromBasket(_ indexPath: IndexPath) {
        var tempBasketList = basketList.value
        tempBasketList.remove(at: indexPath.row)
        basketList.accept(tempBasketList)
    }
}
