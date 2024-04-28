//
//  DetailViewController.swift
//  MyBook
//
//  Created by Yernur Adilbek on 4/5/24.
//

import UIKit

class DetailViewController: UIViewController {
    var bookData: BookData.Item?
    var scrollView: UIScrollView!
    
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var author: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var addToLibraryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("WANT TO READ", for: .normal)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var previewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "book.pages.fill"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1).cgColor
        button.setTitle("SAMPLE", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        return view
    }()
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Publisher Description"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy  var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 51/255, green: 45/255, blue: 65/255, alpha: 1)
        setupUI()
    }
    
    func configure(with result: BookData.Item) {
        DispatchQueue.main.async {
            self.poster.kf.setImage(with: Global.APIs.URLs.GBA.createImageUrl(result.volumeInfo.imageLinks?.thumbnail ?? ""))
        }
        titleLabel.text = result.volumeInfo.title
        author.text = result.volumeInfo.authors[0]
        descriptionLabel.text = result.volumeInfo.description
    }
}


// MARK: - setting iui methods
private extension DetailViewController {
    func setupUI() {
        setupScrollView()
        setupViews()
        setupConstraints()
    }
    
    func setupScrollView() {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            let contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            
            scrollView.contentInsetAdjustmentBehavior = .never
            self.scrollView = scrollView
    }
    
    func setupViews() {
        scrollView.addSubview(poster)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(author)
        scrollView.addSubview(getButton)
        scrollView.addSubview(addToLibraryButton)
        scrollView.addSubview(previewButton)
        scrollView.addSubview(dividerView)
        scrollView.addSubview(descriptionTitle)
        scrollView.addSubview(descriptionLabel)
    }
    

    private func setupConstraints() {
        let contentView = scrollView.subviews.first!

        poster.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        author.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        getButton.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        addToLibraryButton.snp.makeConstraints { make in
            make.top.equalTo(getButton.snp.bottom).offset(10)
            make.leading.equalTo(getButton)
            make.trailing.equalTo(previewButton.snp.leading).offset(-10)
            make.height.equalTo(getButton)
        }
        previewButton.snp.makeConstraints { make in
            make.top.equalTo(getButton.snp.bottom).offset(10)
            make.trailing.equalTo(getButton)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(getButton)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(addToLibraryButton.snp.bottom).offset(20)
            make.width.equalTo(getButton)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        descriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.leading.equalTo(dividerView)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(10)
            make.leading.trailing.equalTo(dividerView)
        }
        
        let totalHeight = descriptionLabel.frame.maxY + 20
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel).offset(20) // Bottom spacing
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
    }

}

