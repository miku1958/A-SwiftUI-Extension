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
    let style: Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
		let blurEffect = UIBlurEffect(style: style._style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        return blurView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {

    }
}
extension BlurView.Style {
	fileprivate var _style: UIBlurEffect.Style {
		switch self {
		case .regular:
			return .regular
		case .prominent:
			return .prominent
		case .regularDark:
			return .dark
		case .ultraThin:
			return .systemUltraThinMaterial
		case .thin:
			return .systemThinMaterial
		case .material:
			return .systemMaterial
		case .thick:
			return .systemThickMaterial
		case .chrome:
			return .systemChromeMaterial
		case .regularLight:
			return .light
		case .prominentLight:
			return .extraLight
		case .ultraThinLight:
			return .systemUltraThinMaterialLight
		case .thinLight:
			return .systemThinMaterialLight
		case .materialLight:
			return .systemMaterialLight
		case .thicklLight:
			return .systemThickMaterialLight
		case .chromeLight:
			return .systemChromeMaterialLight
		case .ultraThinDark:
			return .systemUltraThinMaterialDark
		case .ThinDark:
			return .systemThinMaterialDark
		case .materialDark:
			return .systemMaterialDark
		case .thicklDark:
			return .systemThickMaterialDark
		case .chromeDark:
			return .systemChromeMaterialDark
		}
	}
}
#elseif os(macOS)
@available(OSX 10.15, *)
struct BlurView: NSViewRepresentable {
    let style: Style

	func makeUIView(context: NSViewRepresentableContext<BlurView>) -> NSView {
		NSVisualEffectView
		let blurEffect = UIBlurEffect(style: style._style)
        let blurView = NSVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {

    }
}
extension BlurView.Style {
	fileprivate var _style: UIBlurEffect.Style {
		switch self {
		case .regular:
			return .regular
		case .prominent:
			return .prominent
		case .regularDark:
			return .dark
		case .ultraThin:
			return .systemUltraThinMaterial
		case .thin:
			return .systemThinMaterial
		case .material:
			return .systemMaterial
		case .thick:
			return .systemThickMaterial
		case .chrome:
			return .systemChromeMaterial
		case .regularLight:
			return .light
		case .prominentLight:
			return .extraLight
		case .ultraThinLight:
			return .systemUltraThinMaterialLight
		case .thinLight:
			return .systemThinMaterialLight
		case .materialLight:
			return .systemMaterialLight
		case .thicklLight:
			return .systemThickMaterialLight
		case .chromeLight:
			return .systemChromeMaterialLight
		case .ultraThinDark:
			return .systemUltraThinMaterialDark
		case .ThinDark:
			return .systemThinMaterialDark
		case .materialDark:
			return .systemMaterialDark
		case .thicklDark:
			return .systemThickMaterialDark
		case .chromeDark:
			return .systemChromeMaterialDark
		}
	}
}
#endif

extension BlurView {
	public enum Style : Int {
		case regular
		
		case prominent
		
        case ultraThin

        case thin

        case material

        case thick

        case chrome
		
		public var light: Style {
			switch self {
			case .regular, .regularLight, .regularDark:
				return .regularLight
				
			case .ultraThin, .ultraThinLight, .ultraThinDark:
				return .ultraThinLight
				
			case .thin, .thinLight, .ThinDark:
				return .thinLight
				
			case .material, .materialLight, .materialDark:
				return .materialLight
				
			case .thick, .thicklLight, .thicklDark:
				return .thicklLight
				
			case .chrome, .chromeLight, .chromeDark:
				return .chromeLight
			case .prominent, .prominentLight:
				return .prominentLight
			}
		}
		public var dark: Style {
			switch self {
			case .regular, .regularLight, .regularDark:
				return .regularDark

			case .prominent, .prominentLight:
				return .regularDark
				
			case .ultraThin, .ultraThinLight, .ultraThinDark:
				return .ultraThinDark
				
			case .thin, .thinLight, .ThinDark:
				return .ThinDark
				
			case .material, .materialLight, .materialDark:
				return .materialDark
				
			case .thick, .thicklLight, .thicklDark:
				return .thicklDark
				
			case .chrome, .chromeLight, .chromeDark:
				return .chromeDark
			}
		}
		
		case regularLight
		
		case prominentLight
		
        case ultraThinLight

        case thinLight

        case materialLight

        case thicklLight

        case chromeLight

        
		case regularDark
		
        case ultraThinDark

        case ThinDark

        case materialDark

        case thicklDark

        case chromeDark
    }
}

