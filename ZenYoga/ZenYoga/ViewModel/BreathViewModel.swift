//
//  BreathViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 07/02/2024.
//

import Foundation
import UIKit

class BreathViewModel {
    // MARK: - Properties
    var timerText: Bindable<String> = Bindable("03:00")
    var progress: Bindable<Float> = Bindable(0.0)
    var breathStatus: Bindable<String> = Bindable("Get ready")
    var breathStatusColor: Bindable<UIColor> = Bindable(.white)
    private var breathCounter: Int = 0
    private var timer: Timer?
    private var totalTime: Double = 180.0
    private var timeLeft: Double = 180.0 {
        didSet {
            updateTimerLabel()
            updateProgressView()
        }
    }
    
    // MARK: - Timer methods
    func startTimer() {
        resetTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeLeft -= 1
            self.breathCounter += 1
            
            if self.breathCounter >= 6 {
                self.breathStatus.value = self.breathStatus.value == "Inhale" ? "Exhale" : "Inhale"
                self.breathStatusColor.value = self.breathStatus.value == "Inhale" ? #colorLiteral(red: 0.4018470645, green: 0.552862525, blue: 0.3434202969, alpha: 0.8214150773) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                self.breathCounter = 0
            }
            
            if self.timeLeft <= 0 {
                self.timer?.invalidate()
                self.resetTimer()
                NotificationCenter.default.post(name: NSNotification.Name("timerFinished"), object: nil)
            }
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timeLeft = totalTime
        breathStatus.value = "Get ready"
        breathStatusColor.value = .white
        breathCounter = 0
    }
    
    private func updateTimerLabel() {
        let minutes = String(format: "%02i", Int(timeLeft) / 60)
        let seconds = String(format: "%02i", Int(timeLeft) % 60)
        timerText.value = "\(minutes):\(seconds)"
    }
    
    private func updateProgressView() {
        let progressValue = Float(totalTime - timeLeft) / Float(totalTime)
        progress.value = progressValue
    }
}
