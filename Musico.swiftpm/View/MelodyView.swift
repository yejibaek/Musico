import SwiftUI
import CoreHaptics

struct MelodyView: View {
    @State private var isModalPresented = true
    @Binding var engine: CHHapticEngine?
    @Binding var activeHaptic: Bool
    @ObservedObject var hapticManager = HapticManager()
    
    @State private var pressedKeys: [HapticManager.HapticType: Bool] = [
        .C: false, .D: false, .E: false, .F: false, .G: false, .A: false, .B: false,
        .CSharp: false, .DSharp: false, .FSharp: false, .GSharp: false, .ASharp: false
    ]
    @State private var displayedImages: [(image: String, offsetX: CGFloat, offsetY: CGFloat)] = []
    
    init(engine: Binding<CHHapticEngine?>, activeHaptic: Binding<Bool>) {
        self._engine = engine
        self._activeHaptic = activeHaptic
    }
    
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
                }
                    .padding()
                ZStack {
                    let screenWidth = UIScreen.main.bounds.width
                    let screenHeight = UIScreen.main.bounds.height

                    Image("MusicoFloor")
                        .resizable()
                        .frame(width: screenWidth * 0.8, height: screenHeight * 0.2) // 화면 너비의 80%와 화면 높이의 20%로 설정
                        .padding()
                    ForEach(displayedImages, id: \.image) { item in
                        Image(item.image)
                            .resizable()
                            .frame(width: 140, height: 140)
                            .transition(.opacity)
                            .offset(x: item.offsetX, y: item.offsetY)
                    }
                }
                
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
                .sheet(isPresented: $isModalPresented) {
                    ExplainMelodyView(isModalPresented: $isModalPresented)
                }
            }
        }
    }
    
  
    private func pianoKey(type: HapticManager.HapticType, normalImage: String, pressedImage: String, width: CGFloat, height: CGFloat, offsetX: CGFloat = 20, offsetY: CGFloat = 0) -> some View {
        Image(pressedKeys[type] == true ? pressedImage : normalImage)
            .resizable()
            .frame(width: width, height: height)
            .offset(x: offsetX, y: offsetY)
            .simultaneousGesture(
                TapGesture().onEnded {
                    pressedKeys[type] = true
                    hapticManager.playHaptic(type: type)

                    

                    let screenWidth = UIScreen.main.bounds.width
                    let screenHeight = UIScreen.main.bounds.height
                    let noteOffset = type.imageOffset(screenWidth: screenWidth, screenHeight: screenHeight)


                    let resizedImageName = type.imageName()

                    // 여기에서 크기를 줄여서 표시합니다 (예: 50x50)
                    displayedImages.append((image: resizedImageName, offsetX: noteOffset.x, offsetY: noteOffset.y))

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        pressedKeys[type] = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        displayedImages.removeAll { $0.image == pressedImage || $0.image == resizedImageName }
                    }
                }
            )
    }

}
struct MelodyView_Previews: PreviewProvider {
    @State static var engine: CHHapticEngine? = nil
    @State static var activeHaptic: Bool = false
    
    static var previews: some View {
        MelodyView(engine: $engine, activeHaptic: $activeHaptic)
    }
}
