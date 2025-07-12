//
//  MetronomeManager.swift
//  Running
//
//  Created by 류창휘 on 7/12/25.
//

import SwiftUI
import AVFoundation
import AudioToolbox

class MetronomeManager: ObservableObject {
    @Published var isPlaying = false
    @Published var spm: Int = 180 {
        didSet {
            if isPlaying {
                restartTimer()
            }
        }
    }
    private var timer: Timer?
    private var player: AVAudioPlayer?
    
    init() {
    }
    
    private func restartTimer() {
        stopTimer()
        startTimer()
    }
    private func startTimer() {
        let interval = 60.0 / Double(spm)
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.playBeep()
        }
    }
    private func playBeep() {
        AudioServicesPlaySystemSound(1057)
    }
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    func start() {
        stop() // 중복 방지
        isPlaying = true
        
        let interval = 60.0 / Double(spm)
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            AudioServicesPlaySystemSound(1057) // 짧은 비프음
        }
    }
    
    func stop() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
    }
}
