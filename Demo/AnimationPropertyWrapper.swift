//
//  AnimationPropertyWrapper.swift
//  Grid.Demo
//
//  Created by mikun on 2019/9/19.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

extension State {
	public func animation(_ value: Value) {
		withAnimation {
			self.wrappedValue = value
		}
	}
}
extension Binding {
	public func animation(_ value: Value) {
		withAnimation {
			self.wrappedValue = value
		}
	}
}

extension ObservedObject {
	public mutating func animation(_ value: ObjectType) {
		withAnimation {
			self.wrappedValue = value
		}
	}
}
