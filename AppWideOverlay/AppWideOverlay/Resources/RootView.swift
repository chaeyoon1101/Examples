//
//  RootView.swift
//  AppWideOverlay
//
//  Created by 임채윤 on 1/10/25.
//

import SwiftUI

// MARK: 오버레이를 띄울 Root View
struct RootView<Content: View>: View {
    var content: Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    private var appWideOverlayStore = AppWideOverlayStore()
    
    var body: some View {
        content
            .environment(appWideOverlayStore)
            .onAppear {
                setupWindow()
            }
    }
    
    private func setupWindow() {
        guard appWideOverlayStore.window == nil,
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        let window = PassThroughWindow(windowScene: windowScene)
        
        window.isHidden = false
        window.isUserInteractionEnabled = true
        
        let rootViewController = UIHostingController(rootView: AppWideOverlayViews().environment(appWideOverlayStore))
        rootViewController.view.backgroundColor = .clear
        window.rootViewController = rootViewController
        
        appWideOverlayStore.window = window
    }
}

// MARK: 여러 오버레이 뷰들을 보여주는 뷰
fileprivate struct AppWideOverlayViews: View {
    @Environment(AppWideOverlayStore.self) private var appWideOverlayStore
    
    var body: some View {
        ZStack {
            ForEach(appWideOverlayStore.views) {
                $0.view
            }
        }
    }
}

// MARK: 오버레이 뷰에 이벤트를 전달해주는 UIWIndow
fileprivate class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view else { return nil }
        
        for subView in rootView.subviews.reversed() {
            let pointInSubView = subView.convert(point, from: rootView)
            
            if subView.hitTest(pointInSubView, with: event) != nil {
                return hitView
            }
        }
        
        return nil
    }
}


