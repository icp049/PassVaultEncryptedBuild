//
//  BackButton.swift
//  PassVault
//
//  Created by Ian Pedeglorio on 2023-12-04.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .background(Color.clear)
        }
    }
}

