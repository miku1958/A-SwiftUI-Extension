# SwiftUI.Extension
A SwiftUI extension

## Version 0.2

### Add a few View extension

| Name             | Description                                                  | Usage                                                 |
| ---------------- | ------------------------------------------------------------ | ----------------------------------------------------- |
| addBorder        | Add a border like beta1                                      | .addBorder(Color.red)                                 |
| consideConfig    | Set the view using branches                                  | .consideConfig(boolValue, true: {view}, false:{view}) |
| considerModifier | Set the viewModifier using branches                          | .considerModifier(boolValue, true: {vm}, false:{vm})  |
| coverScreen      | Cover A fullscreen view above any view like present in UIKit | .cover(activeBool, backgroundColor: .black, {view})   |
| doAnimation      | Do animation like UIKit when appear                          | `.doAnimation { $0.opacity($1 ? 0 : 1) }`             |
| centered         | put the view to HStack/VStack 's center by adding Spacer()   | .centered()                                           |
| push             | fast use NavigationLink add lazy load Destination View, bascily has same API | .push(destinationView)                                |
| navigationBar    | Add a custom navigationBar                                   | .navigationBar(customNavigationBar)                   |

### BlurView for iOS and macOS

Usage: 

```
BlurView(level: value, prefer: .dark)
```

blur level is between 0 to 1, and accoriding to this value to choose a blur effect style/material to the visualEffectView

Because of the degree of blur is different when switch to dark mode from light in some effect style/material, so the prefer parameter is added for sorting by light or dark, default is light

### PreviewDevice

Change PreviewDevice(rawValue: "device name")  to PreviewDevice.deviceName:

```
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().previewDevice(.iPhoneSE)
	}
}
```

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

