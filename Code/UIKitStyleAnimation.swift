//
//  UIKitStyleAnimation.swift
//  Grid.Demo
//
//  Created by mikun on 2019/9/10.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

#if os(iOS)
import UIKit
public struct UIKitStyleAnimation<Base, Result>: ViewModifier where Base: View, Result: View {
	public typealias BodyType = (_ view: Base, _ isInitial: Bool) -> Result
	@State var initial = true
	let animation: Animation?
	let base: Base
	let runAnimation: BodyType
	public func body(content: Self.Content) -> some View {
		DispatchQueue.main.async {
			self.initial = false
		}
		return runAnimation(base, initial)
			.animation(animation)
	}
}
#endif
