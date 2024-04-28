//
//  GenreViewController.swift
//  MyBook
//
//  Created by Yernur Adilbek on 4/6/24.
//

import UIKit

class GenreViewController: UIViewController {
    var manager = BookManager()
    var bookResults: [BookData.Item] = []

    var genre: String?
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoreGenreCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: 28/255, green: 23/255, blue: 47/255, alpha: 1)
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    
        manager.delegate = self
        
        switch genre {
        case "adventure":
            title = "ADVENTURE"
            manager.fetchAdventureBooks(maxResults: 20)
            break
        case "fantasy":
            title = "FANTASY"
            manager.fetchFantasyBooks(maxResults: 20)
            break
        case "horror":
            title = "HORROR"
            manager.fetchHorrorBooks(maxResults: 20)
            break
        case "health":
            title = "HEALTH"
            manager.fetchHealthBooks(maxResults: 20)
            break
        default:
            break
        }
    }
}

extension GenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoreGenreCollectionViewCell
        cell.configure(with: bookResults[indexPath.row])
        cell.backgroundColor = UIColor(red: 51/255, green: 45/255, blue: 65/255, alpha: 1)
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension GenreViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.configure(with: bookResults[indexPath.row])
        present(detailVC, animated: true)
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: view.window!.windowScene!.screen.bounds.width * 0.4 , height: view.window!.windowScene!.screen.bounds.height * 0.25)
        CGSize(width: 190, height: 210)
    }
}

//MARK: - Network manager delegate methods
extension GenreViewController: FetchBooksDelegate {
    func didUpdateBooks(with results: [BookData.Item]) {
        self.bookResults = results
        DispatchQueue.main.async { [self] in
            if self.myCollectionView.delegate != nil {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


// MARK: - setting iui methods
private extension GenreViewController {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(myCollectionView)
    }
    
    func setupConstraints() {
        myCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
