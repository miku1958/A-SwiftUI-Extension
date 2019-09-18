//
//  ContentView.swift
//  BlurView.mac.Demo
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
	var body1: some View {
		ZStack {
			HStack {
				Color.gray
				Color.red
			}
			VStack {
				Text("")
//				Group {
//					ZStack { BlurView(style: .popover).frame(width: 200) ;Text("popover") }
//					ZStack { BlurView(style: .toolTip).frame(width: 200) ;Text("toolTip") }
//					ZStack { BlurView(style: .menu).frame(width: 200) ;Text("menu") }
//					ZStack { BlurView(style: .sheet).frame(width: 200) ;Text("sheet") }
//				}
//				Group {
//					ZStack { BlurView(style: .underWindowBackground).frame(width: 200) ;Text("underWindowBackground") }
//					ZStack { BlurView(style: .sidebar).frame(width: 200) ;Text("sidebar") }
//					ZStack { BlurView(style: .headerView).frame(width: 200) ;Text("headerView") }
//					ZStack { BlurView(style: .windowBackground).frame(width: 200) ;Text("windowBackground") }
//					ZStack { BlurView(style: .contentBackground).frame(width: 200) ;Text("contentBackground") }
//				}
			}
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
