//
//  LocalDataService.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//
import Foundation

final class LocalDataService: DataService {
    
    func fetchData() async throws -> [Doctor] {
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json")
        else { throw URLError(.fileDoesNotExist) }
        let database = try Data(contentsOf: url)
        let root = try JSONDecoder().decode(DoctorsData.self, from: database)
        return root.database.users
    }
}
