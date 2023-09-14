//
//  ProgressView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 05.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct ProgressView: View {
    @StateObject var proxy = ProgressViewProxy()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                CircularProgressView(progress: proxy.progress)
                VStack(alignment: .center) {
                    Text("\(proxy.time) min")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Remaining time")
                        .foregroundColor(Color.gray)
                        .font(.title2)
                        .fontWeight(.medium)
                }
            }
            .frame(width: 288, height: 288)
            
            Text("When it’s finished, you’ll get images generated for you. Feel free to close the app.")
                .foregroundColor(Color.white)
                .fontWeight(.medium)
                .padding(.top, 48)
                .padding(.horizontal, 16)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                IOSStorage().writeModelStatus(status: .trained)
            }, label: {
                Text("Notify Me When It's Done")
                    .frame(maxWidth: .infinity, minHeight: 56)
            })
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(8)
            .padding(.bottom, 36)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 48)
        .background(Color.black.ignoresSafeArea(.all))
        .onAppear {
            proxy.startPollingModelStatus()
        }
        .onDisappear {
            proxy.stopPollingModelStatus()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                proxy.startPollingModelStatus()
            }
            else {
                proxy.stopPollingModelStatus()
            }
        }
    }
}

struct CircularProgressView: View {
    let progress: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(red: 32 / 255.0, green: 31 / 255.0, blue: 34 / 255.0),
                    lineWidth: 20
                )
            Circle()
                .trim(from: 0, to: CGFloat(progress) / 100.0)
                .stroke(
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

