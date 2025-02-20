//
//  RhythmHapticManager.swift
//  Musico
//
//  Created by yeji on 2/19/25.
//
import SwiftUI
import CoreHaptics

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
    func playKickHaptic() {
        let kick = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 0.0,
            duration: 0.3
        )
        playHapticPattern([kick]) // 'kick'만 포함된 패턴을 재생
    }
    
    func playSnare1Haptic() {
        let snare1 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)],
            relativeTime: 0.0
        )
        playHapticPattern([snare1]) // 'snare1'만 포함된 패턴을 재생
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
    //0, 1.18, 1.41, 2.04, 2.24, 2.44, 2.64, 2.84, 3.04, 4.17, 5.35, 5.58, 5.78, 5.98, 6.18, 6.38, 6.58, 6.78
   
    
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
}
