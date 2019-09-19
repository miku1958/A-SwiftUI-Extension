//
//  BlurView.swift
//  SwiftUI.Extension.Demo
//
//  Created by mikun on 2019/9/9.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct BlurView {
	/*0 to 1*/
    fileprivate let level: CGFloat
	fileprivate let _level: Any?
	
	enum Sort {
		case light
		case dark
	}
	fileprivate let sort: Sort
	
	fileprivate var configs: [(ViewType)->()] = []
	
	public init(level: CGFloat, prefer sort: Sort = .light) {
		self._level = nil
		self.level = level
		self.sort = sort
	}
}
#if os(iOS)
extension BlurView: UIViewRepresentable {
	typealias ViewType = UIVisualEffectView
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
        let blurView = UIVisualEffectView()
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {
		uiView.effect = UIBlurEffect(style: self._level as? UIBlurEffect.Style ?? self.style)
    }
	fileprivate static func _styles(sort: Sort) -> [UIBlurEffect.Style] {
		switch sort {
		case .light:
			return [.regular, .systemUltraThinMaterial, .systemThinMaterial, .prominent, .systemMaterial, .systemChromeMaterial, .systemThickMaterial]
		case .dark:
			return [.systemUltraThinMaterial, .systemChromeMaterial, .systemThinMaterial, .regular, .systemMaterial, .prominent, .systemThickMaterial]
		}
	}
	fileprivate var style: UIBlurEffect.Style {
		let styles = Self._styles(sort: sort)
		let index = Int(round(CGFloat(styles.count)) * level)
		return styles[max(0, min(styles.count - 1, index))]
	}
}
@available(iOS 13.0, *)
@available(OSX, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BlurView {
	public init(style: UIBlurEffect.Style) {
		self._level = style
		self.level = 0
		self.sort = .light
	}
}
#elseif os(macOS)
extension BlurView: NSViewRepresentable {
	
	typealias ViewType = NSVisualEffectView
	func makeNSView(context: NSViewRepresentableContext<BlurView>) -> NSVisualEffectView {
		
        let blurView = NSVisualEffectView()
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }

	func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<BlurView>) {
		nsView.material = _level as? NSVisualEffectView.Material ?? style
		configs.forEach { $0(nsView) }
	}
	fileprivate static func _styles(sort: Sort) -> [NSVisualEffectView.Material] {
		switch sort {
			case .light:
				return [.popover, .toolTip, .menu, .sheet, .headerView, .sidebar, .underWindowBackground, .windowBackground, .contentBackground]
			case .dark:
				return [.popover, .toolTip, .menu, .sheet, .headerView, .sidebar, .underWindowBackground, .windowBackground, .contentBackground]
			}
	}
	fileprivate var style: NSVisualEffectView.Material {
		let styles = Self._styles(sort: sort)
		
		let index = Int(round(CGFloat(styles.count)) * level)
		return styles[max(0, min(styles.count - 1, index))]
	}
}
@available(OSX 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BlurView {
	public init(style: NSVisualEffectView.Material) {
		self._level = style
		self.level = 0
		self.sort = .light
	}
	public func blendingMode(_ mode: NSVisualEffectView.BlendingMode) -> Self {
		var view = self
		view.configs.append {
			$0.blendingMode = mode
		}
		return view
	}
}
#endif
