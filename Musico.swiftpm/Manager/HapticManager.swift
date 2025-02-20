import SwiftUI
import CoreHaptics
import AVFoundation

class HapticManager: ObservableObject {
    @Published var engine: CHHapticEngine?
    @Published var activeHaptic: Bool = false
    var audioPlayers: [HapticType: AVAudioPlayer] = [:] // 🔥 미리 로드한 소리를 저장
    
    init() {
        prepareHaptics()
        setupAudioSession()
        preloadSounds() // ✅ 사운드를 미리 로드
    }
    
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    
    func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine failed to start: \(error.localizedDescription)")
        }
    }
    
    // ✅ 미리 소리를 로드해서 audioPlayers에 저장
    func preloadSounds() {
        for type in HapticType.allCases {
            if let song = NSDataAsset(name: type.soundFileName())?.data {
                do {
                    let player = try AVAudioPlayer(data: song, fileTypeHint: "m4a")
                    player.prepareToPlay() // ✅ 미리 준비
                    audioPlayers[type] = player
                } catch {
                    print("Error preloading sound for \(type): \(error.localizedDescription)")
                }
            } else {
                print("Sound file not found: \(type.soundFileName())")
            }
        }
    }
    
    func playHaptic(type: HapticType) {
        do {
            let pattern = try CHHapticPattern(events: [type.hapticEvent()], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            
            playSound(for: type) // ✅ 사운드 재생 속도 향상됨
        } catch {
            print("Failed to play haptic: \(error.localizedDescription)")
        }
    }
    
    func playSound(for type: HapticType) {
        if let player = audioPlayers[type] {
            player.currentTime = 0 // ✅ 재생 위치를 처음으로 설정
            player.play()
        } else {
            print("No preloaded sound found for \(type)")
        }
    }
    
    func stopSound() {
        for (_, player) in audioPlayers {
            player.stop()
        }
    }
    
    enum HapticType: CaseIterable {
        case C, CSharp, D, DSharp, E, F, FSharp, G, GSharp, A, ASharp, B
        
        func hapticEvent() -> CHHapticEvent {
            let sharpnessValues: [HapticType: Float] = [
                .C: 0.118, .CSharp: 0.157, .D: 0.203, .DSharp: 0.258, .E: 0.323,
                .F: 0.398, .FSharp: 0.485, .G: 0.585, .GSharp: 0.698, .A: 0.75,
                .ASharp: 0.870, .B: 0.920,
            ]
            
            let sharpness = sharpnessValues[self] ?? 0.5
            
            return CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.3),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
                ],
                relativeTime: 0, duration: 0.5 // ✅ 햅틱 지속 시간을 줄여서 반응성 개선
            )
        }
        
        func soundFileName() -> String {
            switch self {
            case .C: return "Ckey"
            case .CSharp: return "CSharpkey"
            case .D: return "Dkey"
            case .DSharp: return "DSharpkey"
            case .E: return "Ekey"
            case .F: return "Fkey"
            case .FSharp: return "FSharpkey"
            case .G: return "Gkey"
            case .GSharp: return "GSharpkey"
            case .A: return "Akey"
            case .ASharp: return "ASharpkey"
            case .B: return "Bkey"
            }
        }
        func imageName() -> String {
            switch self {
            case .C: return "Cfloor"
            case .CSharp: return "C#floor"
            case .D: return "Dfloor"
            case .DSharp: return "D#floor"
            case .E: return "Efloor"
            case .F: return "Ffloor"
            case .FSharp: return "F#floor"
            case .G: return "Gfloor"
            case .GSharp: return "G#floor"
            case .A: return "Afloor"
            case .ASharp: return "A#floor"
            case .B: return "Bfloor"
            }
        }
        func imageOffset(screenWidth: CGFloat, screenHeight: CGFloat) -> (x: CGFloat, y: CGFloat) {
            let baseX = screenWidth * 0.27 // 화면 너비에 비례한 x 위치
            let baseY = screenHeight * 0.01  // 화면 높이에 비례한 y 위치 (조정 가능)
            
            switch self {
            case .C: return (-baseX , baseY * -0.1)  // baseY를 사용하여 y 좌표 동적으로 조정
            case .CSharp: return (-baseX , baseY * -0.1)
            case .D: return (-baseX * 0.7, baseY * -1.6)
            case .DSharp: return (-baseX * 0.7, baseY * -1.6)
            case .E: return (-baseX * 0.4, baseY * -3.2)
            case .F: return (-baseX * 0.1, baseY * -4.4)
            case .FSharp: return (-baseX * 0.1, baseY * -4.4)
            case .G: return (baseX * 0.28, baseY * -5.6)
            case .GSharp: return (baseX * 0.28, baseY * -5.6)
            case .A: return (baseX * 0.6, baseY * -6.8)
            case .ASharp: return (baseX * 0.6, baseY * -6.8)
            case .B: return (baseX * 0.9, baseY * -8.5)
            }
        }


        
        func normalImageName() -> String {
            return imageName()
        }
        
        func pressedImageName() -> String {
            return imageName() + "_pressed" // 눌린 상태일 때 이미지 파일명이 다를 경우 수정
        }
        
        
    }
    
}
