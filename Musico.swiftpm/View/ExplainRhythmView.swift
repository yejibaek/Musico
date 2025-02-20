//
//  RhythmStoryView1.swift
//  Musico
//
//  Created by yeji on 2/13/25.
//


import SwiftUI

struct ExplainRhythmView: View {
    
    @Binding var isModalPresented: Bool
    
    var body: some View {
        ZStack {
            Color.modalBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("What is Rhythm?")
                    .font(.custom("Dashing Unicorn", size: 40))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Text("Rhythm is the pattern of sound and silence, the repetition of sounds over time.")
                    .font(.custom("LeeSeoyun", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("🔊🔇🔊🔊   🔊🔇🔊🔊   🔊🔇🔊🔊")
                    .padding()
                Text("Just as visual art creates flow and style through repeated patterns—and brings vibrancy by changing them—music also establishes its flow and character through repetition and gains energy through variation.")
                    .font(.custom("LeeSeoyun", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack {
                    Image("patternMoza")
                        .padding(.horizontal)
                    Image("patternMandara")
                }
                Text("In Musico, we offer you a chance to experience some fun rhythms through vibrations, and we've also provided a launchpad feature where you can follow along and create rhythms yourself!")
                    .font(.custom("LeeSeoyun", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Now, close this modal and feel the rhythm!")
                    .font(.custom("LeeSeoyun", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
           
            
        }
        
    }
}

struct ExplainRhythmView_Previews: PreviewProvider {

    static var previews: some View {
        ExplainRhythmView(isModalPresented: .constant(true))
    }
}


//Rhythm is the pattern of sound and silence, the repetition of sounds over time.
//
//Just as visual art creates flow and style through repeated patterns—and brings vibrancy by changing them—music also establishes its flow and character through repetition and gains energy through variation.
//
//Just like art movements are categorized by their patterns, musical styles can also be distinguished by their rhythms.
//
//In Musico, we introduce three of the most exciting rhythm-based music styles—Hip-Hop, Disco, and Afro—allowing you to experience their unique grooves through vibrations. You can even try recreating these rhythms yourself using the Launchpad!
//
//Close this modal and feel the rhythm!
