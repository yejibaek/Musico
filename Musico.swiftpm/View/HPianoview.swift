import SwiftUI
import CoreHaptics

extension HapticManager.HapticType: Comparable {
    static func < (lhs: HapticManager.HapticType, rhs: HapticManager.HapticType) -> Bool {
        let order: [HapticManager.HapticType] = [.C, .CSharp, .D, .DSharp, .E, .F, .FSharp, .G, .GSharp, .A, .ASharp, .B]
        
        guard let lhsIndex = order.firstIndex(of: lhs),
              let rhsIndex = order.firstIndex(of: rhs) else {
            return false
        }
    
        return lhsIndex < rhsIndex
    }
}

struct HPianoView: View {
    @StateObject private var hapticManager = HapticManager()
    @State private var selectedKeys: Set<HapticManager.HapticType> = []
    @State private var resultText: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(resultText)
                    .font(.largeTitle)
                
                ZStack {
                    HStack(alignment: .top, spacing: -10) {
                        pianoKey(type: .C, normalImage: "C", pressedImage: "C2", width: 100, height: 223)
                        pianoKey(type: .D, normalImage: "D", pressedImage: "D2", width: 100, height: 223)
                        pianoKey(type: .E, normalImage: "E", pressedImage: "E2", width: 100, height: 223)
                        pianoKey(type: .F, normalImage: "F", pressedImage: "F2", width: 100, height: 223)
                        pianoKey(type: .G, normalImage: "G", pressedImage: "G2", width: 100, height: 223)
                        pianoKey(type: .A, normalImage: "A", pressedImage: "A2", width: 100, height: 223)
                        pianoKey(type: .B, normalImage: "B", pressedImage: "B2", width: 100, height: 223)
                    }
                    .offset(x: -60, y: 80)
                    
                    HStack {
                        pianoKey(type: .CSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: 60, height: 129, offsetX: -109, offsetY: 33)
                        pianoKey(type: .DSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: 60, height: 129, offsetX: -86, offsetY: 33)
                        pianoKey(type: .FSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: 60, height: 129, offsetX: 26, offsetY: 33)
                        pianoKey(type: .GSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: 60, height: 129, offsetX: 49, offsetY: 33)
                        pianoKey(type: .ASharp, normalImage: "blackkey", pressedImage: "black_pressed", width: 60, height: 129, offsetX: 72, offsetY: 33)
                    }
                }
                
            }
        }
    }
    
    private func pianoKey(type: HapticManager.HapticType, normalImage: String, pressedImage: String, width: CGFloat, height: CGFloat, offsetX: CGFloat = 40, offsetY: CGFloat = 0) -> some View {
        Image(selectedKeys.contains(type) ? pressedImage : normalImage)
            .resizable()
            .frame(width: width, height: height)
            .offset(x: offsetX, y: offsetY)
            .onTapGesture {
                withAnimation {
                    selectKey(type: type)
                }
            }
    }
    
    private func selectKey(type: HapticManager.HapticType) {
        if selectedKeys.contains(type) {
            selectedKeys.remove(type)
        } else if selectedKeys.count < 3 {
            selectedKeys.insert(type)
        }
        
        hapticManager.playHaptic(type: type)
        
        if selectedKeys.count == 3 {
            analyzeChord()
        }
    }
    
    private func analyzeChord() {
        let majorChords: Set<[HapticManager.HapticType]> = [
            [.C, .E, .G],  // C major
            [.D, .FSharp, .A],  // D major
            [.E, .GSharp, .B],  // E major
            [.F, .A, .C],  // F major
            [.G, .B, .D],  // G major
            [.A, .CSharp, .E],  // A major
            [.B, .DSharp, .FSharp]  // B major
        ]
        let minorChords: Set<[HapticManager.HapticType]> = [
            [.C, .DSharp, .G],  // C minor
            [.D, .F, .A],  // D minor
            [.E, .G, .B],  // E minor
            [.F, .GSharp, .C],  // F minor
            [.G, .ASharp, .D],  // G minor
            [.A, .C, .E],  // A minor
            [.B, .D, .FSharp]  // B minor
        ]
        
      
        let sortedKeys = selectedKeys.sorted()
        
        if majorChords.contains(sortedKeys) {
            resultText = "밝은이미지와 배경"
        } else if minorChords.contains(sortedKeys) {
            resultText = "어두운 이미지와 배경"
        } else {
            resultText = "불협화음"
        }
        
        // 2초 후에 초기화
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            selectedKeys.removeAll()
            resultText = ""
        }
    }
}


struct HPianoView_Previews: PreviewProvider {
    static var previews: some View {
        HPianoView()
            .previewInterfaceOrientation(.landscapeLeft) // 가로 화면 미리보기
    }
}
