//
//  MusicoView.swift
//  Musico
//
//  Created by yeji on 2/11/25.
//

import SwiftUI


struct MusicoView: View {
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Music is made up of Rhythm, Melody and Harmony!")
            Text("This is like patterns,color and color harmony in visual art.")
            ScrollView(.horizontal){
                HStack {
                    NavigationLink(destination: RhythmStoryView1()) {
                        Rectangle()
                            .frame(width: 250, height:350)
                            .cornerRadius(20)
                            .padding(8)
                    }
                    NavigationLink(destination: MelodyStoryView1()) {
                        Rectangle()
                            .frame(width: 250, height: 350)
                            .cornerRadius(20)
                            .padding(8)
                    }
                    NavigationLink(destination: HarmonyStoryView1()) {
                        Rectangle()
                            .frame(width: 250, height: 350)
                            .cornerRadius(20)
                            .padding(8)
                    }
                }
            }
            Text("Experience all of them.")
            
        }
    }}
struct MusicoView_Previews: PreviewProvider {
    static var previews: some View {
        MusicoView()
    }
}
