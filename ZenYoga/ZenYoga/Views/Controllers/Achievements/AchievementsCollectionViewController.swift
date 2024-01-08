//
//  AchievementsCollectionViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit

class AchievementsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    private let reuseIdentifier = "AchievementsCell"
    private var viewModel = AchievementsViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        setupCollectionView()
        viewModel.loadImages { [weak self] in
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
        collectionView.register(UINib(nibName: "AchievementsCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AchievementsCell
        
        let image = viewModel.image(at: indexPath.item)
        cell.setImage(image)
        
        return cell
    }

}
