//
//  BreathViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 28/01/2024.
//

import UIKit
import Lottie

class BreathViewController: UIViewController {
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var breathingStatusLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    let lottieAnimationView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimation()
    }
    
    var timer: Timer?
    var totalTime = 180.0
    var timeLeft: Double = 180.0 {
        didSet {
            updateTimerLabel()
            updateProgressView()
        }
    }
    
    var breathStatus = false { didSet { updateBreathingStatus()} }
    
    @objc func startButtonTapped() {
        lottieAnimationView.play()
        startTimer()
        breathingStatusLabel.text = "Get ready"
    }
    
    @objc func stopButtonTapped() { stopTimer() }

    private func updateBreathingStatus() {
        breathingStatusLabel.text = breathStatus ? "Inhale" : "Exhale"
        breathingStatusLabel.backgroundColor = breathStatus ? #colorLiteral(red: 0.4018470645, green: 0.552862525, blue: 0.3434202969, alpha: 0.8214150773) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    
    private func stopTimer() {
        lottieAnimationView.play()
        timer?.invalidate()
        lottieAnimationView.animation = .named("breathHeart")
        timeLeft = totalTime
        updateTimerLabel()
        progressView.progress = 0.0
        breathingStatusLabel.text = nil
        breathingStatusLabel.backgroundColor = nil
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timeLeft -= 1
            
            if Int(self.timeLeft) % 6 == 0 {
                self.breathStatus.toggle()
            }
            
            if self.timeLeft <= 0 {
                timer.invalidate()
                self.lottieAnimationView.pause()
                self.startButton.setTitle("Start", for: .normal)
                self.stopTimer()
            }
        }
    }
    
    private func updateTimerLabel() {
        let minutes = String(format: "%02i", Int(timeLeft) / 60)
        let seconds = String(format: "%02i", Int(timeLeft) % 60)
        timerLabel.text = "\(minutes):\(seconds)"
    }
    private func updateProgressView() {
        let progress = Float(totalTime - timeLeft) / Float(totalTime)
        progressView.progress = progress
    }
    
   
    
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

