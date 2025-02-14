//
//  MelodyView.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI
import CoreHaptics

struct RhythmView: View {
    @StateObject private var rhythmHapticManager = RhythmHapticManager()
    @State private var isPlayingHipHop = false
    @State private var isPlayingRock = false

    var body: some View {
        VStack {
            Button(action: {
                if isPlayingHipHop {
                    rhythmHapticManager.stopHaptic()
                } else {
                    rhythmHapticManager.playHipHopHaptic()
                }
                isPlayingHipHop.toggle()
                isPlayingRock = false
            }) {
                Text(isPlayingHipHop ? "🛑 Stop" : "🎵 Boobap")
                    .font(.title2)
                    .padding()
                    .background(isPlayingHipHop ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                if isPlayingRock {
                    rhythmHapticManager.stopHaptic()
                } else {
                    rhythmHapticManager.playRockHaptic()
                }
                isPlayingRock.toggle()
                isPlayingHipHop = false
            }) {
                Text(isPlayingRock ? "🛑 Stop" : "🎸 Trap")
                    .font(.title2)
                    .padding()
                    .background(isPlayingRock ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

class RhythmHapticManager: ObservableObject {
    var rhythmengine: CHHapticEngine?
    var player: CHHapticPatternPlayer?
    
    init() {
        prepareRhythmHaptics()
    }
    
    func prepareRhythmHaptics() {
        do {
            rhythmengine = try CHHapticEngine()
            try rhythmengine?.start()
        } catch {
            print("Haptic engine failed: \(error.localizedDescription)")
        }
    }
    
    func playHipHopHaptic() {
        playHapticPattern(createHipHopHapticPattern())
    }
    
    func playRockHaptic() {
        playHapticPattern(createRockHapticPattern())
    }
    
    private func playHapticPattern(_ patternEvents: [CHHapticEvent]) {
        guard let rhythmengine = rhythmengine else { return }
        
        do {
            let pattern = try CHHapticPattern(events: patternEvents, parameters: [])
            player = try rhythmengine.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error.localizedDescription)")
        }
    }
    
    func stopHaptic() {
        do {
            try player?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptic: \(error.localizedDescription)")
        }
    }
    
    private func createHipHopHapticPattern() -> [CHHapticEvent] {
        let kick = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 0.0,
            duration: 0.3
        )
        //
        let snare1 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 0.76
        )
        let snaredouble1 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 0.76
        )
        //
        
        let snare2 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 1.61,
            duration: 0.3
        )
        let snaredouble2 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 1.61,
            duration: 0.3
        )
        //
        
        let kick2 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)],
            relativeTime: 1.74,
            duration: 0.3
        )
        //
        let snare3 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 2.07
        )
        let snaredouble3 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 2.07
        )
        //
        
        let kick3 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)],
            relativeTime: 2.78,
            duration: 0.3
        )
        let kick4 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)],
            relativeTime: 3.14,
            duration: 0.3)
        //
        let snare4 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 3.5)
        
        let snaredouble4 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 3.5)
        //
        let snare5 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 4.41,
            duration: 0.3)
        let snaredouble5 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 4.41,
            duration: 0.3)
        //
        
        let kick5 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)],
            relativeTime: 4.54, duration: 0.3)
        //
        let snare6 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 4.89)
        
        let snaredouble6 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 4.89)
        
        
        
        return [
            kick, snare1, snaredouble1,
            snare2, snaredouble2,
            kick2,
            snare3, snaredouble3,
            kick3, kick4,
            snare4, snaredouble4,
            snare5, snaredouble5,
            kick5,
            snare6, snaredouble6
        ]
    }
    //0,0.85,1.56,2.07,3.35,4.2,4.91,5.42/0.0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0,2.2,2.4,2.6,2.8,3.0
    private func createRockHapticPattern() -> [CHHapticEvent] {
        let ligSnare1 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 0.0)

        let ligSnare2 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 0.2)

        let ligSnare3 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 0.4)

        let ligSnare4 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 0.6)

        let ligSnare5 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 0.8)

        let ligSnare6 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 1.0)

        let ligSnare7 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 1.2)

        let ligSnare8 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 1.4)

        let ligSnare9 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                       relativeTime: 1.6)

        let ligSnare10 = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 1.8)

        let ligSnare11 = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 2.0)

        let ligSnare12 = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 2.2)

        let ligSnare13 = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 2.4)

        let ligSnare14 = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 2.6)

        let ligSnare15 = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 2.8)

        let ligSnare16 = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                                        relativeTime: 3.0)

        let ligkick1 = CHHapticEvent(eventType: .hapticContinuous,
                                     parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                          relativeTime: 0.0, duration: 0.4)

            let ligkick2 = CHHapticEvent(eventType: .hapticContinuous,
                                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                                                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)],
                                          relativeTime: 0.85, duration: 0.4)

            let ligkick3 = CHHapticEvent(eventType: .hapticContinuous,
                                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                          relativeTime: 1.56, duration: 0.4)

            let ligkick4 = CHHapticEvent(eventType: .hapticContinuous,
                                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                          relativeTime: 2.07, duration: 0.4)

            let ligkick5 = CHHapticEvent(eventType: .hapticContinuous,
                                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                          relativeTime: 3.35, duration: 0.4)

            let ligkick6 = CHHapticEvent(eventType: .hapticContinuous,
                                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                                                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)],
                                          relativeTime: 4.2, duration: 0.4)

            let ligkick7 = CHHapticEvent(eventType: .hapticContinuous,
                                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                          relativeTime: 4.91, duration: 0.4)

            let ligkick8 = CHHapticEvent(eventType: .hapticContinuous,
                                         parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                          relativeTime: 5.42, duration: 0.4)
        
        return [ligSnare1, ligSnare2, ligSnare3, ligSnare4, ligSnare5, ligSnare6, ligSnare7, ligSnare8, ligSnare9, ligSnare10, ligSnare11, ligSnare12, ligSnare13, ligSnare14, ligSnare15, ligSnare16, ligkick1, ligkick2, ligkick3, ligkick4, ligkick5, ligkick6, ligkick7, ligkick8]
    }
}
