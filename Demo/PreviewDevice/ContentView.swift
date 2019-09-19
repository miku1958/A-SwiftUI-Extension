//
//  ContentView.swift
//  PreviewDevice
//
//  Created by mikun on 2019/8/10.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var showCover = false
	var color: Color? = nil
	var airDrop: some View {
		VStack(spacing: 0) {
			Text("AirDrop")
				.font(.headline)
				.padding(EdgeInsets(top: 22, leading: 0, bottom: 0, trailing: 0))
			Text("\"mikuPhone\" would like to share a photo.")
				.font(.body)
				.padding(EdgeInsets(top: 6, leading: 15, bottom: 0, trailing: 15))
			Image("76678634_p0")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(maxWidth: 270)
				.padding(EdgeInsets(top: 22, leading: 0, bottom: 15, trailing: 0))
			Divider()
			HStack {
				Button(action: {
					withAnimation {
						self.showCover = false
					}
				}) {
					Text("Decline")
				}.centered()
				Divider()
				Button(action: {
					withAnimation {
						self.showCover = false
					}
				}) {
					Text("Accept")
				}.centered()
			}
			.frame(width: 270, height: 43)
			.aspectRatio(contentMode: .fill)
			Divider()
		}
		.background(Rectangle()
			.fill(Color.clear)
			.background(BlurView(style: .prominent))
			.frame(width: 270))
		.cornerRadius(7)
		.frame(width: 270)
	}
	var body1: some View {
		NavigationView {
			Image("76678634_p0")
				.resizable()
				.renderingMode(.original)
				.aspectRatio(contentMode: .fit)
				.push(self.airDrop)
		}
	}
    var body: some View {
		Image("76678634_p0")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.coverScreen(showCover) {
				self.airDrop
		}.onTapGesture {
			self._showCover.animation(true)
		}
	}
	@State var selectionIndex: Int?
	
	var body3: some View {
		NavigationView {
			List(1..<10) { index in
				Button("\(index)"){
					self.selectionIndex = index
				}
			}
			.navigationBar {
				Color.red
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
//		.push(selection: $selectionIndex) {
//			Text("\($0)")
//		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().previewDevice(.iPhoneSE)
	}
}
