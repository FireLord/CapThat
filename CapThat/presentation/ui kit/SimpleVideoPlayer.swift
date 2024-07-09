//
//  SimpleVideoPlayer.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import SwiftUI
import AVKit

struct SimpleVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}
