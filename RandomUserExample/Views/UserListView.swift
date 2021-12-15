//
//  UserListView.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import SwiftUI

struct UserListView: View {
    let user: UserModel

    var body: some View {
        HStack {
            AsyncImage(url: user.picture.medium) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(user.gender.color, lineWidth: 2))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)

            VStack(alignment: .leading) {
                Text(user.name.fullName)
                    .bold()
                    .lineLimit(1)

                Text("@\(user.login.username)")
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 5)
    }
}

private extension UserGender {
    var color: Color {
        switch self {
        case .female: return Color.pink
        case .male: return Color.blue
        }
    }
}
