//
//  PosesDetailViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import UIKit
import Kingfisher

class PosesDetailViewModel {
    var imageURL: Bindable<URL?> = Bindable(nil)
    var timerText: Bindable<String> = Bindable("00:40")
    var progress: Bindable<Float> = Bindable(0.0)
    
    private var timer: Timer?
    private var timeLeft: Int = 40
    
    func startTimer() {
        resetTimer()   // Сброс таймера перед стартом, для гарантии чистого старта
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeLeft -= 1 // Уменьшение времени на  асекуду
            self.progress.value = Float(40 - self.timeLeft) / 40.0 //Вычисление прогресса
            self.updateTimerLabel() // Обновление метки таймера
            if self.timeLeft <= 0 { self.resetTimer() }  // Сброс таймера по истечению времени
        }
    }
    
    func resetTimer() {
        timer?.invalidate() // Остановка таймера
        timer = nil         // Сброс таймера
        timeLeft = 40       // Сброс оставшегося времени
        progress.value = 0  // Сброс прогресса
        updateTimerLabel()  // Обновление метки таймера
    }
    
    private func updateTimerLabel() {
        let minutes = String(format: "%02i", timeLeft / 60) // Вычисление минут
        let seconds = String(format: "%02i", timeLeft % 60) // Вычисление секунд
        timerText.value = "\(minutes):\(seconds)"           // Обновление текста таймера
    }
}


extension UIImageView {
    func load(url: URL) { self.kf.setImage(with: url) } // Асинхронная загрузка изображений через KingFisher
}
