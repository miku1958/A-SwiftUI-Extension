# SwiftUI.Extension
A SwiftUI extension including truly Grid with UICollectionView



## Version 0.1

### Grid implemented by UICollectionView and UICollectionViewFlowLayout

Usage :

```swift
Grid {
	some View
}
```

such as code in demo:

```swift
Grid {
	ForEach(0..<Character.list.count) { index  in
		DisplayItem(index: index, name: Character.list[index].name, filllWidth: false).environmentObject(self.createWebImage(from: Character.list[index].profile))
	}

	ForEach(0..<Character.list.count) { index  in
		DisplayItem(index: index, name: Character.list[index].name, filllWidth: true).environmentObject(self.createWebImage(from: Character.list[index].profile))
	}
}
```

It will looks like exactly the same in UICollectionView without changing UICollectionViewFlowLayout

![](http://wx2.sinaimg.cn/mw690/70a5dc58gy1g5a5cbd42rg20b40jthdu.gif)

Known issue

There has huge performance problem, but it still work great. I will fix it when SwiftUI b5 release