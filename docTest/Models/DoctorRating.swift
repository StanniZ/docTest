//
//  Doctorrating.swift
//  docTest
//
//  Created by macbook on 29/08/2025.
//
import Foundation

struct DoctorRating: Decodable, Equatable {
    let id: Int
    let name: String
    let ratingValue: Double
}
