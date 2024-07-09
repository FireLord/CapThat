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
    
    init() {
        if let videoURL = Bundle.main.url(forResource: "sample_video", withExtension: "mp4") {
            self.player = AVPlayer(url: videoURL)
        } else {
            self.player = nil
        }
    }
}
