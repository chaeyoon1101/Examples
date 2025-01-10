//
//  AppwideOverlayStore.swift
//  AppWideOverlay
//
//  Created by 임채윤 on 1/10/25.
//

import SwiftUI

// MARK: 오버레이 뷰들을 관리
@Observable
final class AppWideOverlayStore {
    var window: UIWindow?
    var views: [OverlayView] = []
    
    struct OverlayView: Identifiable {
        var id: String = UUID().uuidString
        var view: AnyView
    }
}
