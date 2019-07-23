//
//  DisplayItem.swift
//  Grid.Demo
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI
struct DisplayItem: View {
	let index: Int
	let name: String
	let filllWidth: Bool
	@EnvironmentObject private var webImage: WebImage
	var body: some View {
		HStack {
			if webImage.image != nil {
				Image(uiImage: webImage.image!).resizable().frame(width: 60, height: 60)
			}
			Text(name).font(.system(size: 12))
			if filllWidth {
				Spacer()
			}
		}
	}
}
