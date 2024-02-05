//
//  PosesDetailViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit

class PosesDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var posesImage: UIImageView!
    @IBOutlet weak var timeInPose: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var subView: UIView!
    
    // MARK: - Properties
    var viewModel: PosesDetailViewModel!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.imageURL.bind { [weak self] url in
            self?.posesImage.load(url: url!)            // Байндинг URL-адреса изображения
        }
        viewModel.timerText.bind { [weak self] text in  // Загрузка изображения
            self?.timerLabel.text = text                // Обновление текста метки таймера
        }
        viewModel.progress.bind { [weak self] progress in
            self?.timeInPose.setProgress(progress, animated: true) // Байндинг и обновление прогресса
        }
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    }
    
    @objc func startTimer() {
        viewModel.startTimer()
    }

    @objc func stopTimer() {
        viewModel.resetTimer()
    }
    
    private func setupUI() {
        startButton.capsuleCornerRadius()
        stopButton.capsuleCornerRadius()
        timerLabel.capsuleCornerRadius()
        subView.cornerRadius()
    }
}
