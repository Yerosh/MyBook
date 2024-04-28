//
//  GenreCollectionViewCell.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/31/24.
//

import UIKit
import Kingfisher

class GenreCollectionViewCell: UICollectionViewCell {
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
}


// MARK: - setting iui methods
private extension GenreCollectionViewCell {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(poster)
        addSubview(title)
    }
    
    func setupConstraints() {
        poster.snp.makeConstraints { make in
//            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(5)
            make.leading.trailing.equalTo(poster)
        }
    }
}
