//
//  OnboardingView1.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

struct OnboardingWhatView: View {

    
    var body: some View {
        Text("Musico explains music by comparing it to art, delivering it through sight (images) and touch (haptic).")
            .padding()
            .font(.custom("LeeSeoyun", size: 28))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)

            
    }
}
struct OnboardingWhatView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingWhatView()
        
    }
}

