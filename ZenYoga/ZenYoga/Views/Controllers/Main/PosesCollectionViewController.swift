//
//  YogaPosesCollectionViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit

class PosesCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    private let reuseIdentifier = "PosesCell"
    private var viewModel = PosesViewModel()
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        setupCollectionView()
        viewModel.loadImageURLs { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: - Private Functions
    
    private func setupNavigationBarAppearance() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size: 23)!, NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "PosesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PosesCollectionViewCell
        
        let imageURL = viewModel.imageURL(at: indexPath.item)
        cell.setImage(with: imageURL)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "PosesDetailViewController") as! PosesDetailViewController
            detailVC.imageURL = viewModel.imageURL(at: indexPath.item)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
}
