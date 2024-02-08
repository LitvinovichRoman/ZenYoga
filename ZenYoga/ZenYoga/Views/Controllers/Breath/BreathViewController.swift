//
//  BreathViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 28/01/2024.
//

import UIKit
import Lottie

class BreathViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var breathingStatusLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    let lottieAnimationView = LottieAnimationView()
    var viewModel = BreathViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimation()
        bindViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(timerFinished), name: NSNotification.Name("timerFinished"), object: nil)
    }
    
    // MARK: - ViewModel binding
    private func bindViewModel() {
        viewModel.timerText.bind { [weak self] text in
            print("Binding timerText: \(text)")
            self?.timerLabel.text = text
        }
        viewModel.progress.bind { [weak self] progress in
            self?.progressView.setProgress(progress, animated: true)
        }
        viewModel.breathStatus.bind { [weak self] status in
            self?.breathingStatusLabel.text = status
        }
        viewModel.breathStatusColor.bind { [weak self] color in
            self?.breathingStatusLabel.backgroundColor = color
        }
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Event processing
    @objc func startButtonTapped() {
        lottieAnimationView.play()
        viewModel.startTimer()
    }
    
    @objc func stopButtonTapped() {
        lottieAnimationView.pause()
        viewModel.resetTimer()
    }
    
    @objc func timerFinished() {
        lottieAnimationView.pause()
    }
    
    // MARK: - SetupUI and Lottie animation
    private func setupUI() {
        startButton.capsuleCornerRadius()
        stopButton.capsuleCornerRadius()
        timerLabel.capsuleCornerRadius()
        breathingStatusLabel.capsuleCornerRadius()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    private func setupAnimation() {
        lottieAnimationView.animation = .named("breathHeart")
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.animationSpeed = 0.2
        lottieAnimationView.backgroundBehavior = .pauseAndRestore
        
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.addSubview(lottieAnimationView)
        
        NSLayoutConstraint.activate([
            lottieAnimationView.topAnchor.constraint(equalTo: animationView.topAnchor),
            lottieAnimationView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor),
            lottieAnimationView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor),
            lottieAnimationView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor)
        ])
    }
    
}

