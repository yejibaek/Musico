

// ** 02/12 툴바 써서 백버튼 커스텀이 가능하나 왼쪽을 드래그해서 dismiss 하는 부분이 지원x
//참고: https://swift-library.tistory.com/3
//https://leesangdo.tistory.com/295

import SwiftUI

struct OnboardingIntroView: View {
    
    
    var body: some View {
        VStack {
            Text("Music")
                .font(.custom("Dashing Unicorn", size: 84))
                .foregroundColor(.musicoPurple)
            Text("+")
                .font(.custom("Dashing Unicorn", size: 84))
                .foregroundColor(.black)
            HStack {
                Text("Co")
                    .font(.custom("Dashing Unicorn", size: 84))
                    .foregroundColor(.musicoPurple)
                Text("nnection")
                    .font(.custom("Dashing Unicorn", size: 84))
                    .foregroundColor(.black)
            }
            
            Text("Musico stands for both music and connection. ")
                .padding()
                .font(.custom("LeeSeoyun", size: 28))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
}

struct OnboardingIntroView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIntroView()
    }
}

