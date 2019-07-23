//
//  WebImage.swift
//  Grid.Demo
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
final class WebImage: BindableObject {
    let willChange = PassthroughSubject<UIImage, Never>()

	var image: UIImage? {
        willSet {
			if let image = newValue {
				willChange.send(image)
			}
        }
    }
}
