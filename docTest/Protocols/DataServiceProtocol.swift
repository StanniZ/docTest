//
//  DataService.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//
import Foundation

protocol DataService {
    func fetchData() async throws -> [Doctor]
}
