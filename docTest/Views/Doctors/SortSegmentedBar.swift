//
//  SortSegmentedBar.swift
//  docTest
//
//  Created by macbook on 31/08/2025.
//
import SwiftUI

struct SortSegmentedBar: View {
    @Binding var selected: DoctorsViewModel.SortOption
    @Binding var ascending: Bool

    private let items: [DoctorsViewModel.SortOption] = [.price, .seniority, .rating]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                segment(for: item)
                    .overlay(separator(show: index < items.count - 1), alignment: .trailing)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
        )
        .tint(.maincolor)
        .padding(.horizontal, 16)
    }

    private func segment(for item: DoctorsViewModel.SortOption) -> some View {
        let isSelected = (item == selected)

        return Button {
            if isSelected { ascending.toggle() }
            else { selected = item; ascending = true }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            HStack(spacing: 6) {
                Text(item.title)
                    .font(.system(size: 16, weight: .regular))
                if isSelected {
                    Image(systemName: ascending ? "arrow.up" : "arrow.down")
                        .font(.system(size: 12, weight: .regular))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 9)
            .background(isSelected ? Color.maincolor : Color.white)
            .foregroundStyle(isSelected ? Color.white : Color.black.opacity(0.6))
            .contentShape(Rectangle())
        }
    }

    private func separator(show: Bool) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: show ? 0.5 : 0)
    }
}

extension DoctorsViewModel.SortOption {
    var title: String {
        switch self {
        case .price:     return "По цене"
        case .seniority: return "По стажу"
        case .rating:    return "По рейтингу"
        }
    }
}
