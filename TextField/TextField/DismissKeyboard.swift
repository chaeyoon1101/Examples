//
//  DismissKeyboard.swift
//  TextField
//
//  Created by 임채윤 on 11/22/24.
//

import SwiftUI

struct DismissKeyboard: View {
    @State var text: String = ""
    
    var body: some View {
        VStack(spacing: 24){
            TextField("텍스트를 입력해주세요", text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
            
            Button("키보드 닫기") {
                dismissKeyboard()
            }
        }
        .padding()
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    DismissKeyboard()
}
