//https://develop-const.tistory.com/29

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Musico")
                    .font(.custom("Dashing Unicorn", size: 96))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Text("See, Feel and Live the music")
                    .font(.custom("Dashing Unicorn", size: 24))
                    .foregroundColor(.black)
                    .padding(.bottom, 16)
                Image("MusicoLogo")
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
