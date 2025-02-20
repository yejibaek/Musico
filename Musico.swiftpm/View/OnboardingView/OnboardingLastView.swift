//
//  OnboardingView1.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

struct OnboardingLastView: View {
    @Binding var isFirstOnboarding: Bool
    
    var body: some View {
        VStack {
            Text("Shall we get closer to music?")
                .padding()
                .font(.custom("LeeSeoyun", size: 44))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            Image("MusicoLogo")
            Button {
                isFirstOnboarding.toggle()
            } label: {
                Text("Sure!")
                    .font(.custom("LeeSeoyun", size: 24))
                    .bold()
                    .padding(.vertical, 24)
                    .padding(.horizontal,48)
                    .background(Color.musicoPurple) .foregroundColor(.white)
                    .cornerRadius(20)
                
            }
            .padding()
        }
    }
}
struct OnboardingLastView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingLastView(isFirstOnboarding: .constant(true))
    }
}
