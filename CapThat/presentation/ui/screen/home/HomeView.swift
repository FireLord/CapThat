//
//  ContentView.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geometryReader in
            let size = geometryReader.size
            let safeArea = geometryReader.safeAreaInsets
            
            ZStack {
                SimpleVideoPlayer(player: viewModel.player!)
                
                VStack {
                    HStack {
                        ZStack {
                            BlurView(style: .systemThinMaterialDark)
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "arrow.left")
                                .scaleEffect(1.2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            BlurView(style: .systemThinMaterialDark)
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "captions.bubble.fill")
                                .scaleEffect(1.2)
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.top, safeArea.top)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    ZStack {
                        BlurView(style: .systemThinMaterialDark)
                            .frame(height: size.height / 6)
                            .opacity(0.85)
                        
                        PlayBackControl(isPlaying: $viewModel.isPlaying) {
                            if viewModel.isPlaying {
                                viewModel.player?.pause()
                            } else {
                                viewModel.player?.play()
                            }
                        }
                        .padding(.bottom, safeArea.bottom)
                        .padding(.horizontal)
                    }
                        
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    HomeView()
}
