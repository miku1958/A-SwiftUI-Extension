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



known issue

has huge performance problem, but it work great. I will continue when SwiftUI b5 release