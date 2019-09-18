//
//  GridSection.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI
#if os(iOS)
protocol GridSectionProtocol {
	var header: AnyView? { get }
	var contents: [AnyView] { get }
	var footer: AnyView? { get }
}
public struct GridSection<Parent, Content, Footer> : View where Parent : View, Content : View, Footer : View {
	private let _header: Parent
	private let _content: Content
	private let _footer: Footer
	
	public var body: Never {
		fatalError()
	}
	public init(header: Parent, footer: Footer, @ViewBuilder content: () -> Content) {
		self._header = header
		self._content = content()
		self._footer = footer
	}
	
	/// The type of view representing the body of this view.
	///
	/// When you create a custom view, Swift infers this type from your
	/// implementation of the required `body` property.
	public typealias Body = Never
}
extension GridSection: GridSectionProtocol {
	var header: AnyView? {
		if _header is EmptyView {
			return nil
		}
		return AnyView(_header)
	}
	
	var contents: [AnyView] {
		return expand()
	}
	
	var footer: AnyView? {
		if _footer is EmptyView {
			return nil
		}
		return AnyView(_footer)
	}
}

extension GridSection : ViewExpand {
	func topExpand() -> [AnyView] {
		if let con = _content as? ViewExpand {
			return con.expand()
		}
		return [AnyView(_content)]
	}
	func expand() -> [AnyView] {
		var waitList = topExpand()
		let combineList = waitList.compactMap { $0.stroage.value as? ViewExpand }

		waitList = waitList.filter { !($0.stroage.value is ViewExpand) }
		for combine in combineList {
			if let section = combine as? GridSectionProtocol, let header = section.header {
				waitList.append(header)
			}
			waitList.append(contentsOf: combine.expand())
			if let section = combine as? GridSectionProtocol, let footer = section.footer {
				waitList.append(footer)
			}
		}
		return waitList
	}
}
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension GridSection where Parent == EmptyView {
	
	public init(footer: Footer, @ViewBuilder content: () -> Content) {
		self._header = EmptyView()
		self._content = content()
		self._footer = footer
	}
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension GridSection where Footer == EmptyView {
	
	public init(header: Parent, @ViewBuilder content: () -> Content) {
		self._header = header
		self._content = content()
		self._footer = EmptyView()
	}
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension GridSection where Parent == EmptyView, Footer == EmptyView {
	
	public init(@ViewBuilder content: () -> Content) {
		self._header = EmptyView()
		self._content = content()
		self._footer = EmptyView()
	}
}

#endif
