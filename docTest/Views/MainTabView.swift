//
//  MainTabView.swift
//  docTest
//
//  Created by macbook on 30/08/2025.
//
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var vm: DoctorsViewModel
    @State private var selection = 0
    private let tabBarHeight: CGFloat = 60
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .safeAreaPadding(.bottom, tabBarHeight)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            tabItems

        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch selection {
        case 0:
            DoctorsScrollView(viewModel: vm)
            case 1:
            Reception()
            case 2:
            ChatView()
        case 3:
            ProfileView()
        default:
            DoctorsScrollView(viewModel: vm)
        }
    }
    
    private var tabItems: some View {
        HStack(spacing: 40) {
            TabItem(index: 0, title: "Главная", systemImage: "house")
            TabItem(index: 1, title: "Приемы", systemImage: "list.bullet.rectangle.fill")
            TabItem(index: 2, title: "Чат", systemImage: "bubble.left.and.text.bubble.right.fill.rtl")
            TabItem(index: 3, title: "Профиль", systemImage: "person.fill")
        }
        .padding(.top, 16)
        .frame(height: tabBarHeight)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 0.5),
            alignment: .top
        )
    }
    
    private func TabItem(index: Int, title: String, systemImage: String) -> some View {
        Button(action: {
            selection = index
        }) {
            VStack(spacing: 3){
                Image(systemName: systemImage)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(selection == index ? Color.maincolor : Color.gray)
                Text(title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray)
            }
        }
    }
}
