//
//  DoctorsCard.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//
import Foundation

struct DoctorsData: Decodable {
    let count: Int
    let message: String?
    let database: DataUsers
    
    struct DataUsers: Decodable {
        let users: [Doctor]
    }
}
