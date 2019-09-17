//
//  LazyView.swift
//  Grid.Demo
//
//  Created by mikun on 2019/9/12.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

struct LazyView<Content>: View where Content: View{
	let destination: ()->Content
	var body: some View {
		destination()
	}
}
