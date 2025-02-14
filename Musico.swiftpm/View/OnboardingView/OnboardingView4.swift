//
//  OnboardingView1.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

struct OnboardingView4: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: MusicoView()) {
                    Text("4")
                        .font(.custom("DIN Alternate", size: 32))
                        .padding(.top, 30)
                        .foregroundColor(.purple)
                }
                Text("Through Musico, we hope you can see,feel, and get closer to music.")
            }
        }
    }
}

struct OnboardingView4_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView4()
           
    }
}

