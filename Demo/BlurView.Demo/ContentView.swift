//
//  ContentView.swift
//  BlurView.Demo
//
//  Created by mikun on 2019/9/10.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var value: CGFloat = 0
	var body: some View {
		ZStack {
			HStack {
				Color.gray
				Color.red
			}
			VStack {
				ZStack { BlurView(level: value, prefer: .dark).frame(width: 200, height: 100) ;Text("popover") }
				Slider(value: $value, in: 0...1)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
