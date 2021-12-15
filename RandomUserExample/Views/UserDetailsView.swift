//
//  UserDetailsView.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import SwiftUI

struct UserDetailsView: View {
    @State private var showImagePreview = false

    let user: UserModel

    var body: some View {
        List {
            Section {
                AsyncImage(url: user.picture.large) { image in
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } placeholder: {
                    ProgressView()
                }
                    .padding(5)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        showImagePreview = true
                    }
                    .popover(isPresented: $showImagePreview) {
                        ZStack {
                            Color.black
                                .ignoresSafeArea()

                            AsyncImage(url: user.picture.large) { image in
                                image
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .onTapGesture {
                            showImagePreview = false
                        }
                    }

                Text(user.name.fullName)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 15)
                    .listRowSeparator(.visible)

                HStack {
                    Text("gender")
                        .bold()
                    Text(user.gender.rawValue.capitalized)
                }.listRowSeparator(.hidden)

                HStack {
                    Text("dob")
                        .bold()
                    Text(user.dob.formattedDate)
                }.listRowSeparator(.hidden)

                HStack {
                    Text("age")
                        .bold()
                    Text(user.dob.age.description)
                }.listRowSeparator(.hidden)

                HStack {
                    Text("email")
                        .bold()
                    Text(user.email)
                }.listRowSeparator(.hidden)

                HStack {
                    Text("phone")
                        .bold()
                    Text(user.phone)
                }.listRowSeparator(.hidden)
            }

            if !user.id.name.isEmpty || user.id.value != nil {
                Section {
                    Text("id")
                        .font(.title)
                        .listRowSeparator(.visible)
                    if !user.id.name.isEmpty {
                        HStack {
                            Text("name")
                                .bold()
                            Text(user.id.name)
                        }.listRowSeparator(.hidden)
                    }
                    if let value = user.id.value {
                        HStack {
                            Text("value")
                                .bold()
                            Text(value)
                        }.listRowSeparator(.hidden)
                    }
                }
            }

        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
