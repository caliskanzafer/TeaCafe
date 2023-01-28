//
//  BucketViewController.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 28.01.2023.
//

import UIKit
import RxSwift

class BucketViewController: UIViewController {
    
    private lazy var tableView: UITableView = UITableView()
    let viewModel = BucketViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupObservable()
    }
    
    func set(list: [BasketModel]){
        viewModel.set(list: list)
    }
    
    private func setupObservable() {
        self.viewModel.basketList.asObservable().subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: bag)
    }
    
    private func setupTableView() {
        tableView = DefaultComponents.shared.dcTableView(with: BucketTableViewCell.self, cell: "bucketCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = .init(x: 0, y: 80, width: Global.shared.screenWidth - 40, height: Global.shared.screenHeight - 80)
        self.view.addSubview(tableView)
    }
}

extension BucketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketTableViewCell
        
        let tea = viewModel.basketList.value[indexPath.row]
        cell.initCell(tea)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension BucketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, handler) in
            self?.viewModel.removeFromBasket(indexPath)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
