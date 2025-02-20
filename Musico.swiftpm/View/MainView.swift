//
//  MusicoView.swift
//  Musico
//
//  Created by yeji on 2/11/25.
//

////https://develop-const.tistory.com/29

import SwiftUI
import CoreHaptics

struct MainView: View {
    @AppStorage("isFirstOnboarding") var isFirstOnboarding: Bool = true
    @State private var isMainViewActive = false
    @State private var isModalPresented = true
    @Binding var engine: CHHapticEngine?
    @Binding var activeHaptic: Bool
    
    var body: some View {
        
        ZStack {
            if isMainViewActive {
                NavigationStack {
                    ZStack {
                    Color.background
                        .edgesIgnoringSafeArea(.all)
                    
                        VStack(alignment:.center,spacing: 20) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    isFirstOnboarding = true
                                }) {
                                    Image(systemName:("info.circle.fill"))
                                        .resizable()
                                        .frame(width:28, height: 28)
                                        .foregroundColor(.musicoPurple)
                            
                                    
                                }
                                .padding()
                            }
                            
                         
                            Text("Music is made up of three key elements: rhythm, melody, and harmony")
                                .font(.custom("LeeSeoyun", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .padding()
                            
                            NavigationLink(destination: RhythmView()) {
                                Text("Rhythm")
                                    .font(.custom("LeeSeoyun", size: 28))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 40)
                                    .frame(maxWidth: 280)
                                    .background(Color.musicoPurple)
                                    .cornerRadius(20)
                            }
                            
                            NavigationLink(destination:  MelodyView(engine: $engine, activeHaptic: $activeHaptic)) {
                                Text("Melody")
                                    .font(.custom("LeeSeoyun", size: 28))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 40)
                                    .frame(maxWidth: 280)
                                    .background(Color.musicoPurple)
                                    .cornerRadius(20)
                            }
                            
                            NavigationLink(destination: HarmonyView()) {
                                Text("Harmony")
                                    .font(.custom("LeeSeoyun", size: 28))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 40)
                                    .frame(maxWidth: 280)
                                    .background(Color.musicoPurple)
                                    .cornerRadius(20)
                            }
                            
                            Text("Explore the three key elements of music")
                                .font(.custom("LeeSeoyun", size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                        }
                        .padding()
                        
                    }
                }
                
                
            }
            else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isMainViewActive = true
                            }
                        }
                    }
            }
        }
        .fullScreenCover(isPresented: $isFirstOnboarding) {
            OnboardingTabView(isFirstOnboarding: $isFirstOnboarding)
        }
      
    }
}
struct MainView_Previews: PreviewProvider {
    
    @State static var engine: CHHapticEngine? = nil
    @State static var activeHaptic: Bool = false
    
    static var previews: some View {
        MainView(engine: $engine, activeHaptic: $activeHaptic)
    }
}
