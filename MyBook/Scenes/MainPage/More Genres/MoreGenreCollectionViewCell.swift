//
//  MoreGenreCollectionViewCell.swift
//  MyBook
//
//  Created by Yernur Adilbek on 4/6/24.
//
import Kingfisher
import UIKit

class MoreGenreCollectionViewCell: UICollectionViewCell {
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var author: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
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
        author.text = result.volumeInfo.authors[0]
    }
}


// MARK: - setting iui methods
private extension MoreGenreCollectionViewCell{
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(poster)
        addSubview(title)
        addSubview(author)
    }
    
    func setupConstraints() {
        poster.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(5)
            make.leading.equalTo(poster)
            make.trailing.equalToSuperview().offset(-5)
        }
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.leading.equalTo(poster)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
}
