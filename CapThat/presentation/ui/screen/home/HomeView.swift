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
                        
                        Button {
                            viewModel.isCaptionEnabled.toggle()
                        } label: {
                            ZStack {
                                BlurView(style: .systemThinMaterialDark)
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: viewModel.isCaptionEnabled
                                      ? "captions.bubble.fill"
                                      : "captions.bubble")
                                .scaleEffect(1.2)
                                .foregroundColor(.white)
                            }
                        }
                        
                    }
                    .padding(.top, safeArea.top)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    ZStack {
                        BlurView(style: .systemThinMaterialDark)
                            .opacity(0.85)
                        
                        VStack {
                            if viewModel.isCaptionEnabled {
                                Text(viewModel.currentSentence)
                                    .font(.title3)
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            Spacer()
                            
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
                    .frame(height: viewModel.isCaptionEnabled
                           ? size.height / 4
                           : size.height / 7)
                    
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    HomeView()
}
