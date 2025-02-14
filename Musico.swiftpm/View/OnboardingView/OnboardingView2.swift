//
//  OnboardingView1.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

struct OnboardingView2: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: OnboardingView3()) {
                    Text("2")
                        .font(.custom("DIN Alternate", size: 32))
                        .padding(.top, 30)
                        .foregroundColor(.purple)
                }
                Text("It was created to help people with hearing impairments get closer to music.")
            }
        }
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView2()
        
    }
}

