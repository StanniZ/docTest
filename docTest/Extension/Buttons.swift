//
//  Buttons.swift
//  docTest
//
//  Created by macbook on 30/08/2025.
//
import SwiftUI

struct SignUpButton: View {
    var body: some View {
        Text("Записаться")
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.maincolor)
            .cornerRadius(10)
    }

}
