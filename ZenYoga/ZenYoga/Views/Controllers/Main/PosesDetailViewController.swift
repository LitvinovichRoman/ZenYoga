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
    var imageURL: URL?
    var timer: Timer?
    var timeLeft: Int = 40
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let imageURL = imageURL { posesImage.load(url: imageURL) }
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)

    }
    

    @objc func startTimer() {
        timer?.invalidate()
        timeLeft = 40 // 1 minute
        timeInPose.setProgress(0, animated: false)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timeLeft -= 1
            let progress = Float(40 - self.timeLeft) / 40.0
            self.timeInPose.setProgress(progress, animated: true)
            self.timerLabel.text = "\(self.timeLeft / 40):\(self.timeLeft % 40)"
            if self.timeLeft <= 0 {
                timer.invalidate()
            }
        }
    }

    @objc func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeLeft = 40
        timeInPose.setProgress(0, animated: false)
        timerLabel.text = "00:40"
    }
    
    
    private func setupUI() {
        startButton.capsuleCornerRadius()
        stopButton.capsuleCornerRadius()
        subView.cornerRadius()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    
}
