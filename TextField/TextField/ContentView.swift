//
//  ContentView.swift
//  TextField
//
//  Created by 임채윤 on 11/22/24.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TextField("텍스트를 입력해주세요", text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
