//
//  Alignment.swift
//  TextField
//
//  Created by 임채윤 on 11/22/24.
//

import SwiftUI

struct Alignment: View {
    @State var leadingAlignment: String = ""
    @State var centerAlignment: String = ""
    @State var trailingAlignment: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            TextField("왼쪽 정렬", text: $leadingAlignment)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .multilineTextAlignment(.leading)
            
            TextField("중앙 정렬", text: $centerAlignment)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .multilineTextAlignment(.center)
        
            
            TextField("우측 정렬", text: $trailingAlignment)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .multilineTextAlignment(.trailing)
        }
        .padding()
    }
}

#Preview {
    Alignment()
}
