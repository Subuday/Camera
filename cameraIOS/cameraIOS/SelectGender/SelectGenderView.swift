//
//  SelectGender.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 09.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SelectGenderView: View {
    
    @StateObject var proxy = SelectGenderProxy()
        
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                let genders = ["Female", "Male"]
                ForEach(genders, id: \.self) { gender in
                    HStack {
                        Text(gender)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Spacer()
                        ZStack {
                            Image("\(gender.lowercased())_photo_1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0), lineWidth: 2)
                                )
                            
                            Image("\(gender.lowercased())_photo_2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0), lineWidth: 2)
                                )
                                .offset(x: -36)
                            
                            Image("\(gender.lowercased())_photo_3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0), lineWidth: 2)
                                )
                                .offset(x: -72)
                        }
                    }
                    .frame(maxWidth: .infinity, idealHeight: 96, alignment: .leading)
                    .padding(.horizontal, 16)
                    .background(Color(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0))
                    .cornerRadius(16)
                    .padding(.top, 16)
                    .padding(.bottom, 0)
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        proxy.selectGender(gender.lowercased())
                        Router.shared.showSelectStyle()
                    }
                }
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea(.all))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select your type")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

struct SelectGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenderView()
    }
}

