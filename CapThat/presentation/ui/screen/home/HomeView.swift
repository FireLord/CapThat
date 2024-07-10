import SwiftUI
import AVKit

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        GeometryReader { geometryReader in
            let size = geometryReader.size
            let safeArea = geometryReader.safeAreaInsets

            if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                // Portrait Mode
                VStack {
                    portraitView(size: size, safeArea: safeArea)
                }
                .ignoresSafeArea()
            } else {
                // Landscape Mode
                HStack {
                    landscapeView(size: size, safeArea: safeArea)
                }
                .ignoresSafeArea()
            }
        }
    }

    @ViewBuilder
    private func portraitView(size: CGSize, safeArea: EdgeInsets) -> some View {
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
                
                SeekBar(size: size, player: $viewModel.player, progress: $viewModel.progress, lastDraggedProgress: $viewModel.lastDraggedProgress, isSeeking: $viewModel.isSeeking)
                    .padding()
                
                PlayBackControl(isPlaying: $viewModel.isPlaying, isFinishedPlaying: $viewModel.isFinishedPlaying) {
                    if viewModel.isFinishedPlaying {
                        viewModel.isFinishedPlaying = false
                        viewModel.player?.seek(to: .zero)
                        viewModel.progress = .zero
                        viewModel.lastDraggedProgress = .zero
                    }
                    
                    if viewModel.isPlaying {
                        viewModel.player?.pause()
                    } else {
                        viewModel.player?.play()
                    }
                }
                
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
            
            TopButton(isCaptionEnabled: $viewModel.isCaptionEnabled, safeArea: safeArea)
        }
    }

    @ViewBuilder
    private func landscapeView(size: CGSize, safeArea: EdgeInsets) -> some View {
        ZStack {
            Color.teal.opacity(0.5)
            
            HStack() {
                ZStack(alignment: .center) {
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
                .padding()
                .frame(width: size.width / 2, height: size.height)
                
                ScrollView {
                    TopButton(isCaptionEnabled: $viewModel.isCaptionEnabled, safeArea: safeArea)
                    .padding(.top, 30)
                    
                    SeekBar(size: size, player: $viewModel.player, progress: $viewModel.progress, lastDraggedProgress: $viewModel.lastDraggedProgress, isSeeking: $viewModel.isSeeking)
                        .padding()
                    
                    PlayBackControl(isPlaying: $viewModel.isPlaying, isFinishedPlaying: $viewModel.isFinishedPlaying) {
                        if viewModel.isFinishedPlaying {
                            viewModel.isFinishedPlaying = false
                            viewModel.player?.seek(to: .zero)
                            viewModel.progress = .zero
                            viewModel.lastDraggedProgress = .zero
                        }
                        
                        if viewModel.isPlaying {
                            viewModel.player?.pause()
                        } else {
                            viewModel.player?.play()
                        }
                    }
                    
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
                .padding(.trailing, safeArea.trailing)

            }

        }
    }
}

#Preview {
    HomeView()
}
