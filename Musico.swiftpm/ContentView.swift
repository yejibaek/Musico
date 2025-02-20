//
//  ContentView.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI
import CoreHaptics
import AVFoundation



struct ContentView: View {
    @State var engine: CHHapticEngine? = nil
    @State var activeHaptic: Bool = false
    
    var body: some View {
            VStack {
//                HPianoView()
//                PianoView(engine: $engine, activeHaptic: $activeHaptic)
              MainView(engine: $engine, activeHaptic: $activeHaptic)
                    .onAppear {
                        for family: String in UIFont.familyNames {
                            print(family)
                            for names : String in UIFont.fontNames(forFamilyName: family){
                                print("=== \(names)")
                            }
                        }
                    }
//                RhythmView()
                  
            }
    }
}

#Preview {
    ContentView()
}
