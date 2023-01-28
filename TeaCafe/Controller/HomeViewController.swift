//
//  HomeViewController.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 26.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel = HomeViewModel()
    let bag = DisposeBag()
    
    private lazy var _tableView: UITableView = UITableView()
    private lazy var _countValue : UILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        setupBucket()
        
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupObservers(){
        self.viewModel.shoppingCard.asObservable().map{"Bucket: \($0.count)"}.bind(to: _countValue.rx.text).disposed(by: bag)
    }
    
    private func setupTableView(){
        self._tableView = DefaultComponents.shared.dcTableView(with: MainTableViewCell.self, cell: "cell")
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.separatorStyle = .singleLine
        self._tableView.frame = .init(x: 0, y: 100, width: Global.shared.screenWidth, height: Global.shared.screenHeight - 100)
        self.view.addSubview(self._tableView)
    }
    
    private func setupBucket(){
        _countValue.font = .systemFont(ofSize: 20, weight: .bold)
        _countValue.frame = .init(x: Global.shared.screenWidth - 120, y: 60, width: 100, height: 30)
        _countValue.isUserInteractionEnabled = true
        _countValue.backgroundColor = .blue
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bucketTapped))
        _countValue.addGestureRecognizer(tapGesture)
        self.view.addSubview(_countValue)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
        let tea = viewModel.menu[indexPath.row]
        cell.initCell(tea)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.set(tea: viewModel.menu[indexPath.row])
        detailVC.viewModel.basket.asObservable().subscribe(onNext: { (array) in
            array.forEach { (item) in
                self.viewModel.addToShoppingCard(item)
            }
        }).disposed(by: bag)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController {
    @objc func bucketTapped(){
        let bucketVC = BucketViewController()
        bucketVC.set(list: self.viewModel.shoppingCard.value)
        self.navigationController?.pushViewController(bucketVC, animated: true)
    }
}
