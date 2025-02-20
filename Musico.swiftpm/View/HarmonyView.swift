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

struct HarmonyView: View {
    @State private var isModalPresented = true
    @StateObject private var hapticManager = HapticManager()
    @State private var selectedKeys: Set<HapticManager.HapticType> = []
    @State private var resultText: String = ""
    @State private var resultImage: String? = nil

    
//    init() {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeLeft))
//                }
//    }
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isModalPresented = true
                    }) {
                        Image(systemName:("info.circle.fill"))
                            .resizable()
                            .frame(width:24, height: 24)
                            .foregroundColor(.musicoPurple)
                    }
                    .padding()
                }
                
                VStack {
                    if let imageName = resultImage {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 330)
                            .transition(.slide) // 부드러운 전환 효과
                    }
                    else {
                           // resultImage가 nil일 때 기본 이미지 표시
                           Image("DefaultImage") // 기본 이미지 이름을 설정하세요.
                               .resizable()
                               .scaledToFit()
                               .frame(height: 320)
                               .transition(.identity) // 부드러운 전환 효과
                       }
                    Text(resultText.isEmpty ? "Choose three notes to discover harmony and check its mood!" : resultText)
                        .multilineTextAlignment(.center)
                               .lineLimit(nil)
                               .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("LeeSeoyun", size: 20))
                            .foregroundColor(.black)
                
                }.padding()
                GeometryReader { geometry in
                    let keyWidth = geometry.size.width / 7.5 // 흰 건반의 너비
                    let blackKeyWidth = keyWidth * 0.6 // 검은 건반 크기
                    let blackKeyOffsetX: [HapticManager.HapticType: CGFloat] = [
                        .CSharp: keyWidth * 1.6, // C와 D 사이의 중앙
                        .DSharp: keyWidth * 1.5, // D와 E 사이의 중앙
                        .FSharp: keyWidth * 2.35, // F와 G 사이의 중앙
                        .GSharp: keyWidth * 2.25, // G와 A 사이의 중앙
                        .ASharp: keyWidth * 2.15 // A와 B 사이의 중앙
                    ]
                    
                    ZStack {
                        // 흰 건반 배치
                        VStack(alignment: .leading) {
                            HStack (spacing: -3){
                                pianoKey(type: .C, normalImage: "C", pressedImage: "C2", width: keyWidth, height: 160)
                                pianoKey(type: .D, normalImage: "D", pressedImage: "D2", width: keyWidth, height: 160)
                                pianoKey(type: .E, normalImage: "E", pressedImage: "E2", width: keyWidth, height: 160)
                                pianoKey(type: .F, normalImage: "F", pressedImage: "F2", width: keyWidth, height: 160)
                                pianoKey(type: .G, normalImage: "G", pressedImage: "G2", width: keyWidth, height: 160)
                                pianoKey(type: .A, normalImage: "A", pressedImage: "A2", width: keyWidth, height: 160)
                                pianoKey(type: .B, normalImage: "B", pressedImage: "B2", width: keyWidth, height: 160)
                            }

                        }

                        // 검은 건반 개별 배치
                        pianoKey(type: .CSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: blackKeyWidth, height: 90, offsetX: -keyWidth * 3.6 + blackKeyOffsetX[.CSharp]!, offsetY: -36)
                        pianoKey(type: .DSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: blackKeyWidth, height: 90, offsetX: -keyWidth * 2.5 + blackKeyOffsetX[.DSharp]!, offsetY: -36)
                        pianoKey(type: .FSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: blackKeyWidth, height: 90, offsetX: -keyWidth * 1.5 + blackKeyOffsetX[.FSharp]!, offsetY: -36)
                        pianoKey(type: .GSharp, normalImage: "blackkey", pressedImage: "black_pressed", width: blackKeyWidth, height: 90, offsetX: -keyWidth * 0.45 + blackKeyOffsetX[.GSharp]!, offsetY: -36)
                        pianoKey(type: .ASharp, normalImage: "blackkey", pressedImage: "black_pressed", width: blackKeyWidth, height: 90, offsetX: keyWidth * 0.6 + blackKeyOffsetX[.ASharp]!, offsetY: -36)
                    }
                }
            }
            .sheet(isPresented: $isModalPresented) {
                ExplainHarmonyView(isModalPresented: $isModalPresented)
                
            }
        }
        
    }
    
    private func pianoKey(type: HapticManager.HapticType, normalImage: String, pressedImage: String, width: CGFloat, height: CGFloat, offsetX: CGFloat = 20, offsetY: CGFloat = 0) -> some View {
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
                resultText = "Major chord, Bright and cheerful mood"
                resultImage = "MusicoMajor"  // 밝은 분위기의 이미지
            } else if minorChords.contains(sortedKeys) {
                resultText = "Minor chord, sad and dark mood"
                resultImage = "MusicoMinor"  // 어두운 분위기의 이미지
            } else {
                resultText = "Dissonance, chaotic harmony"
                resultImage = "MusicoDissonance"  // 불협화음 이미지
            }
            
        
        // 2초 후에 초기화
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            selectedKeys.removeAll()
            resultText = ""
            resultImage = nil
        }
    }
}


struct HarmonyView_Previews: PreviewProvider {
    static var previews: some View {
        HarmonyView()
//            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
