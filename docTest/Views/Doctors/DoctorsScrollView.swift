//
//  DoctorsScrollView.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//
import SwiftUI

struct DoctorsScrollView: View {
    @ObservedObject var viewModel: DoctorsViewModel

    @State private var selectedDoctorId: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TitleBar()

                SearchBar(text: $viewModel.searchText)

                SortSegmentedBar(selected: $viewModel.sortOption,
                                 ascending: $viewModel.ascending)

                DoctorsList(
                    doctors: viewModel.filtered,
                    onOpenDetails: { doc in
                       
                    },
                    onOpenPrice: { id in
                        selectedDoctorId = id
                    }
                )
            }
            .navigationDestination(item: $selectedDoctorId) { id in
                if let doc = viewModel.filtered.first(where: { $0.id == id }) {
                    PriceView(doctor: doc).tint(.maincolor)
                } else {
                    NotFoundView()
                }
            }
            .background(Color.gray.opacity(0.1))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task { await viewModel.load() }
        }
    }
}

private struct TitleBar: View {
    var body: some View {
        Text("Доктора")
            .font(.system(size: 26, weight: .regular))
            .padding(.vertical, 16)
    }
}

private struct DoctorsList: View {
    let doctors: [Doctor]
    var onOpenDetails: (Doctor) -> Void
    var onOpenPrice: (String) -> Void
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(doctors) { doctor in
                    DoctorRow(doctor: doctor, onOpenPrice: onOpenPrice)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

private struct DoctorRow: View {
    let doctor: Doctor
    var onOpenPrice: (String) -> Void

    var body: some View {
        NavigationLink {
            DoctorView(doctor: doctor).tint(.maincolor)
        } label: {
            DoctorCardView(
                doctor: doctor,
                onButtonTap: { id in
                    onOpenPrice(id)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
            )
        }
        .buttonStyle(.plain)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray.opacity(0.6))

            TextField("Поиск", text: $text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.primary)
                .textFieldStyle(.plain)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.default)
        }
        .padding(9)
        .background(.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
        )
        .padding(.horizontal)
    }
}

private struct NotFoundView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
            Text("Доктор не найден")
        }
        .foregroundStyle(.secondary)
        .padding()
    }
}
