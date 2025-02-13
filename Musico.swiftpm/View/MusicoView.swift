//
//  MusicoView.swift
//  Musico
//
//  Created by yeji on 2/11/25.
//

import SwiftUI

struct MusicoView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Melody")
                    Text("Harmony")
                    Text("Rhythm")
                }
            }
        }
    }
}


struct MusicoView_Previews: PreviewProvider {
    static var previews: some View {
        MusicoView()
        
    }
}
