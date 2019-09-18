//
//  ViewExpand.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

#if os(iOS)

protocol ViewExpand {
	func wrap<Content>(_ source: Any) -> Content where Content: View
	func expand() -> [AnyView]
	var viewCount: Int { get }
}
extension ViewExpand {
	func wrap<Content>(_ source: Any) -> Content where Content: View {
		if let view = source as? Content {
			return view
		}
		fatalError()
	}
	var viewCount: Int {
		return 1
	}
}

extension ForEach: ViewExpand where Content: View {
	func expand() -> [AnyView] {
		var viewList: [AnyView] = []
		var index = data.startIndex
		while index != data.endIndex {//先不考虑初始化性能, 先展开再说
			let view = content(data[index])
			if let view = view as? ViewExpand {
				viewList.append(contentsOf: view.expand())
			} else {
				viewList.append(AnyView(view))
			}
			index = data.index(after: index)
		}
		return viewList
	}
	var viewCount: Int {
		return expand().count
	}
}

extension TupleView: ViewExpand {
	
	func expand() -> [AnyView] {
		let tupleMirror = Mirror(reflecting: value)
		let tupleElements = tupleMirror.children.compactMap({ $0.value as? AnyView })
		var result: [AnyView] = []
		for ele in tupleElements {
			if let expand = ele.stroage.value as? ViewExpand {
				result.append(contentsOf: expand.expand())
			} else {
				result.append(ele)
			}
		}
		return result
	}

	var viewCount: Int {
		return expand().count
	}
}
#endif
