//
//  SelectionNavigationModifier.swift
//  Grid.Demo
//
//  Created by mikun on 2019/9/12.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

/// A utility view modifier that allows for dynamic navigation based on some arbitrary selection value.
struct SelectionNavigationModifier<Selection, Destination: View>: ViewModifier {
    private let selection: Binding<Selection?>
    private let destination: (Selection) -> Destination

    public init(selection: Binding<Selection?>, @ViewBuilder destination: @escaping (Selection) -> Destination) {
        self.selection = selection
        self.destination = destination
    }
    private var isActive: Binding<Bool> {
		.init(get: {
			print(self.selection.wrappedValue as Any)
			return self.selection.wrappedValue != nil
		}, set: { newValue in
			if !newValue {
				self.selection.wrappedValue = nil
			}
			print(self.selection.wrappedValue as Any)
		})
    }

    public func body(content: Content) -> some View {
		ZStack {
			//FIXME:    13.1b3, _ViewModifier_Content放在ZStack里显示不了
			NavigationLink(destination: LazyView(destination: {
				self.destination(self.selection.wrappedValue!)
			}), isActive: isActive) {
				EmptyView().frame(width: 0, height: 0)
			}
			content
		}
    }
}
