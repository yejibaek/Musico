import SwiftUI

struct Demo: View {
    @State private var currentImageIndex = 0
    @State private var isAnimating = false
    @State private var timer: Timer? = nil
    
    let imageTimings: [Double] = [0, 0.85, 1.56, 2.07, 3.35, 4.2, 4.91, 5.42] // 시간 배열
    let images: [String] = ["Ckeypic", "Ckeypic", "Ckeypic", "Ckeypic", "Ckeypic", "Ckeypic", "Ckeypic"] // 이미지 배열
    
    var body: some View {
        VStack {
            HStack(spacing: 20) { // 이미지를 오른쪽으로 추가하기 위해 HStack을 사용
                ForEach(0..<currentImageIndex, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 200)
                }
            }

            Button(action: startAnimation) {
                Text(isAnimating ? "애니메이션 중..." : "애니메이션 시작")
                    .font(.title)
                    .padding()
                    .background(isAnimating ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isAnimating) // 애니메이션 중에는 버튼 비활성화
        }
        .padding()
    }
    
    // 애니메이션 시작
    func startAnimation() {
        isAnimating = true
        currentImageIndex = 0
        
        // 타이머 설정
        timer?.invalidate() // 이전 타이머가 있을 경우 취소
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async { // 메인 스레드에서 호출
                updateImage()
            }
        }
    }
    
    // 이미지 업데이트
    func updateImage() {
        let currentTime = Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 6.0) // 시간의 반복적인 순서 만들기
        
        // currentImageIndex가 갱신될 때마다, 이미지 추가 조건을 체크
        if let nextIndex = imageTimings.firstIndex(where: { currentTime >= $0 && currentTime < $0 + 0.1 }) {
            // currentImageIndex가 nextIndex보다 작을 때만 추가
            if currentImageIndex < nextIndex {
                // 중복되지 않도록 추가
                currentImageIndex = nextIndex
                withAnimation {
                    // 이미지를 순차적으로 추가
                }
            }
        }
        
        // 애니메이션 끝나면 타이머 취소하고 초기화
        if currentImageIndex >= images.count {
            timer?.invalidate()
            isAnimating = false
            resetAnimation() // 애니메이션 초기화
        }
    }
    
    // 애니메이션 초기화 함수 (초기화 딜레이 조금 더 길게 설정)
    func resetAnimation() {
        // 상태를 초기화하여 다시 애니메이션을 시작할 수 있도록 함
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1초 대기 후 초기화
            currentImageIndex = 0
        }
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
