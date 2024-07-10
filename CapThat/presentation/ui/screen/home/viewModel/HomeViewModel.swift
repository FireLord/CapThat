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
    @Published var isPlaying: Bool = false
    @Published var player: AVPlayer?
    @Published var sentenceDict: [Double:String] = [:]
    @Published var currentSentence: String = ""
    @Published var isCaptionEnabled: Bool = true
    
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
