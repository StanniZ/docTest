//
//  Doctor.swift
//  docTest
//
//  Created by macbook on 29/08/2025.
//
import Foundation

struct Doctor: Identifiable, Decodable {
    let id: String
    let doctorPhoto: String?
    let firstName: String
    let patronymic: String?
    let lastName: String
    let ratingValue: Double
    let specialization: [Specialization]
    let seniority: Int
    let textChatPrice: Int
    let videoChatPrice: Int
    let hospitalPrice: Int
    let educationTypeLabel: Education?
    let categoryLabel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case doctorPhoto = "avatar"
        case firstName = "first_name"
        case patronymic
        case lastName = "last_name"
        case ratingValue = "ratings_rating"
        case seniority
        case specialization
        case textChatPrice = "text_chat_price"
        case videoChatPrice = "video_chat_price"
        case hospitalPrice = "hospital_price"
        case educationTypeLabel
        case categoryLabel = "category_label"
    }
    
    var fullName: String {
        [firstName, patronymic].compactMap { $0 }.joined(separator: " ")
    }
    
    var minimalPrice: Int? {
        let prices = [textChatPrice, videoChatPrice, hospitalPrice].filter { $0 > 0 }
        return prices.min()
    }
    
    var education: String {
        if educationTypeLabel == nil {
            return ""
        } else {
            let educ =  educationTypeLabel.map { $0.name }
            if let educ {
                return educ
            } else {
                return ""
            }
        }
    }
    
    var experience: String {
        let specs = specialization.map { $0.name }.joined(separator: ", ")
        let exp = "Стаж \(seniority) лет"
        
        if specs.isEmpty {
            return exp
        } else {
            return "\(specs), \(exp)"
        }
    }
    
    var experienceDoc: String {
        let specs = specialization.map { $0.name }.joined(separator: ", ")
        let exp = "Опыт работы:  \(seniority) лет"
        
        if specs.isEmpty {
            return exp
        } else {
            return "\(specs), \(exp)"
        }
    }
}
