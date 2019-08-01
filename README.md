# SwiftUI.Extension
A SwiftUI extension including truly Grid with UICollectionView



## Version 0.1

### Grid implemented by UICollectionView

Usage :

```swift
Grid {
	some View
}
```

such as :

```swift
Grid {
	ForEach(0..<Character.list.count) { index  in
		DisplayItem(index: index, name: Character.list[index].name, filllWidth: false).environmentObject(self.createWebImage(from: Character.list[index].profile))
	}
}
```

It will looks like exactly the same in UICollectionView

![](http://wx3.sinaimg.cn/mw690/70a5dc58gy1g5kj8xew87g208c0euqv8.gif)

Or you can use other custom UICollectionLayout you prefer like:

```swift
Grid(layout: CustomLayout()) {
	ForEach(0 ..< Character.list.count) { index  in
		...
	}
```

Otherwise, Grid will use UICollectionFlowLayout as default layout