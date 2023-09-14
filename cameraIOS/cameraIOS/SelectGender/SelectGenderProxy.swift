//
//  SelectGenderProxy.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 09.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared


class SelectGenderProxy: ObservableObject {
    
    func selectGender(_ gender: String) {
        let isMale = gender == "male"
        IOSStorage().writeGender(isMale: isMale)
        print("My gender is: \(IOSStorage().readGender())")
    }
}
