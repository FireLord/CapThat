//
//  TopButton.swift
//  CapThat
//
//  Created by Aman Kumar on 10/07/24.
//

import SwiftUI

struct TopButton: View {
    @Binding var isCaptionEnabled: Bool
    let safeArea: EdgeInsets
    
    var body: some View {
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
                        isCaptionEnabled.toggle()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 50)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        Image(systemName: isCaptionEnabled
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
}

#Preview {
    TopButton(isCaptionEnabled: .constant(false), safeArea: EdgeInsets())
}
