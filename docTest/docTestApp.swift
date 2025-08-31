//
//  docTestApp.swift
//  docTest
//
//  Created by macbook on 28/08/2025.
//

import SwiftUI

@main
struct docTestApp: App {
    @StateObject private var vm = DoctorsViewModel(services: LocalDataService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
