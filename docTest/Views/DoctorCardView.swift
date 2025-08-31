//
//  DoctorCardView.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//
import SwiftUI

struct DoctorCardView: View {
    let doctor: Doctor
    var onButtonTap: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 16) {
                    doctorPhoto
                VStack(alignment: .leading, spacing: 8) {
                    doctorInfo
                    RatingView(rating: doctor.ratingValue)
                    experience
                    priceDoctor
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            button
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        
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
            .foregroundStyle(.gray.opacity(0.5))
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
    
    private var experience: some View {
        Text(doctor.experience)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.gray)
    }
    
    private var priceDoctor: some View {
        VStack {
            if let price = doctor.minimalPrice {
                Text("от \(price) ₽")
            } else {
                Text("Цены не указаны")
            }
        }
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(.black)
        .padding(.vertical, 8)
    }
    
    private var button: some View {
        Button(action: {
            onButtonTap?(doctor.id)
        }) {
            SignUpButton()
        }
    }

}

struct RatingView: View {
    let rating: Double
    let maxRating = 5
    
    var body: some View {
        HStack (spacing: 4){
            ForEach(1...maxRating, id: \.self) { index in
                if rating >= Double(index) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.maincolor)
                } else if rating + 0.5 >= Double(index) {
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundStyle(.maincolor)
                } else {
                    Image(systemName: "star")
                        .foregroundStyle(.maincolor)
                }
            }
        }
        .font(.system(size: 10))
    }
}
