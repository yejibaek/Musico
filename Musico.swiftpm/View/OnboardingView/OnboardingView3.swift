//
//  OnboardingView1.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

struct OnboardingView3: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: OnboardingView4()) {
                    Text("3")
                        .font(.custom("DIN Alternate", size: 32))
                        .padding(.top, 30)
                        .foregroundColor(.purple)
                }
            }
        }
    }
}

struct OnboardingView3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView3()
        
    }
}

