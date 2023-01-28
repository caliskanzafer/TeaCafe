//
//  DetailViewController.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 27.01.2023.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    let viewModel: DetailViewModel = DetailViewModel()
    let bag = DisposeBag()
    
    private lazy var nameLbl: UILabel = UILabel()
    private lazy var descriptionLbl: UILabel = UILabel()
    private lazy var countLbl: UILabel = UILabel()
    private lazy var decreaseButton: UIButton = UIButton()
    private lazy var increaseButton: UIButton = UIButton()
    private lazy var addButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle()
        setupDescription()
        setupDecreaseButton()
        setupIncreaseButton()
        setupCount()
        setupAddButton()
        
        setupObservers()
        
    }
    
    func set(tea: TeaModel){
        self.viewModel.set(tea: tea)
    }
    
    private func setupObservers(){
        self.viewModel.count.asObservable().map{"x\($0)"}.bind(to: countLbl.rx.text).disposed(by: bag)
    }
    
    private func setupTitle() {
        nameLbl.text = viewModel.tea?.name
        nameLbl.textAlignment = .center
        nameLbl.frame = .init(x: 100, y: 45, width: Global.shared.screenWidth - 40, height: 60)
        nameLbl.center.x = self.view.center.x
        nameLbl.font = .systemFont(ofSize: 24, weight: .bold)
        self.view.addSubview(nameLbl)
        
    }
    
    private func setupDescription() {
        descriptionLbl.text = viewModel.tea?.description
        descriptionLbl.textAlignment = .left
        descriptionLbl.numberOfLines = 0
        descriptionLbl.frame = .init(x: 20, y: 80, width: Global.shared.screenWidth - 40, height: 60)
        descriptionLbl.font = .systemFont(ofSize: 18, weight: .regular)
        descriptionLbl.textColor = .systemGray
        self.view.addSubview(descriptionLbl)
    }
    
    private func setupDecreaseButton() {
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.backgroundColor = .systemRed
        decreaseButton.frame = .init(x: 0, y: 150, width: 40, height: 40)
        decreaseButton.center.x = self.view.center.x - 40
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        self.view.addSubview(decreaseButton)
    }
    
    private func setupIncreaseButton() {
        increaseButton.setTitle("+", for: .normal)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.backgroundColor = .systemGreen
        increaseButton.frame = .init(x: 0, y: 150, width: 40, height: 40)
        increaseButton.center.x = self.view.center.x + 40
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        self.view.addSubview(increaseButton)
    }
    
    private func setupCount() {
        countLbl.textAlignment = .left
        countLbl.numberOfLines = 0
        countLbl.frame = .init(x: 20, y: 250, width: Global.shared.screenWidth - 40, height: 60)
        countLbl.textAlignment = .center
        countLbl.center.x = self.view.center.x
        countLbl.font = .systemFont(ofSize: 50, weight: .bold)
        countLbl.textColor = .systemGray
        self.view.addSubview(countLbl)
    }
    
    private func setupAddButton() {
        addButton.setTitle("Add to basket", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        addButton.frame = .init(x: 20, y: 350, width: Global.shared.screenWidth - 40, height: 40)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        self.view.addSubview(addButton)
    }
    
    
}

extension DetailViewController {
    @objc func decreaseButtonTapped() {
        viewModel.decreaseButtonTapped()
    }
    @objc func increaseButtonTapped() {
        viewModel.increaseButtonTapped()
    }
    
    @objc func addButtonTapped() {
        let _count = viewModel.getCountFromView(countLbl.text!)
        viewModel.addButtonTapped(BasketModel(tea: viewModel.tea, count: _count))
        
        let alert = UIAlertController(title: "Success", message: "Successfully Added", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Done", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
