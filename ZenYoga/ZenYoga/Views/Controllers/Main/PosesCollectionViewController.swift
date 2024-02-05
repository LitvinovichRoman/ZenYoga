//
//  YogaPosesCollectionViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit
import Kingfisher

class PosesCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    private let reuseIdentifier = "PosesCell"
    private var viewModel = PosesViewModel()


    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) // Отступы
        
        setupCollectionView() // Загрузка URL адресов изображений
        viewModel.loadImageURLs { [weak self] in // Обновление интерфейса в главном потоке
            DispatchQueue.main.async {
                self?.collectionView.reloadData() // Обновление данных ячейки
            }
            
        }
    }

    // MARK: - Private Functions
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "PosesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier) // Регистрация ячейки коллекции для повторного использования
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PosesCollectionViewCell
        
        // Радиус и цвет для обводки ячеек
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "cellBorderColor")?.cgColor

        let imageURL = viewModel.imageURL(at: indexPath.item)
        cell.setImage(with: imageURL) // Установка изображения в ячейку

        return cell
    }
    
    // Переход при нажатии на выбраную ячеку 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "PosesDetailViewController") as! PosesDetailViewController
        let detailViewModel = PosesDetailViewModel()
        detailViewModel.imageURL.value = viewModel.imageURL(at: indexPath.item)
        detailVC.viewModel = detailViewModel
        self.navigationController?.pushViewController(detailVC, animated: true)
    }


}
