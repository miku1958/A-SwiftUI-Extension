//
//  Character.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/23.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import Foundation
import SwiftUI

struct Character: Hashable {
	let profile: String
	let name: String
	static let list = [
		Character(profile: "http://p4.qhimg.com/dr/80__/t01ede14c4b4255d441.png", name: "深海色")
		,Character(profile: "http://p3.qhimg.com/dr/80__/t01fec5ad1cac71ea8f.png", name: "德克萨斯")
		,Character(profile: "http://p7.qhimg.com/dr/80__/t01c03c70d182949d70.png", name: "夜刀")
		,Character(profile: "http://p6.qhimg.com/dr/80__/t0112ded5e2c886e2ed.png", name: "芬")
		,Character(profile: "http://p1.qhimg.com/dr/80__/t017ddbdaf24f97c8d3.png", name: "芙兰卡")
		,Character(profile: "http://p1.qhimg.com/dr/80__/t0144bc8bb6c3b82fe5.png", name: "幽灵鲨")
		,Character(profile: "http://p0.qhimg.com/dr/80__/t01e318e95d7934d59a.png", name: "凛冬")
		,Character(profile: "http://p2.qhimg.com/dr/80__/t0115aa310877b07f77.png", name: "杜宾")
		,Character(profile: "http://p3.qhimg.com/dr/80__/t01c502355dfb308d1d.png", name: "推进之王")
		,Character(profile: "http://p4.qhimg.com/dr/80__/t01c30f9d9e22ac92c6.png", name: "白面鸮")
		,Character(profile: "http://p8.qhimg.com/dr/80__/t0137aa3ca83adb6188.png", name: "梅")
		,Character(profile: "http://p7.qhimg.com/dr/80__/t0117ba7620bc644449.png", name: "夜烟")
		,Character(profile: "http://p7.qhimg.com/dr/80__/t01f12dc2ae0dec5777.png", name: "阿米娅")
	]
	static var downloading: [String: [WebImage]] = [:]
	static func download(url: String, binding: WebImage) {
		if downloading[url] == nil {
			downloading[url] = []
		}
		downloading[url]?.append(binding)
		URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in
			guard let data = data else { return }
			DispatchQueue.main.async {
				let image = UIImage(data: data)
				for bing in downloading[url] ?? [] {
					bing.image = image
				}
				downloading[url] = nil
			}
		}.resume()
	}
}
