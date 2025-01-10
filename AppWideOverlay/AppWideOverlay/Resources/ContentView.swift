//
//  ContentView.swift
//  AppWideOverlay
//
//  Created by 임채윤 on 1/10/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: Presentation Properties
    @State var showSheet: Bool = false
    @State var showFullScreenCover: Bool = false
    
    // MARK: Popup Properties
    @State var showPopup: Bool = false
    
    // MARK: Menu Properties
    @State var showMenu: Bool = false
    @State var isExpended: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button("팝업 메시지") {
                        showPopup.toggle()
                    }
                    .appWideOverlay(isShowing: $showPopup, animation: .snappy) {
                        PopupView(message: "안녕하세요")
                    }
                    
                    Button("메뉴 버튼") {
                        showMenu.toggle()
                    }
                    .appWideOverlay(isShowing: $showMenu) {
                        MenuView()
                    }
                } header: {
                    Text("Overlays")
                }
                
                Section {
                    Button("sheet") {
                        showSheet = true
                    }
                    
                    Button("FullScreenCover") {
                        showFullScreenCover = true
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        Text("Navigation Link")
                    }

                } header: {
                    Text("Presentation")
                }
            }
            .navigationTitle("App Wide Overlay")
            .sheet(isPresented: $showSheet) { Text("sheet") }
            .fullScreenCover(isPresented: $showFullScreenCover) {
                Button("dismiss") {
                    showFullScreenCover = false
                }
            }
        }
    }
    
    @ViewBuilder
    private func PopupView(message: String) -> some View {
        VStack {
            Text(message)
                .foregroundStyle(.white)
                .frame(width: 380, height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.indigo)
                )
                .overlay(alignment: .topLeading) {
                    Button {
                        showPopup = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.ultraThinMaterial)
                            .padding()
                            .contentShape(.rect)
                    }
                }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    
}

struct MenuView: View {
    @Namespace var animation
    @State private var isExpended: Bool = false
    
    var body: some View {
        if isExpended {
            VStack(spacing: 15) {
                MenuItem("pencil.tip.crop.circle")
                
                MenuItem("scribble.variable")
                
                MenuItem("square.and.arrow.up")
                
                MenuItem("plus", isToggleItem: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
            .padding()
            .matchedGeometryEffect(id: "menu", in: animation)
            
        } else {
            VStack {
                MenuItem("xmark", isToggleItem: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
            .padding()
            .matchedGeometryEffect(id: "menu", in: animation)
        }
    }
    
    @ViewBuilder
    func MenuItem(_ imageName: String, isToggleItem: Bool = false) -> some View {
        Image(systemName: imageName)
            .font(.title)
            .foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(
                Circle().fill(isToggleItem ? .green : .blue)
            )
            .onTapGesture {
                if isToggleItem {
                    withAnimation(.snappy(duration: 0.45, extraBounce: 0.2)) {
                        isExpended.toggle()
                    }
                }
            }
    }
}

#Preview {
    RootView {
        ContentView()
    }
}
