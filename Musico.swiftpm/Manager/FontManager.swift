////
////  SwiftUIView.swift
////  Musico
////
////  Created by yeji on 2/12/25.
////
//

import SwiftUI

struct FontManager {
    static func registerFonts() {
        // 폰트 파일과 확장자를 적절히 지정
        loadCustomFont(name: "Dashing Unicorn", fileExtension: "ttf")
        loadCustomFont(name: "LeeSeoyun", fileExtension: "ttf") // Leesoyun 폰트 추가
    }

    static func loadCustomFont(name: String, fileExtension: String) {
        // 폰트 URL 찾기
        guard let fontURL = Bundle.main.url(forResource: name, withExtension: fileExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            print("Failed to load font: \(name)")
            return
        }

        // 폰트 등록하기
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("Error registering font: \(error?.takeUnretainedValue().localizedDescription ?? "Unknown error")")
        } else {
            print("Font registered successfully: \(name)")
        }
    }
}
