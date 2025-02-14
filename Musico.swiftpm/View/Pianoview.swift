import SwiftUI
import CoreHaptics

struct PianoView: View {
    @Binding var engine: CHHapticEngine?
    @Binding var activeHaptic: Bool
    @ObservedObject var hapticManager = HapticManager()
    
    // 각 키의 상태를 저장하는 변수
    @State private var pressedKeys: [HapticManager.HapticType: Bool] = [
        .C: false, .D: false, .E: false, .F: false, .G: false, .A: false, .B: false,
        .CSharp: false, .DSharp: false, .FSharp: false, .GSharp: false, .ASharp: false
    ]
    
    // 여러 개의 이미지를 저장할 변수 (이미지, X좌표, Y좌표)
    @State private var displayedImages: [(image: String, offsetX: CGFloat, offsetY: CGFloat)] = []
    
    init(engine: Binding<CHHapticEngine?>, activeHaptic: Binding<Bool>) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeLeft))
        }
        self._engine = engine
        self._activeHaptic = activeHaptic
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            // 화면 상단에 여러 개의 이미지 표시
            ForEach(displayedImages, id: \.image) { item in
                Image(item.image)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .transition(.opacity)
                    .offset(x: item.offsetX, y: item.offsetY) // 각 이미지마다 다른 위치
            }
            
            ZStack {
                HStack(alignment: .top, spacing:-10) {
                    pianoKey(type: .C, normalImage: "C", pressedImage: "C2", width: 100, height: 223)
                    pianoKey(type: .D, normalImage: "D", pressedImage: "D2", width: 100, height: 223)
                    pianoKey(type: .E, normalImage: "E", pressedImage: "E2", width: 100, height: 223)
                    pianoKey(type: .F, normalImage: "F", pressedImage: "F2", width: 100, height: 223)
                    pianoKey(type: .G, normalImage: "G", pressedImage: "G2", width: 100, height: 223)
                    pianoKey(type: .A, normalImage: "A", pressedImage: "A2", width: 100, height: 223)
                    pianoKey(type: .B, normalImage: "B", pressedImage: "B2", width: 100, height: 223)
                }
                .offset(x:-60,y:80)
                
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
    
  
    private func pianoKey(type: HapticManager.HapticType, normalImage: String, pressedImage: String, width: CGFloat, height: CGFloat, offsetX: CGFloat = 40, offsetY: CGFloat = 0) -> some View {
        Image(pressedKeys[type] == true ? pressedImage : normalImage)
            .resizable()
            .frame(width: width, height: height)
            .offset(x: offsetX, y: offsetY)
            .simultaneousGesture(
                TapGesture().onEnded {
                    pressedKeys[type] = true
                    hapticManager.playHaptic(type: type)

                    

                    // 🔥 새로운 이미지 (음표 이미지 등) 추가 - 크기 줄이기
                    let noteOffset = type.imageOffset()
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
struct PianoView_Previews: PreviewProvider {
    @State static var engine: CHHapticEngine? = nil
    @State static var activeHaptic: Bool = false
    
    static var previews: some View {
        PianoView(engine: $engine, activeHaptic: $activeHaptic)
            .previewInterfaceOrientation(.landscapeLeft) // 가로 화면 미리보기
    }
}
