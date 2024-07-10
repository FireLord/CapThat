//
//  PlayBackControl.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import SwiftUI

struct PlayBackControl: View {
    @Binding var isPlaying: Bool
    @Binding var isFinishedPlaying: Bool
    let onPlayClick: () -> Void
    
    var body: some View {
        HStack(spacing: 40) {
            Button {
                
            } label: {
                HStack(spacing: -10) {
                    Image(systemName: "arrowtriangle.left.fill")
                    Image(systemName: "arrowtriangle.left.fill")
                }
                .scaleEffect(2)
                .shadow(radius: 10)
                .foregroundColor(.white)
            }
            .disabled(true)
            
            
            Button {
                withAnimation {
                    isPlaying.toggle()
                }
                onPlayClick()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 80)
                        .shadow(radius: 10)
                    
                    Image(systemName: isFinishedPlaying ? "arrow.clockwise" : (isPlaying ? "arrowtriangle.right.fill" : "pause.fill"))
                        .scaleEffect(3)
                        .foregroundColor(.black)
                }
                .foregroundColor(.white)
            }
            
            
            Button {
                
            } label: {
                HStack(spacing: -10) {
                    Image(systemName: "arrowtriangle.right.fill")
                    Image(systemName: "arrowtriangle.right.fill")
                }
                .scaleEffect(2)
                .shadow(radius: 10)
                .foregroundColor(.white)
            }
            .disabled(true)
        }
    }
}

#Preview {
    PlayBackControl(isPlaying: .constant(true), isFinishedPlaying: .constant(false), onPlayClick: {})
}
