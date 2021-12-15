//
//  ErrorView.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import SwiftUI

struct ErrorView: View {
    let reason: String?
    let action: () -> Void

    private var errorText: String {
        reason.flatMap { "server-error-\($0)" }
            ?? "common-error"
    }

    var body: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .renderingMode(.original)
            .font(.system(size: 170))

        Text(errorText)
            .frame(maxWidth: .infinity, alignment: .center)
            .lineLimit(5)
            .padding(.top, 5)
            .padding(.bottom, 25)

        Button {
            action()
        } label: {
            Text("repeat-bt")
                .foregroundColor(Color.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
        }
        .buttonStyle(.bordered)
    }
}
