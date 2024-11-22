//
//  maxLength.swift
//  TextField
//
//  Created by 임채윤 on 11/22/24.
//

import SwiftUI

struct maxLength: View {
    @State var text: String = ""
    
    let maxLength = 15
    
    var body: some View {
        VStack {
            TextField("텍스트를 입력해주세요", text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .onChange(of: text) { oldValue, newValue in
                    if newValue.count > maxLength {
                        text = oldValue
                    }
                }
            
            Text("현재 글자 수: \(text.count) / \(maxLength)")
        }
        .padding()
    }
}

#Preview {
    maxLength()
}
