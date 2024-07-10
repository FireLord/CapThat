//
//  HomeViewModel.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import Foundation
import AVKit

@MainActor
class HomeViewModel: ObservableObject {
    // MARK: - Common
    @Published var isPlaying: Bool = false
    @Published var player: AVPlayer?
    @Published var isFinishedPlaying: Bool = false
    @Published var completeParagraph: String = ""

    // MARK: - Caption
    @Published var sentenceDict: [Double:String] = [:]
    @Published var currentSentence: String = ""
    @Published var isCaptionEnabled: Bool = true
    
    // MARK: - Seek bar
    @Published var progress: CGFloat = 0
    @Published var lastDraggedProgress: CGFloat = 0
    @Published var isSeeking: Bool = false
    
    init() {
        if let videoURL = Bundle.main.url(forResource: "sample_video", withExtension: "mp4") {
            self.player = AVPlayer(url: videoURL)
            self.getSpeechData()
            self.startTimer()
        } else {
            self.player = nil
        }
    }
    
    func getSpeechData() {
        guard let speechData = ResponseUtil.shared.parseJSON() else {
            return
        }
        
        speechData.results.channels
            .flatMap { $0.alternatives }
            .flatMap { $0.paragraphs.paragraphs }
            .flatMap { $0.sentences }
            .forEach { sentenceDict[$0.start] = $0.text }
        
        if let data = speechData.results.channels.first?.alternatives.first?.transcript {
            completeParagraph = data
        }
    }
    
    func startTimer() {
        player?.addPeriodicTimeObserver(forInterval: .milliseconds(100), queue: .main) { [weak self] time in
            guard let self = self else { return }
            
            Task {
                await MainActor.run {
                    guard let player = self.player, player.currentItem?.status == .readyToPlay else {
                        return
                    }
                    
                    self.updateCurrentSentence()
                    
                    if let currentPlayerItem = player.currentItem {
                        let totalDuration = currentPlayerItem.duration.seconds
                        let currentDuration = player.currentTime().seconds
                        
                        let calculatedProgress = currentDuration / totalDuration
                        
                        if !self.isSeeking {
                            self.progress = calculatedProgress
                            self.lastDraggedProgress = self.progress
                        }
                        
                        if calculatedProgress == 1 {
                            self.isFinishedPlaying = true
                            self.isPlaying = false
                        }
                    }
                }
            }
        }
    }
    
    func updateCurrentSentence() {
        guard let player = player else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let nearestSentence = sentenceDict.keys.sorted().last { $0 <= currentTime }
        if let nearestSentence = nearestSentence {
            currentSentence = sentenceDict[nearestSentence] ?? ""
        }
    }
}
