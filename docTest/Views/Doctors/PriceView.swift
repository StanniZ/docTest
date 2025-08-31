//
//  PriceView.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//

import SwiftUI

struct PriceView: View {
    @Environment(\.dismiss) private var dismiss
    let doctor: Doctor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            allPrices
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Стоимость услуг")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.maincolor)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
    }
    
    private var allPrices: some View {
        VStack(alignment: .leading, spacing: 26) {
            prices(title: "Видеоконсультация", time: "30 мин", price: String(doctor.videoChatPrice))
            prices(title: "Чат с врачом", time: "30 мин", price: String(doctor.textChatPrice))
            prices(title: "Прием в клинике", time: "В клиннике", price: String(doctor.hospitalPrice))
        }
    }
    
    private func prices(title: String, time: String, price: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
            HStack{
                Text(time)
                    .font(.system(size: 18, weight: .regular))
                Spacer()
                Text("\(price) ₽")
                    .font(.system(size: 18, weight: .medium))
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
            )
        }
    }
}
