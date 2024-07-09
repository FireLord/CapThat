//
//  PlayBackControl.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import SwiftUI

struct PlayBackControl: View {
    @Binding var isPlaying: Bool
    let onPlayClick: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .frame(width: 80, height: 60)
                    
                    HStack(spacing: -10) {
                        Image(systemName: "arrowtriangle.left.fill")
                        Image(systemName: "arrowtriangle.left.fill")
                    }
                    .scaleEffect(2)
                }
                .foregroundColor(.teal)
            }
            .disabled(true)
            
            
            Button {
                isPlaying.toggle()
                onPlayClick()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 120, height: 60)
                    
                    Image(systemName: isPlaying ? "arrowtriangle.right.fill" : "pause.fill")
                        .scaleEffect(3)
                        .foregroundColor(.black)
                }
                .foregroundColor(.teal)
            }
            
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .frame(width: 80, height: 60)
                    
                    HStack(spacing: -10) {
                        Image(systemName: "arrowtriangle.right.fill")
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                    .scaleEffect(2)
                }
                .foregroundColor(.teal)
            }
            .disabled(true)
        }
    }
}

#Preview {
    PlayBackControl(isPlaying: .constant(true), onPlayClick: {})
}
