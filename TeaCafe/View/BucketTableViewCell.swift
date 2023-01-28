//
//  BucketTableViewCell.swift
//  TeaCafe
//
//  Created by Zafer Çalışkan on 28.01.2023.
//

import UIKit

class BucketTableViewCell: UITableViewCell {
    
    private var title: UILabel = {
        let label = DefaultComponents.shared.dcLabel(text: "")
        label.frame = .init(x: 20, y: 10, width: Global.shared.screenWidth - 160, height: 20)
        return label
    }()
    private var desc: UILabel = {
        let label = DefaultComponents.shared.dcLabel(text: "")
        label.frame = .init(x: 20, y: 30, width: Global.shared.screenWidth - 160, height: 20)
        return label
    }()
    
    private var price: UILabel = {
        let label = DefaultComponents.shared.dcLabel(text: "")
        label.frame = .init(x: Global.shared.screenWidth - 100, y: 20, width: 100, height: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.title)
        self.addSubview(self.desc)
        self.addSubview(self.price)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCell(_ basket: BasketModel){
        self.title.text = basket.tea.name
        self.desc.text = basket.tea.description
        self.price.text = "\(Double(basket.tea.price) * Double(basket.count)) tl"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
