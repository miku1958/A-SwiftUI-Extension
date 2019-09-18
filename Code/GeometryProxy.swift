//
//  GeometryProxy.swift
//  Grid.Demo
//
//  Created by mikun on 2019/9/9.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

extension GeometryProxy {
	var centerOffset: CGSize {
		let frame = self.frame(in: .global)

		#if os(iOS)
		let winSize = UIScreen.main.bounds.size
		#elseif os(macOS)
		//FIXME:    mac的Screen是指屏幕还是指app当前尺寸?
		let winSize = NSScreen.main?.frame.size ?? .zero
		#endif
		
		let width = (winSize.width - frame.width) / 2 - frame.origin.x
		let height = (winSize.height - frame.height) / 2 - frame.origin.y
		
		// 因为 旋转屏幕后这样做会导致出现间隙所以去掉了
//		if width != CGFloat(Int(width)), CGFloat(Int(width)) - width < 1 / UIScreen.main.scale {
//			width = CGFloat(Int(width)) - 1 / UIScreen.main.scale
//		}
//		if height != CGFloat(Int(height)), CGFloat(Int(height)) - height < 1 / UIScreen.main.scale {
//			height = CGFloat(Int(height)) - 1 / UIScreen.main.scale
//		}
		return CGSize(width: width, height: height)
	}
}
