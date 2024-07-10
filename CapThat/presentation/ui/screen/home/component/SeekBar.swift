//
//  SeekBar.swift
//  CapThat
//
//  Created by Aman Kumar on 10/07/24.
//

import SwiftUI
import AVKit

struct SeekBar: View {
    let size: CGSize
    @Binding var player: AVPlayer?
    @GestureState var isDragging: Bool = false
    @Binding var progress: CGFloat
    @Binding var lastDraggedProgress: CGFloat
    @Binding var isSeeking: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.gray)
            
            Rectangle()
                .fill(.teal.opacity(0.5))
                .frame(width: max(size.width * progress - 40, 0))
        }
        .frame(height: 3)
        .overlay(alignment: .leading) {
            Circle()
                .fill(.teal)
                .frame(width: 15, height: 15)
                .contentShape(Rectangle())
                .offset(x: size.width * progress)
                .gesture(
                    DragGesture()
                        .updating($isDragging, body: { _, out, _ in
                            out = true
                        })
                        .onChanged({ value in
                            let translationX: CGFloat = value.translation.width
                            let calculatedProgress = (translationX / size.width) + lastDraggedProgress
                            
                            progress = max(min(calculatedProgress, 1), 0)
                            isSeeking = true
                        })
                        .onEnded({ value in
                            lastDraggedProgress = progress
                            
                            if let currentPlayerItem = player?.currentItem {
                                let totalDuration = currentPlayerItem.duration.seconds
                                
                                player?.seek(to: .init(seconds: totalDuration * progress,
                                                                 preferredTimescale: 1))
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isSeeking = false
                                }
                            }
                        })
                )
                .offset(x: progress * size.width > 40 ? -40 : 0)
                .frame(width: 15, height: 15)
        }
    }
}

#Preview {
    SeekBar(size: CGSize(width: 100, height: 100), player: .constant(nil), progress: .constant(0), lastDraggedProgress: .constant(0), isSeeking: .constant(false))
}
