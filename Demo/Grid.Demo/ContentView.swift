//
//  ContentView.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/22.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import Combine
import SwiftUI
final class WebImage: ObservableObject {
	let url: String
	init(url: String) {
		self.url = url
	}
	@Published var image: UIImage? = nil {
		didSet {
			if image != nil {
				ContentView.image[url] = image
			}
		}
	}

}

struct DisplayItem: View {
	let index: Int
	let char: Character
	@EnvironmentObject private var webImage: WebImage
	func createImage() -> some View {
		Image(uiImage: webImage.image!).resizable().aspectRatio(contentMode: .fit).frame(width: 60)
		.cornerRadius(6)
	}
	var body: some View {
		HStack(alignment: .top) {
			if index % 2 == 0 && webImage.image != nil {
				createImage()
			}
			VStack(alignment: index % 2 == 0 ? .leading : .trailing, spacing: 0) {
				Text(char.name).font(.system(size: 11))
				Text(char.job).font(.system(size: 13))
					.foregroundColor(.orange)
					.underline()
				Spacer()
				HStack(spacing: 3) {
					ForEach(0 ..< char.level) { _ in
						Image("star").resizable().aspectRatio(contentMode: .fit).frame(height: 10).shadow(radius: 3)
					}
				}
				Text(char.area).font(.system(size: 10))
			}
			
			if index % 2 == 1 && webImage.image != nil {
				createImage()
			}
		}.frame(height: 60)
		.padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
			
	}
}
struct ContentView: View {
	static var image: [String: UIImage] = [:]
	static var count = 2.0
	func createWebImage(from profile: String) -> WebImage {
		let webImage = WebImage(url: profile)
		if Self.image[profile] == nil {
			DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(Self.count)) {
				Character.download(url: profile, binding: webImage)
			}
//			Self.count += 0.3
		}
		return webImage
	}
    var body: some View {
		return Grid {
			ForEach(0 ..< Character.list.count) { index  in
				DisplayItem(index: index, char: Character.list[index % Character.list.count]).environmentObject(self.createWebImage(from: Character.list[index % Character.list.count].profile))
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
