//
//  PreviewDevice.swift
//  swiftUITest
//
//  Created by mikun on 2019/8/10.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

extension PreviewDevice {
	
	static let Mac = PreviewDevice(rawValue: "Mac")
	static let iPhone7 = PreviewDevice(rawValue:  "iPhone 7")
	static let iPhone7Plus = PreviewDevice(rawValue: "iPhone 7 Plus")
	static let iPhone8 = PreviewDevice(rawValue: "iPhone 8")
	static let iPhone8Plus = PreviewDevice(rawValue: "iPhone 8 Plus")
	static let iPhoneSE = PreviewDevice(rawValue: "iPhone SE")
	static let iPhoneX = PreviewDevice(rawValue: "iPhone X")
	static let iPhoneXs = PreviewDevice(rawValue: "iPhone Xs")
	static let iPhoneXsMax = PreviewDevice(rawValue: "iPhone Xs Max")
	static let iPhoneXR = PreviewDevice(rawValue: "iPhone Xʀ")
	static let iPhone11 = PreviewDevice(rawValue: "iPhone 11")
	static let iPhone11Pro = PreviewDevice(rawValue: "iPhone 11 Pro")
	static let iPhone11ProMax = PreviewDevice(rawValue: "iPhone 11 Pro Max")
	
	static let iPadmini4 = PreviewDevice(rawValue: "iPad mini 4")
	static let iPadAir2 = PreviewDevice(rawValue: "iPad Air 2")
	static let iPadPro9_7 = PreviewDevice(rawValue: "iPad Pro (9.7-inch)")
	static let iPadPro12_9 = PreviewDevice(rawValue: "iPad Pro (12.9-inch)")
	static let iPad5 = PreviewDevice(rawValue: "iPad (5th generation)")
	static let iPad6 = PreviewDevice(rawValue: "iPad (6th generation)")
//	static let iPad7 = PreviewDevice(rawValue: "iPad (7th generation)") 10.2inch iPad is not this name
	static let iPadPro12_9_2nd = PreviewDevice(rawValue: "iPad Pro (12.9-inch) (2nd generation)")
	static let iPadPro10_5 = PreviewDevice(rawValue: "iPad Pro (10.5-inch)")
	static let iPadPro11 = PreviewDevice(rawValue: "iPad Pro (11-inch)")
	static let iPadPro12_9_3nd = PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)")
	static let iPadmini5 = PreviewDevice(rawValue: "iPad mini (5th generation)")
	static let iPadAir3 = PreviewDevice(rawValue: "iPad Air (3rd generation)")
	
	static let AppleTV = PreviewDevice(rawValue: "Apple TV")
	static let AppleTV4K = PreviewDevice(rawValue: "Apple TV 4K")
	static let AppleTV4K_1080p = PreviewDevice(rawValue: "Apple TV 4K (at 1080p)")
	
	static let Watch2_38mm = PreviewDevice(rawValue: "Apple Watch Series 2 - 38mm")
	static let Watch2_42mm = PreviewDevice(rawValue: "Apple Watch Series 2 - 42mm")
	static let Watch3_38mm = PreviewDevice(rawValue: "Apple Watch Series 3 - 38mm")
	static let Watch3_42mm = PreviewDevice(rawValue: "Apple Watch Series 3 - 42mm")
	static let Watch4_40mm = PreviewDevice(rawValue: "Apple Watch Series 4 - 40mm")
	static let Watch4_44mm = PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm")
	static let Watch5_40mm = PreviewDevice(rawValue: "Apple Watch Series 5 - 40mm")
	static let Watch5_44mm = PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm")
	
	
	static let iPhone_640x1136 = iPhoneSE
	static let iPhone_750x1334 = iPhone7
	static let iPhone_1242x2208 = iPhone7Plus
	static let iPhone_828x1792 = iPhoneXR
	static let iPhone_1125x2436 = iPhoneX
	static let iPhone_1242x2688 = iPhoneXsMax
	
	static let iPad_2048x1536 = iPadmini4
	static let iPad_2224x1668 = iPadPro9_7
	static let iPad_2388x1668 = iPadPro11
	static let iPad_2732x2048 = iPadPro12_9
//	static let iPad_2160x1620 = iPad7
	
	static let Watch_38 = Watch2_38mm
	static let Watch_40 = Watch4_40mm
	static let Watch_42 = Watch2_42mm
	static let Watch_44 = Watch4_44mm
}
