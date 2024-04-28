//
//  ViewController.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/29/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
    
    var manager = BookManager()
    var bookResults: [BookData.Item] = []
    var genre: String?
    
    let scrollView = UIScrollView()
    
    var containerView = UIView()
    
    private lazy var adventureFullView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var adventureLabel: UILabel = {
        let label = UILabel()
        label.text = "Adventure"
        label.textColor = .white
        return label
    }()
    
    private lazy var adventureArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(adventureArrowTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var adventureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "topCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        setGenre(genreToSet: "adventure")
        return collectionView
    }()
    
    private lazy var fantasyFullView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var fantasyLabel: UILabel = {
        let label = UILabel()
        label.text = "Fantasy"
        label.textColor = .white
        return label
    }()
    
    private lazy var fantasyArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fantasyArrowTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var fantasyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "topCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        setGenre(genreToSet: "fantasy")
        return collectionView
    }()
    
    private lazy var healthFullView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var healthLabel: UILabel = {
        let label = UILabel()
        label.text = "Health"
        label.textColor = .white
        return label
    }()
    
    private lazy var healthArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(healthArrowTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var healthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "topCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        setGenre(genreToSet: "health")
        return collectionView
    }()
    
    private lazy var horrorFullView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var horrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Horror"
        label.textColor = .white
        return label
    }()
    
    private lazy var horrorArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(horrorArrowTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var horrorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "topCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        setGenre(genreToSet: "horror")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor(red: 28/255, green: 23/255, blue: 47/255, alpha: 1)
        setupUI()
        
        adventureCollectionView.delegate = self
        adventureCollectionView.dataSource = self
        
        fantasyCollectionView.delegate = self
        fantasyCollectionView.dataSource = self
        
        healthCollectionView.delegate = self
        healthCollectionView.dataSource = self
        
        horrorCollectionView.delegate = self
        horrorCollectionView.dataSource = self
        
        manager.delegate = self
        switch genre {
        case "adventure":
            manager.fetchAdventureBooks(maxResults: 10)
            break
        case "fantasy":
            manager.fetchFantasyBooks(maxResults: 10)
            break
        case "horror":
            manager.fetchHorrorBooks(maxResults: 10)
            break
        case "health":
            manager.fetchHealthBooks(maxResults: 10)
            break
        default:
            break
        }
//        manager.fetchAdventureBooks(maxResults: 10)
//        manager.fetchFantasyBooks(maxResults: 10)
//        manager.fetchHealthBooks(maxResults: 10)
//        manager.fetchHorrorBooks(maxResults: 10)
    }
    
    @objc private func adventureArrowTapped() {
        navigateToGenreViewController(with: "adventure")
    }

    @objc private func fantasyArrowTapped() {
        navigateToGenreViewController(with: "fantasy")
    }
    @objc private func healthArrowTapped() {
        navigateToGenreViewController(with: "health")
    }
    @objc private func horrorArrowTapped() {
        navigateToGenreViewController(with: "horror")
    }

    private func navigateToGenreViewController(with genre: String) {
        let genreVC = GenreViewController()
        genreVC.genre = genre
        navigationController?.pushViewController(genreVC, animated: true)
    }
    
    private func setGenre(genreToSet: String) {
        genre = genreToSet
    }

}

//MARK: - Collection view data source methods
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! GenreCollectionViewCell
        cell.configure(with: bookResults[indexPath.row])
        return cell
    }
}

//MARK: - Collection view delegate methods
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.configure(with: bookResults[indexPath.row])
        present(detailVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 4.0
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}

//MARK: - Network manager delegate methods
extension ViewController: FetchBooksDelegate {

    
    func didUpdateBooks(with results: [BookData.Item]) {
        self.bookResults = results
        DispatchQueue.main.async { [self] in
            if self.adventureCollectionView.delegate != nil {
                setGenre(genreToSet: "adventure")
                self.adventureCollectionView.reloadData()
            }
            if self.fantasyCollectionView.delegate != nil{
                setGenre(genreToSet: "fantasy")
                self.fantasyCollectionView.reloadData()
            }
            if self.horrorCollectionView.delegate != nil{
                setGenre(genreToSet: "horror")
                self.horrorCollectionView.reloadData()
            }
            if self.healthCollectionView.delegate != nil{
                setGenre(genreToSet: "health")
                self.healthCollectionView.reloadData()
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


//MARK: - Setup UI
private extension ViewController {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(adventureFullView)
        adventureFullView.addSubview(adventureLabel)
        adventureFullView.addSubview(adventureArrow)
        containerView.addSubview(adventureCollectionView)
        
        containerView.addSubview(fantasyFullView)
        fantasyFullView.addSubview(fantasyLabel)
        fantasyFullView.addSubview(fantasyArrow)
        containerView.addSubview(fantasyCollectionView)
        
        containerView.addSubview(healthFullView)
        healthFullView.addSubview(healthLabel)
        healthFullView.addSubview(healthArrow)
        containerView.addSubview(healthCollectionView)
        
        containerView.addSubview(horrorFullView)
        horrorFullView.addSubview(horrorLabel)
        horrorFullView.addSubview(horrorArrow)
        containerView.addSubview(horrorCollectionView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        adventureFullView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        adventureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        adventureArrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        adventureCollectionView.snp.makeConstraints { make in
            make.top.equalTo(adventureFullView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.leading.trailing.equalToSuperview()
        }
        fantasyFullView.snp.makeConstraints { make in
            make.top.equalTo(adventureCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        fantasyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        fantasyArrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        fantasyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(fantasyFullView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.leading.trailing.equalToSuperview()
        }
        healthFullView.snp.makeConstraints { make in
            make.top.equalTo(fantasyCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        healthLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        healthArrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        healthCollectionView.snp.makeConstraints { make in
            make.top.equalTo(healthFullView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.leading.trailing.equalToSuperview()
        }
        horrorFullView.snp.makeConstraints { make in
            make.top.equalTo(healthCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        horrorLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        horrorArrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        horrorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(horrorFullView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.leading.trailing.equalToSuperview()
        }
    }
}
