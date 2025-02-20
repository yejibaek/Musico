//
//  OnboardingView1.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

struct OnboardingHopeView: View {
    
    
    var body: some View {

                Text("It expresses the desire for you to connect with music and get closer to it.")
            .padding()
            .font(.custom("LeeSeoyun", size: 28))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
        }
}

struct OnboardingHopeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHopeView()
        
    }
}

