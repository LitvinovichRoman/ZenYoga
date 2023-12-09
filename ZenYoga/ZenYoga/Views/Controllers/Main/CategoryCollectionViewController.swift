//
//  CategoryCollectionViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit
import FirebaseStorage

class CategoryCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let reuseIdentifier = "CategoriesCell"
    private var categoryImages: [UIImage] = []
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupCollectionView()
        retrieveCategoryImages()
    }
    
    // MARK: - UI Configuration
    
    private func configureNavigationBar() {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "ChalkboardSE-Regular", size: 23) ?? UIFont.systemFont(ofSize: 23),
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupCollectionView() {
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Data Fetching
    
    private func retrieveCategoryImages() {
        FirebaseStorageService.shared.retrieveCategoryImages { [weak self] (images, error) in
            guard let self = self else { return }
            if let error = error {
                // Handle error
            } else if let images = images {
                self.categoryImages = images
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        let image = categoryImages[indexPath.item]
        cell.setImage(image)
        return cell
    }
}
