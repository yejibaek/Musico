//
//  MelodyView.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI
import CoreHaptics

struct RhythmView: View {
    
    @State private var isModalPresented = true
    @ObservedObject var hapticManager = HapticManager()
    @StateObject private var rhythmHapticManager = RhythmHapticManager()
    @State private var isPlayingHipHop = false
    @State private var isPlayingRock = false
    
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isModalPresented = true
                    }) {
                        Image(systemName:("info.circle.fill"))
                            .resizable()
                            .frame(width:28, height: 28)
                            .foregroundColor(.musicoPurple)
                    }
                }
                .padding()
                Spacer()
                Button(action: {
                    if isPlayingHipHop {
                        rhythmHapticManager.stopHaptic()
                    } else {
                        rhythmHapticManager.playHipHopHaptic()
                    }
                    isPlayingHipHop.toggle()
                    isPlayingRock = false
                }) {
                    Text(isPlayingHipHop ? "🛑 Stop" : "🎵 Boobap")
                        .font(.title2)
                        .padding()
                        .background(isPlayingHipHop ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                HStack {
                    Button(action: {
                        rhythmHapticManager.playKickHaptic()
                    }) {
                        Text("진동 버튼 1")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        rhythmHapticManager.playSnare1Haptic() // 두 번째 버튼 누를 때 진동 발생
                    }) {
                        Text("진동 버튼 2")
                            .font(.title)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                }
                .sheet(isPresented: $isModalPresented) {
                    ExplainRhythmView(isModalPresented: $isModalPresented)
                }
                
            }
        }
    }
}



struct RhythmView_Previews: PreviewProvider {
    static var previews: some View {
        RhythmView()
        
    }
}
