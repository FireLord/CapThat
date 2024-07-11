//
//  SeekBar.swift
//  CapThat
//
//  Created by Aman Kumar on 10/07/24.
//

import SwiftUI
import AVKit

struct SeekBar: View {
    @Binding var player: AVPlayer?
    @GestureState var isDragging: Bool = false
    @Binding var progress: CGFloat
    @Binding var lastDraggedProgress: CGFloat
    @Binding var isSeeking: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.gray)
                
                Rectangle()
                    .fill(.teal.opacity(0.5))
                    .frame(width: max(availableWidth * progress, 0))
            }
            .frame(height: 3)
            .overlay(alignment: .leading) {
                Circle()
                    .fill(.teal)
                    .frame(width: 15, height: 15)
                    .contentShape(Rectangle())
                    .offset(x: availableWidth * progress)
                    .gesture(
                        DragGesture()
                            .updating($isDragging, body: { _, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                let translationX: CGFloat = value.location.x - 7.5 // Center the handle
                                let calculatedProgress = (translationX / availableWidth)
                                
                                progress = max(min(calculatedProgress, 1), 0)
                                isSeeking = true
                            })
                            .onEnded({ value in
                                lastDraggedProgress = progress
                                
                                if let currentPlayerItem = player?.currentItem {
                                    let totalDuration = currentPlayerItem.duration.seconds
                                    
                                    player?.seek(to: .init(seconds: totalDuration * progress,
                                                                 preferredTimescale: 1))
                                    
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                                        isSeeking = false
//                                    }
                                    isSeeking = false
                                }
                            })
                    )
                    .offset(x: progress * availableWidth > 15 ? -15 : 0)
                    .frame(width: 15, height: 15)
            }
        }
        .frame(height: 15) // Adjust height to fit the SeekBar and the handle
    }
}

#Preview {
    SeekBar(player: .constant(nil), progress: .constant(0), lastDraggedProgress: .constant(0), isSeeking: .constant(false))
}
