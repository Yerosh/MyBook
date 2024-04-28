//
//  StoreTableViewCell.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/30/24.
//

import UIKit
import Kingfisher

class StoreTableViewCell: UITableViewCell {
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var overview: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: BookData.Item) {
        DispatchQueue.main.async {
            self.poster.kf.setImage(with: Global.APIs.URLs.GBA.createImageUrl(result.volumeInfo.imageLinks?.thumbnail ?? ""))
        }
        title.text = result.volumeInfo.title
        overview.text = result.volumeInfo.description
    }
}


//MARK: - Setup UI
private extension StoreTableViewCell {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(poster)
        addSubview(title)
        addSubview(overview)
    }
    
    func setupConstraints() {
        poster.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).offset(5)
            make.top.trailing.equalToSuperview()
        }
        overview.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).offset(10)
            make.bottom.trailing.equalToSuperview()
            make.top.equalTo(title.snp.bottom)
        }
    }
}
