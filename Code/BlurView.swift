//
//  BlurView.swift
//  SwiftUI.Extension.Demo
//
//  Created by mikun on 2019/9/9.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI
#if os(iOS)
struct BlurView: UIViewRepresentable {
	/*0 to 1*/
    let level: CGFloat
	enum Sort {
		case light
		case dark
	}
	let sort: Sort
	init(level: CGFloat, prefer sort: Sort = .light) {
		self.level = level
		self.sort = sort
	}

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
		let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {
		uiView.effect = UIBlurEffect(style: style)
    }
}
extension BlurView {
	fileprivate var style: UIBlurEffect.Style {
		var styles: [UIBlurEffect.Style]
		switch sort {
		case .light:
			styles = [.regular, .systemUltraThinMaterial, .systemThinMaterial, .systemMaterial, .prominent, .systemChromeMaterial, .systemThickMaterial]
		case .dark:
			styles = [.systemUltraThinMaterial, .systemThinMaterial, .systemMaterial, .systemThickMaterial, .systemChromeMaterial, .regular, .prominent]
		}
		
		let index = Int(round(CGFloat(styles.count)) * level)
		return styles[max(0, min(styles.count - 1, index))]
	}
}
#elseif os(macOS)
@available(OSX 10.15, *)
struct BlurView: NSViewRepresentable {
	/*0 to 1*/
    let level: CGFloat
	enum Sort {
		case light
		case dark
	}
	let sort: Sort
	init(level: CGFloat, prefer sort: Sort = .light) {
		self.level = level
		self.sort = sort
	}

	func makeNSView(context: NSViewRepresentableContext<BlurView>) -> NSVisualEffectView {
		
        let blurView = NSVisualEffectView()
        blurView.translatesAutoresizingMaskIntoConstraints = false
		blurView.material = style
		blurView.blendingMode = .withinWindow
        return blurView
    }

	func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<BlurView>) {
		nsView.material = style
	}
}
extension BlurView {
	fileprivate var style: NSVisualEffectView.Material {
		var styles: [NSVisualEffectView.Material]
		switch sort {
		case .light:
			styles = [.popover, .toolTip, .menu, .sheet, .headerView, .sidebar, .underWindowBackground, .windowBackground, .contentBackground]
		case .dark:
			styles = [.popover, .toolTip, .menu, .sheet, .headerView, .sidebar, .underWindowBackground, .windowBackground, .contentBackground]
		}
		let index = Int(round(CGFloat(styles.count)) * level)
		return styles[max(0, min(styles.count - 1, index))]
	}
}
#endif
