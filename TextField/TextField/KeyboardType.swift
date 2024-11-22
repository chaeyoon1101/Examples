//
//  KeyboardType.swift
//  TextField
//
//  Created by 임채윤 on 11/22/24.
//

import SwiftUI

struct KeyboardType: View {
    @State var defaultText: String = ""
    @State var numberText: String = ""
    @State var emailText: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            TextField("글자를 입력해주세요", text: $defaultText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .keyboardType(.default) // 없어도 .default 상태
            
            TextField("숫자를 입력해주세요", text: $numberText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .keyboardType(.numberPad)
            
            TextField("이메일를 입력해주세요", text: $emailText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .keyboardType(.emailAddress)
        }
        .padding()
    }
}

#Preview {
    KeyboardType()
}
