//
//  AnyView.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI
protocol AnyViewStorageProtocol {
	var anyView: SwiftUI.AnyView { get }
	var value: Any { get }
}
struct AnyViewStorage<Content>: AnyViewStorageProtocol where Content: View {
	let content: Content
	var anyView: SwiftUI.AnyView {
		return SwiftUI.AnyView(content)
	}
	var value: Any {
		return content
	}
}
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AnyView {
	let stroage: AnyViewStorageProtocol
	var needUpdate: Bool = true
	
    /// Create an instance that type-erases `view`.
	public init<V>(_ view: V) where V : View {
		stroage = AnyViewStorage(content: view)
	}
	var anyView: SwiftUI.AnyView? {
		if stroage.value is EmptyView {
			return nil
		}
		return stroage.anyView
	}
}
