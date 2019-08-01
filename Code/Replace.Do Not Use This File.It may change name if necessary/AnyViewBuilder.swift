//
//  AnyViewBuilder.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

public struct ConditionalContent<TrueContent, FalseContent> : View
where TrueContent : View, FalseContent : View {
	public typealias Body = Never
	public var body: Never {
		fatalError()
	}
	
	enum Content {
		case first(TrueContent)
		case second(FalseContent)
	}
	let content : Content
	
	init(first  : TrueContent)  { content = .first(first)   }
	init(second : FalseContent) { content = .second(second) }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@_functionBuilder public struct ViewBuilder {
	
	/// Builds an empty view from an block containing no statements, `{ }`.
	public static func buildBlock() -> EmptyView {
		return EmptyView()
	}
	
	/// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through
	/// unmodified.
	public static func buildBlock<Content>(_ content: Content) -> Content where Content : View {
		return content
	}
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension ViewBuilder {
	
	/// Provides support for "if" statements in multi-statement closures, producing an `Optional` view
	/// that is visible only when the `if` condition evaluates `true`.
	public static func buildIf<Content>(_ content: Content?) -> Content? where Content : View {
		return content
	}
	
	/// Provides support for "if" statements in multi-statement closures, producing
	/// ConditionalContent for the "then" branch.
	public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
		return ConditionalContent(first: first)
	}
	
	/// Provides support for "if-else" statements in multi-statement closures, producing
	/// ConditionalContent for the "else" branch.
	public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
		return ConditionalContent(second: second)
	}
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension ViewBuilder {
	
	public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(AnyView, AnyView)> where C0 : View, C1 : View {
		return TupleView((AnyView(c0), AnyView(c1)))
	}
	
	public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> TupleView<(AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleView<(AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleView<(AnyView, AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> TupleView<(AnyView, AnyView, AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4), AnyView(c5)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> TupleView<(AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4), AnyView(c5), AnyView(c6)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> TupleView<(AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4), AnyView(c5), AnyView(c6), AnyView(c7)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> TupleView<(AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4), AnyView(c5), AnyView(c6), AnyView(c7), AnyView(c8)))
	}
	
	
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleView<(AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView, AnyView)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View {
		return TupleView((AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4), AnyView(c5), AnyView(c6), AnyView(c7), AnyView(c8), AnyView(c9)))
	}
}
