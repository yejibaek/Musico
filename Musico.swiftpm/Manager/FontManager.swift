//
//  SwiftUIView.swift
//  Musico
//
//  Created by yeji on 2/12/25.
//

import SwiftUI

public struct FontManager {
    /// https://stackoverflow.com/questions/71916171/how-to-change-font-in-xcode-swift-playgrounds-swiftpm-project
    public static func registerFonts() {
        loadCustomFont(named: "Dashing Unicorn", fileExtension: ".ttf") //change according to your ext.
    }
    
    static func loadCustomFont(named fontName: String, fileExtension: String) {
        guard let fontURL = Bundle.main.url(forResource: fontName, withExtension: fileExtension),
              let fontData = try? Data(contentsOf: fontURL),
              let dataProvider = CGDataProvider(data: fontData as CFData),
              let fontRef = CGFont(dataProvider) else {
            print("❌ 폰트 로드 실패")
            return
        }
        
        var error: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(fontRef, &error) {
            print("✅ 폰트 로드 성공: \(fontName)")
        } else {
            print("❌ 폰트 등록 실패: \(error.debugDescription)")
        }
    }
}
