//
//  ContentView.swift
//  WindowSceneScreen
//
//  Created by 임채윤 on 12/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.red)
                .frame(width: getScreenWidth() / 2, height: getScreenHeight() / 2)
        }
        .padding()
    }
}

extension View {
    func getScreenWidth() -> CGFloat {
        guard let windowScene =
                UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return 0
        }

        return windowScene.screen.bounds.width
    }
    
    func getScreenHeight() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return 0
        }
        
        return windowScene.screen.bounds.height
    }
}

#Preview {
    ContentView()
}
