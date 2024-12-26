//
//  ContentView.swift
//  RenderingMode
//
//  Created by 임채윤 on 12/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("Tree")
            .renderingMode(.template)
            .resizable()
            .frame(width: 120, height: 120)
            .foregroundStyle(.green)
    }
}

#Preview {
    ContentView()
}
