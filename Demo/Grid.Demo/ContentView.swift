//
//  ContentView.swift
//  Grid.Demo
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	static var image: [String: UIImage] = [:]
		func createWebImage(from profile: String) -> WebImage {
			let webImage = WebImage()
			if Self.image[profile] == nil {
				DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(2)) {
					Character.download(url: profile, binding: webImage)
				}
			}
			return webImage
		}
		var body: some View {
			Grid {
				ForEach(0..<Character.list.count) { index  in
					DisplayItem(index: index, name: Character.list[index].name, filllWidth: false).environmentObject(self.createWebImage(from: Character.list[index].profile))
				}

				ForEach(0..<Character.list.count) { index  in
					DisplayItem(index: index, name: Character.list[index].name, filllWidth: true).environmentObject(self.createWebImage(from: Character.list[index].profile))
				}
			}
		}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
