//
//  OnboardingTabView.swift
//  Musico
//
//  Created by yeji on 2/18/25.
//

import SwiftUI

struct OnboardingTabView: View {
    
    @Binding var isFirstOnboarding: Bool
    
    
    var body: some View {
        ZStack {
            Color.modalBackground
                .edgesIgnoringSafeArea(.all)
            TabView() {
                
                OnboardingIntroView()
                
                OnboardingHopeView()
                
                OnboardingWhatView()
                
                OnboardingLastView(isFirstOnboarding: $isFirstOnboarding)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
}

struct OnboardingTabView_Previews: PreviewProvider {

    static var previews: some View {
        OnboardingTabView(isFirstOnboarding: .constant(true))
    }
}
