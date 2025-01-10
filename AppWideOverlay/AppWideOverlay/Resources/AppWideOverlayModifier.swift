//
//  AppWideOverlayModifier.swift
//  AppWideOverlay
//
//  Created by 임채윤 on 1/10/25.
//

import SwiftUI

// MARK: 뷰 모디파이어로 사용하기 위한 Extension
extension View {
    @ViewBuilder
    func appWideOverlay<Content: View>(
        isShowing: Binding<Bool>,
        animation: Animation? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .modifier(
                AppWideOverlayModifier(
                    isShowing: isShowing,
                    animation: animation,
                    viewContent: content
                )
            )
    }
}

fileprivate struct AppWideOverlayModifier<ViewContent: View>: ViewModifier {
    @Environment(AppWideOverlayStore.self) private var appWideOverlayStore
    
    @Binding var isShowing: Bool
    var animation: Animation?
    @ViewBuilder var viewContent: ViewContent

    @State private var viewID: String?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isShowing) { _, newValue in
                if newValue {
                    addView()
                } else {
                    removeView()
                }
            }
    }
    
    private func addView() {
        if appWideOverlayStore.window != nil, viewID == nil {
            viewID = UUID().uuidString
            guard let viewID else { return }
            
            withAnimation(animation) {
                appWideOverlayStore.views.append(
                    AppWideOverlayStore.OverlayView(id: viewID, view: .init(viewContent))
                )
            }
        }
    }
    
    private func removeView() {
        if let viewID {
            withAnimation(animation) {
                appWideOverlayStore.views.removeAll(where: { $0.id == viewID } )
            }
            
            self.viewID = nil
        }
    }
}
