//
//  Utils.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 14.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension Int32 {
    func toInt() -> Int {
        return Int(self)
    }
}

extension KotlinByteArray {
    static func from(data: Data) -> KotlinByteArray {
        let byteArray = data.map { Int8(bitPattern: $0) }
        let result = KotlinByteArray(size: Int32(byteArray.count))
        for (index, byte) in byteArray.enumerated() {
            result.set(index: Int32(index), value: byte)
        }
        return result
    }
}

extension KotlinInt {
    func toInt() -> Int {
        return intValue
    }
}
