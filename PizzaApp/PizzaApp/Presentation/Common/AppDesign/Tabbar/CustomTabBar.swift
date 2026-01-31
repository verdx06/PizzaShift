//
//  CustomTabBar.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import SwiftUI

struct CustomTabView<Content: View>: View
{
    @Binding var selection: MainTab
    var content: (MainTab) -> Content

    init(
        selection: Binding<MainTab>,
        @ViewBuilder content: @escaping (MainTab) -> Content
    ) {
        self._selection = selection
        self.content = content
        Self.configureSystemTabBarAppearance()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(MainTab.allCases, id: \.self) { tab in
                    content(tab)
                        .tag(tab)
                }
            }
            VStack(spacing: 0) {
                Divider()
                CustomTabbar(activeTab: $selection)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

private extension CustomTabView {
    static func configureSystemTabBarAppearance() {
        let tabBar = UITabBar.appearance()
        tabBar.isHidden = true
    }
}

private struct CustomTabbar: View
{
    @Binding var activeTab: MainTab
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                let isActive = activeTab == tab
                VStack {
                    Image(isActive ? tab.activeIcon : tab.icon)
                    Text(tab.title)
                        .font(.system(size: 12))
                        .foregroundColor(isActive ? Color("brandColor") : .gray)
                }
                .onTapGesture {
                    activeTab = tab
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)

            }
        }.background(
            ZStack{
                Rectangle()
                    .fill(.white)
                    .edgesIgnoringSafeArea(.all)
            }
        )
    }
}
