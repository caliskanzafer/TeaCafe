//
//  HomeViewModel.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 26.01.2023.
//

import Foundation
import RxSwift
import RxCocoa


final class HomeViewModel {
    let menu = MenuModel().getAll()
    
    var shoppingCard: BehaviorRelay<[BasketModel]> = .init(value: [BasketModel]())
    
    func addToShoppingCard(_ tea: BasketModel){
        var tempCard = shoppingCard.value
        tempCard.append(tea)
        shoppingCard.accept(tempCard)
    }
}
