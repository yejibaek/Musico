import SwiftUI

struct MainView: View {
    @State private var fullScreenVisible = false
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, Color.backgroundBottom]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Musico")
//                            .font(.custom("DashingUnicorn", size: 96))
                        Text("See, Feel and Live the music")
//                            .font(.custom("DashingUnicorn", size: 24))
                            .padding(.bottom, 20)
//                        Image("MusicoLogo")
                        NavigationLink(destination: OnboardingView1()) {
                            Text("Touch Start!")
//                                .font(.custom("DashingUnicorn", size: 32))
                                .padding(.top, 30)
                                .foregroundColor(.purple)
                        }
                        
                    }
                    
                }
            }
        }
    }
}
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
               
        }
    }
    


//                            .onAppear {
//                                            for family: String in UIFont.familyNames {
//                                            print(family)
//                                                for names : String in UIFont.fontNames(forFamilyName: family){
//                                                print("=== \(names)")
//                                                  }
//                                               }
//                                       }
                        
