//
//  Grid.swift
//  arknight-cal
//
//  Created by mikun on 2019/7/22.
//  Copyright © 2019 庄黛淳华. All rights reserved.
//

import UIKit
import SwiftUI
/*RandomAccessCollection :
IdentifierValuePairs
*/
protocol CollectionUpdate: class {
	func tryUpdate(indexPath: IndexPath)
}
struct Grid<Selection, Content>: UIViewRepresentable where Selection : SelectionManager, Content : View {
	var selection: Binding<Selection>?
	var viewList: Content!
	let axis: Axis
	
	@available(watchOS, unavailable)
	public init(axis: Axis = .vertical, selection: Binding<Selection>?, @ViewBuilder content: () -> Content) {
		self.axis = axis
		self.selection = selection
		self.viewList = content()
	}
	
	@available(watchOS, unavailable)
	public init<Data, ID, RowContent>(_ data: Data, id: KeyPath<Data.Element, ID>, axis: Axis = .vertical, selection: Binding<Selection>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<IdentifierValuePairs<Data, ID>, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	typealias UIViewType = UICollectionView
	let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)), collectionViewLayout: UICollectionViewFlowLayout())
	func makeUIView(context: Context) -> UIViewType {
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		
		collectionView.delegate = context.coordinator
		collectionView.dataSource = context.coordinator
		
		switch axis {
		case .horizontal:
			layout.scrollDirection = .horizontal
			collectionView.alwaysBounceHorizontal = true
		case .vertical:
			layout.scrollDirection = .vertical
			collectionView.alwaysBounceVertical = true
		@unknown default: break
		}
		
		collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
		collectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReusableView.identifier)
		collectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ReusableView.identifier)
		collectionView.backgroundColor = .systemBackground
		return collectionView
	}
	func updateUIView(_ uiView: UIViewType, context: Context) {
		uiView.reloadData()//先直接reload
	}
	func makeCoordinator() -> Coordinator<Selection, Content> {
		Coordinator(self)
	}
	class Coordinator<Selection, Content>: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CollectionUpdate where Selection : SelectionManager, Content : View {
		func tryUpdate(indexPath: IndexPath) {
			if let cell = parent.collectionView.cellForItem(at: indexPath),
				cell.frame.size != self.collectionView(parent.collectionView, layout: parent.collectionView.collectionViewLayout, sizeForItemAt: indexPath) {
				sections[indexPath.section][indexPath.item].needUpdate = false
				parent.collectionView.reloadItems(at: [indexPath])
			}
		}
		
		var parent: Grid<Selection, Content>
		
		var sections: [[AnyView]]!
		var sectionsExtra: [[AnyView?]] = []
		
		init(_ parent: Grid<Selection, Content>) {
			self.parent = parent
		}

		// MARK: - UICollectionViewDataSource.cell
		func numberOfSections(in collectionView: UICollectionView) -> Int {
			if sections != nil { return sections.count }
			sections = []
			sectionsExtra = []
			var checkingSection: [AnyView] = []
			
			let subviews: [AnyView]
			if let view = parent.viewList as? ViewExpand {
				subviews = view.expand()
			} else {
				subviews = [AnyView(parent.viewList)]
			}
			for _view in subviews {
				if let section = _view.stroage.value as? GridSectionProtocol {
					
					if !checkingSection.isEmpty {
						sections.append(checkingSection)
						sectionsExtra.append([nil, nil])
					}
					sections.append(section.contents)
					checkingSection = []
					sectionsExtra.append([section.header, section.footer])
				} else {
					checkingSection.append(_view)
				}
			}
			if !checkingSection.isEmpty {
				sections.append(checkingSection)
				sectionsExtra.append([nil, nil])
			}
			
			return sections.count
		}
		func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
			return sections[section].count
		}
		
		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			var size: CGSize
			if (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical {
				size = UIHostingController(rootView: sections[indexPath.section][indexPath.row].anyView).sizeThatFits(in: CGSize(width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
			} else {
				size = UIHostingController(rootView: sections[indexPath.section][indexPath.row].anyView).sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
			}
			if size.height == CGFloat.greatestFiniteMagnitude || size.height == 0{
				size.height = 50
			}
			if size.width == CGFloat.greatestFiniteMagnitude || size.width == 0 {
				size.width = 50
			}
			return size
		}
		func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			let anyView = sections[indexPath.section][indexPath.row]
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
			if let view = anyView.anyView {
				cell.hosting = .init(rootView: view, indexPath: indexPath, updateSource: self)
			}
			sections[indexPath.section][indexPath.item].needUpdate = true
			return cell
		}
		
		// MARK: - UICollectionViewDelegate.SelectItem
		func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
			parent.selection?.value.select(indexPath as! Selection.SelectionValue)
		}
		func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
			parent.selection?.value.deselect(indexPath as! Selection.SelectionValue)
			return true
		}
		// MARK: - UICollectionViewDelegate.headerFooter
		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
			if let view = sectionsExtra[section].first??.anyView {
				var size: CGSize
				if (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical {
					size = UIHostingController(rootView: view).sizeThatFits(in: CGSize(width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
					if size.height == CGFloat.greatestFiniteMagnitude {
						size.height = 0
					}
				} else {
					size = UIHostingController(rootView: view).sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
					if size.width == CGFloat.greatestFiniteMagnitude {
						size.width = 0
					}
				}
				return size
			} else {
				return .zero
			}
		}
		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
			if let view = sectionsExtra[section].last??.anyView {
				var size: CGSize
				if (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical {
					size = UIHostingController(rootView: view).sizeThatFits(in: CGSize(width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
					if size.height == CGFloat.greatestFiniteMagnitude {
						size.height = 50
					}
				} else {
					size = UIHostingController(rootView: view).sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
					if size.width == CGFloat.greatestFiniteMagnitude {
						size.width = 50
					}
				}
				return size
			} else {
				return .zero
			}
		}
		func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
			let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReusableView.identifier, for: indexPath) as! ReusableView
			if kind == UICollectionView.elementKindSectionHeader, let rootView = sectionsExtra[indexPath.section].first??.anyView {
				view.hosting = UIHostingController(rootView: rootView)
			}
			if kind == UICollectionView.elementKindSectionFooter, let rootView = sectionsExtra[indexPath.section].last??.anyView {
				view.hosting = UIHostingController(rootView: rootView)
			}
			return view
		}
		
		// MARK: - UICollectionViewDelegate.MultipleSelection
		func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
			return parent.selection?.value.allowsMultipleSelection ?? false
		}
	}
}
extension Grid {
	class ReusableView: UICollectionReusableView {
		static var identifier: String { "SwiftUI.mikun.Grid.ReusableView" }
		var hosting: UIHostingController<SwiftUI.AnyView>? {
			didSet {
				oldValue?.view.removeFromSuperview()
				if let view = hosting?.view {
					addSubview(view)
				}
			}
		}

		override func layoutSubviews() {
			super.layoutSubviews()
			hosting?.view.frame = bounds
		}
	}
	class Cell: UICollectionViewCell {
		static var identifier: String { "SwiftUI.mikun.Grid.Cell" }
		var hosting: Hosting? {
			didSet {
				oldValue?.view.removeFromSuperview()
				if let view = hosting?.view {
					contentView.addSubview(view)
					hosting?.view.frame = contentView.bounds
				}
			}
		}
		
		override func layoutSubviews() {
			super.layoutSubviews()
			hosting?.view.frame = contentView.bounds
		}
		class Hosting: UIHostingController<SwiftUI.AnyView> {
			var indexPath: IndexPath!
			weak var updateSource: CollectionUpdate?
			convenience init(rootView: SwiftUI.AnyView, indexPath: IndexPath, updateSource: CollectionUpdate) {
				self.init(rootView: rootView)
				self.indexPath = indexPath
				self.updateSource = updateSource
			}
			override func viewDidLayoutSubviews() {
				super.viewDidLayoutSubviews()
				updateSource?.tryUpdate(indexPath: indexPath)
			}
		}
	}
}

extension Grid where Selection == Never {
	@available(watchOS, unavailable)
	init(axis: Axis = .vertical, @ViewBuilder content: () -> Content) {
		self.axis = axis
		self.viewList = content()
	}
	
	//
	//    /// Creates a List that identifies its rows based on the `id` key path to a
	//    /// property on an underlying data element.
	//    public init<Data, ID, RowContent>(_ data: Data, id: KeyPath<Data.Element, ID>, rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<IdentifierValuePairs<Data, ID>, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View
	
}
