//
//  CheckoutView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 12.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @StateObject private var proxy: CheckoutViewProxy
    
    init(styleId: String) {
        self._proxy = StateObject(wrappedValue: CheckoutViewProxy(styleId: styleId))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Why is it paid?")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                    
                    Text("Magic Avatars consumes tremendous computation power to create amazing headshots for you, it's expensive, but we made it as affordable as possible. ❤️")
                        .foregroundColor(Color.gray)
                        .font(.headline)
                        .fontWeight(.regular)
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                    
                    EnumeratedForEach(proxy.packages) { index, package in
                        PackageView(package: package)
                            .padding(.top, index == 0 ? 56 : 16)
                            .onTapGesture { proxy.selectPackage(index: index) }
                    }
                    
                    Text("🚀 Get up to 60% off with Subscription")
                        .foregroundColor(Color.white)
                        .fontWeight(.medium)
                        .underline()
                        .padding(.top, 64)
                    
                    Text("See plans")
                        .foregroundColor(Color.blue)
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal, 16)
            Spacer()
            Button(
                action: {
                    proxy.purchase()
                },
                label: {
                    Text("Purchase for 6,99 US$")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                }
            )
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.ignoresSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Check out")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

struct PackageView: View {
    
    var package: PackageViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 12) {
                ZStack(alignment: .center) {
                    if package.isSelected {
                        Image("ic_circle_ok_blue")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                    else {
                        Circle()
                            .strokeBorder(Color.gray, lineWidth: 2)
                            .frame(width: 24, height: 24)
                    }
                }
                .frame(minWidth: 28, minHeight: 28)
                VStack(alignment: .leading, spacing: 4) {
                    Text(package.title)
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(package.subtitle)
                        .foregroundColor(Color.gray)
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                Spacer()
                Text(package.price)
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
            .background(Color(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0))
            .cornerRadius(16)
            
            if package.isPopular {
                Text("MOST POPULAR")
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .cornerRadius(4)
                    .offset(x: -16, y: -12)
            }
        }
    }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(styleId: "")
    }
}
