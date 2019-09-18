//
//  View.swift
//  Grid.Demo
//
//  Created by mikun on 2019/9/5.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
	var screenSize: CGSize {
		#if os(iOS)
		return UIScreen.main.bounds.size
		#elseif os(macOS)
		return NSScreen.main?.frame.size ?? .zero
		#endif
	}
}

extension View {
	/// add a border like beta1
	public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
		overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
	}
}

extension View {
	/// according to flag, choose true or false to config the View
	public func consideConfig<True, False>(_ flag: Bool, true trueS: (Self)->True, false falseS: (Self)->False) -> some View where True: View, False: View {
		Group {
			if flag {
				trueS(self)
			} else {
				falseS(self)
			}
		}
	}
	/// according to flag, if true, choose true to config the View, else return self
	public func considerConfig<True>(_ flag: Bool, true trueS: (Self)->True) -> some View where True: View {
		Group {
			if flag {
				trueS(self)
			} else {
				self
			}
		}
	}
	/// according to flag, choose true or false to config the ViewModifier
	public func considerModifier<M1, M2>(_ flag: Bool, true trueModifier: M1, false falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
		Group {
			if flag {
				self.modifier(trueModifier)
			} else {
				self.modifier(falseModifier)
			}
		}
	}
	
	/// according to flag, if true, choose true to config the ViewModifier, else return self
	public func considerModifier<M1>(_ flag: Bool, true trueModifier: M1) -> some View where M1: ViewModifier {
		Group {
			if flag {
				self.modifier(trueModifier)
			} else {
				self
			}
		}
	}
}

extension View {
	//TODO:	extension coverScreen more like present in UIKit
	
	///cover some View in fullScreen and Intercept all touch event like ' fullscreen modal presentation' in UIKit
	public func coverScreen<Cover>(_ isActive: Bool, alignment: Alignment = .center, backgroundColor: Color = .clear, @ViewBuilder _ content: @escaping ()-> Cover) -> some View where Cover : View {
		overlay(
			ZStack {
				if isActive {
					GeometryReader { proxy in
						content()
							.background(
							backgroundColor
								.frame(width: self.screenSize.width, height: self.screenSize.height))
							.offset(proxy.centerOffset)
					}.onTapGesture {
						
					}
					.onLongPressGesture {
						
					}.frame(width: screenSize.width, height: screenSize.height)
				}
			}
			
		)
	}
}

// Animation
#if os(iOS)
extension View {
	public func doAnimation<Result>(_ animation: Animation? = .default, _ body: @escaping UIKitStyleAnimation<Self, Result>.BodyType) -> some View where Result: View {
		modifier(UIKitStyleAnimation(animation: animation, base: self, runAnimation: body))
	}
}
#endif

extension View {
	/// put the view to HStack/VStack 's center
	public func centered() -> some View {
		Group {
			Spacer()
			self
			Spacer()
		}
	}
}


extension View {
	/// Creates an instance that presents `destination`.
	public func push<Destination>(_ destination: @escaping @autoclosure ()->Destination) -> some View where Destination: View {
		NavigationLink(destination: LazyView(destination: destination)) {
			self
		}
	}
	/// Creates an instance that presents `destination` when active.
	public func push<Destination>(destination: @escaping @autoclosure ()->Destination, isActive: Binding<Bool>) -> some View where Destination: View {
		NavigationLink(destination: LazyView(destination: destination), isActive: isActive) {
			self
		}
	}
	
	/// Creates an instance that presents `destination` when `selection` is set
	/// to `tag`.
	public func push<Destination, V>(destination: @escaping @autoclosure ()->Destination, tag: V, selection: Binding<V?>) -> some View  where V : Hashable, Destination: View {
		NavigationLink(destination: LazyView(destination: destination), tag: tag, selection: selection) {
			self
		}
	}
	
	///not working in iOS13.1
	func push<Selection, Destination: View>(selection: Binding<Selection?>, @ViewBuilder destination: @escaping (Selection) -> Destination
    ) -> some View {
//        modifier(SelectionNavigationModifier(selection: selection, destination: destination))
		
		return ZStack {
			NavigationLink(destination: LazyView(destination: {
				destination(selection.wrappedValue!)
			}), isActive: Binding(get: {
				return selection.wrappedValue != nil
			}, set: { newValue in
				if !newValue {
					selection.wrappedValue = nil
				}
			})) {
				EmptyView().frame(width: 0, height: 0)
			}
			
			self
		}
    }
}

/*planing
https://github.com/SwiftUIX/SwiftUIX/blob/master/Sources/Intramodular/Navigation/SelectionNavigator.swift

*/

#if os(iOS)
extension View {
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
	public func navigationBar<Bar>(@ViewBuilder customBar: @escaping ()->Bar) -> some View where Bar : View {
		func layout<V>(_ view: V, toNavigationBar proxy: GeometryProxy) -> some View where V: View {
			let frame = proxy.frame(in: .global)
			let width = frame.width - 8 + frame.origin.x * 2
			let height = frame.height + frame.origin.y * 2
			let heightReduce = UIApplication.shared.connectedScenes.compactMap( { $0.delegate as? UIWindowSceneDelegate}).first?.window??.safeAreaInsets.top ?? 0
			return view
				.frame(width: width, height: height - heightReduce)
				.offset(x: -4, y: -heightReduce/2)
		}
		return navigationBarItems(leading:
			GeometryReader { proxy in
				layout(customBar(), toNavigationBar: proxy)
			}
			.frame(width: 2000, height: 2000)
			.navigationBarTitle("", displayMode: .inline)
		)
	}
}
#endif
