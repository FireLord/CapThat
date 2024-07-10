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
                Color.teal.opacity(0.5)
                
                ScrollView {
                    ZStack {
                        SimpleVideoPlayer(player: viewModel.player!)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(radius: 10)
                        
                        if viewModel.isCaptionEnabled {
                            VStack {
                                Spacer()
                                Text(viewModel.currentSentence)
                                    .font(.title3)
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                                    .background(.black.opacity(0.5))
                                    .padding()
                            }
                        }
                    }
                    .frame(height: size.height / 1.4)
                    
                    PlayBackControl(isPlaying: $viewModel.isPlaying) {
                        if viewModel.isPlaying {
                            viewModel.player?.pause()
                        } else {
                            viewModel.player?.play()
                        }
                    }
                    .padding(5)
                    
                    Text("The Intro Paragraph")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(viewModel.completeParagraph)
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.vertical, 1)
                }
                
                // MARK: - Top Buttons
                VStack {
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 50)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                            
                            Image(systemName: "arrow.left")
                                .scaleEffect(1.2)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                viewModel.isCaptionEnabled.toggle()
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 50)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                
                                Image(systemName: viewModel.isCaptionEnabled
                                      ? "captions.bubble.fill"
                                      : "captions.bubble")
                                .scaleEffect(1.2)
                                .foregroundColor(.black)
                            }
                        }
                        
                    }
                    .padding(.top, safeArea.top)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    HomeView()
}
