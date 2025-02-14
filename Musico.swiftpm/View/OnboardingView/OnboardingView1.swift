

// ** 02/12 툴바 써서 백버튼 커스텀이 가능하나 왼쪽을 드래그해서 dismiss 하는 부분이 지원x
//참고: https://swift-library.tistory.com/3

import SwiftUI

struct OnboardingView1: View {
    

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
                NavigationLink(destination: OnboardingView2()) {
                    Text("1")
                        .font(.custom("DIN Alternate", size: 32))
                        .padding(.top, 30)
                        .foregroundColor(.purple)
                }
                Text("Musico is an app that represents music and connection.")
                
            }
        }
    }
}

struct OnboardingView1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView1()
           
    }
}


