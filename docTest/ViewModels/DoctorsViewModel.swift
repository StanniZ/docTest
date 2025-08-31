//
//  DoctorsVIewModel.swift
//  docTest
//
//  Created by macbook on 29/08/2025.
//
import Foundation

@MainActor
final class DoctorsViewModel: ObservableObject {
    @Published private(set) var doctors: [Doctor] = []
    @Published private(set) var filtered: [Doctor] = []
    
    @Published var sortOption: SortOption = .price { didSet { applyFilters() } }
    @Published var ascending: Bool = true {
        didSet {
            applyFilters()
        }
    }
    
    enum SortOption {
        case price, seniority, rating
    }
    
    private let services: LocalDataService
    
    init (services: LocalDataService) {
        self.services = services
    }
    
    func load() async {
        do {
            let list = try await services.fetchData()
            self.doctors = list
            applyFilters()
        } catch {
            doctors = []
            filtered = []
        }
    }
    
    private func applyFilters() {
        filtered = doctors.sorted { firstDoc, secDoc in
            switch sortOption {
            case .price:
                return ascending ? (firstDoc.minimalPrice ?? .max) < (secDoc.minimalPrice ?? .max)
                                    : (firstDoc.minimalPrice ?? .min) > (secDoc.minimalPrice ?? .min)
            case .seniority:
                return ascending ? firstDoc.seniority < secDoc.seniority
                                    : firstDoc.seniority > secDoc.seniority
            case .rating:
                return ascending ? firstDoc.ratingValue > secDoc.ratingValue
                                    : firstDoc.ratingValue < secDoc.ratingValue
            }
            
        }
    }
}
