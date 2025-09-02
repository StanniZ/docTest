//
//  DoctorsView.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//
import SwiftUI

struct DoctorView: View {
    @Environment(\.dismiss) private var dismiss
    let doctor: Doctor
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 16) {
                    doctorPhoto
                    doctorInfo
                    Spacer()
                }
                .padding(.vertical, 25)
                experience
                category
                education
                workLocation
                priceDoctor
                aboutDoc
                Spacer()
                button
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.gray.opacity(0.1))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Доктор")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.black)
            }
        }
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
    }
    
    private var title: some View {
        Text("Доктор")
            .font(.system(size: 26, weight: .regular))
    }
    
    private var doctorInfo: some View {
        VStack(alignment: .leading, spacing: 6){
            Text(doctor.lastName)
            if doctor.patronymic != nil {
                Text(doctor.fullName)
            } else {
                Text(doctor.firstName)
            }
        }
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(.black)
    }
    
    private var doctorPhoto: some View {
        Group {
            if let s = doctor.doctorPhoto,
               let encoded = s.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encoded) {
                
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
    
    private var placeholder: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .scaledToFill()
            .foregroundStyle(.gray.opacity(0.3))
    }
    
    private var experience: some View {
        HStack(spacing: 16){
            Image(systemName: "clock")
                .font(.system(size: 20))
            Text(doctor.experienceDoc)
                .font(.system(size: 16, weight: .regular))
        }
        .foregroundColor(.gray)
    }
    
    private var category: some View {
        HStack(spacing: 16){
            Image(systemName: "heart.text.clipboard")
                .font(.system(size: 20))
            Text(doctor.categoryLabel ?? "нет")
                .font(.system(size: 16, weight: .regular))
        }
        .foregroundColor(.gray)
    }
    
    private var education: some View {
        HStack(spacing: 16){
            Image(systemName: "graduationcap")
                .font(.system(size: 18))
            Text(doctor.education)
                .font(.system(size: 16, weight: .regular))
        }
        .foregroundColor(.gray)
    }
    
    private var workLocation: some View {
        HStack(spacing: 16){
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 20))
            Text("Детская клиника \"Ребенок\"")
                .font(.system(size: 16, weight: .regular))
        }
        .foregroundColor(.gray)
    }
    
    private var priceDoctor: some View {
        HStack {
            Text("Стоимость услуг")
                .font(.system(size: 17, weight: .semibold))
            Spacer()
            VStack {
                if let price = doctor.minimalPrice {
                    Text("от \(price) ₽")
                } else {
                    Text("Цены не указаны")
                }
            }
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.black)
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
        .padding(.top, 10)
    }
    
    private var aboutDoc: some View {
        Text("""
    Доктор — это специалист, который занимается диагностикой, лечением и профилактикой заболеваний.  
    Его основные обязанности:  
    • проведение осмотров и постановка диагноза,  
    • назначение и контроль лечения,  
    • консультации пациентов и их родственников,  
    • ведение медицинской документации,  
    • повышение квалификации и изучение новых методов лечения.  
    
    Доктор отвечает не только за здоровье пациента, но и за его доверие, поддерживает в трудных ситуациях и помогает сохранить качество жизни.
    """)
        .font(.system(size: 16, weight: .regular))
        .foregroundStyle(.black)
        .padding(.top, 20)
    }
    
    private var button: some View {
        NavigationLink(destination: PriceView(doctor: doctor)) {
            SignUpButton()
        }
        .padding(.bottom, 80)
    }
}
