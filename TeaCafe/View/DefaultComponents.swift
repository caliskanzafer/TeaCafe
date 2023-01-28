//
//  DefaultComponents.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 26.01.2023.
//

import UIKit

final class DefaultComponents {
    static let shared = DefaultComponents()
    
    func dcTableView(with registeredClass: AnyClass?, cell: String) -> UITableView {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        if registeredClass != nil {
            tableView.register(registeredClass, forCellReuseIdentifier: "\(cell)")
        }
        return tableView
    }
    
    func dcLabel(text: String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = .black
        return label
    }
}
