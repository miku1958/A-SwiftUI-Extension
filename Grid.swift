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
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Grid<SelectionValue, Content> where SelectionValue : Hashable, Content : View {
	
	var selection: Binding<SelectionValue?>?
	var selectionSet: Binding<Set<SelectionValue>>?
	var viewList: Content!
	let axis: Axis
	
	public typealias UIViewType = UICollectionView
	let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)), collectionViewLayout: UICollectionViewFlowLayout())
	/// Creates a List that supports multiple selection.
	///
	/// - Parameter selection: A binding to a set that identifies the selected
	///   rows.
	///
	/// - See Also: `View.selectionValue` which gives an identifier to the rows.
	///
	/// - Note: On iOS and tvOS, you must explicitly put the `List` into Edit
	///   Mode for the selection to apply.
	@available(watchOS, unavailable)
	public init(_ axis: Axis = .vertical, selection: Binding<Set<SelectionValue>>?, @ViewBuilder content: () -> Content) {
		
		self.axis = axis
		self.selectionSet = selection
		self.viewList = content()
	}
	
	/// Creates a List that supports optional single selection.
	///
	/// - Parameter selection: A binding to the optionally selected row.
	///
	/// - See Also: `View.selectionValue` which gives an identifier to the rows.
	///
	/// - Note: On iOS and tvOS, you must explicitly put the `List` into Edit
	///   Mode for the selection to apply.
	@available(watchOS, unavailable)
	public init(_ axis: Axis = .vertical, selection: Binding<SelectionValue?>?, @ViewBuilder content: () -> Content) {
		
		self.axis = axis
		self.selection = selection
		self.viewList = content()
	}
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension Grid {
	
	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
	@available(watchOS, unavailable)
	public init<Data, RowContent>(_ axis: Axis = .vertical, data: Data, selection: Binding<Set<SelectionValue>>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
		self.axis = axis
		self.selectionSet = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that identifies its rows based on the `id` key path to a
	/// property on an underlying data element.
	@available(watchOS, unavailable)
	public init<Data, ID, RowContent>(_ axis: Axis = .vertical, data: Data, id: KeyPath<Data.Element, ID>, selection: Binding<Set<SelectionValue>>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.selectionSet = selection
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that computes views on demand over a *constant* range.
	///
	/// This instance only reads the initial value of `data` and so it does not
	/// need to identify views across updates.
	///
	/// To compute views on demand over a dynamic range use
	/// `List(_:id:selection:content:)`.
	@available(watchOS, unavailable)
	public init<RowContent>(_ axis: Axis = .vertical, data: Range<Int>, selection: Binding<Set<SelectionValue>>?, @ViewBuilder rowContent: @escaping (Int) -> RowContent) where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View {
		self.axis = axis
		self.selectionSet = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
	@available(watchOS, unavailable)
	public init<Data, RowContent>(_ axis: Axis = .vertical, data: Data, selection: Binding<SelectionValue?>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that identifies its rows based on the `id` key path to a
	/// property on an underlying data element.
	@available(watchOS, unavailable)
	public init<Data, ID, RowContent>(_ axis: Axis = .vertical, data: Data, id: KeyPath<Data.Element, ID>, selection: Binding<SelectionValue?>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that computes views on demand over a *constant* range.
	///
	/// This instance only reads the initial value of `data` and so it does not
	/// need to identify views across updates.
	///
	/// To compute views on demand over a dynamic range use
	/// `List(_:id:selection:content:)`.
	@available(watchOS, unavailable)
	public init<RowContent>(_ axis: Axis = .vertical, data: Range<Int>, selection: Binding<SelectionValue?>?, @ViewBuilder rowContent: @escaping (Int) -> RowContent) where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
	}
}
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension Grid where SelectionValue == Never {
	
	public init(_ axis: Axis = .vertical, @ViewBuilder content: () -> Content) {
		
		self.axis = axis
		self.viewList = content()
	}
	
	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
	public init<Data, RowContent>(_ axis: Axis = .vertical, data: Data, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
		self.axis = axis
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that identifies its rows based on the `id` key path to a
	/// property on an underlying data element.
	public init<Data, ID, RowContent>(_ axis: Axis = .vertical, data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
	}
	
	/// Creates a List that computes views on demand over a *constant* range.
	///
	/// This instance only reads the initial value of `data` and so it does not
	/// need to identify views across updates.
	///
	/// To compute views on demand over a dynamic range use
	/// `List(_:id:content:)`.
	public init<RowContent>(_ axis: Axis = .vertical, data: Range<Int>, @ViewBuilder rowContent: @escaping (Int) -> RowContent) where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View {
		self.axis = axis
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
	}
}
extension Grid: UIViewRepresentable {
	
	public func makeUIView(context: Context) -> UIViewType {
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
		}
		
		collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
		collectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReusableView.identifier)
		collectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ReusableView.identifier)
		collectionView.backgroundColor = .systemBackground
		return collectionView
	}
	public func updateUIView(_ uiView: UIViewType, context: Context) {
		uiView.reloadData()//先直接reload
	}
	public func makeCoordinator() -> Coordinator<SelectionValue, Content> {
		Coordinator(self)
	}
	public class Coordinator<SelectionValue, Content>: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CollectionUpdate where SelectionValue : Hashable, Content : View {
		func tryUpdate(indexPath: IndexPath) {
			if let cell = parent.collectionView.cellForItem(at: indexPath),
				cell.frame.size != self.collectionView(parent.collectionView, layout: parent.collectionView.collectionViewLayout, sizeForItemAt: indexPath) {
				sections[indexPath.section][indexPath.item].needUpdate = false
				parent.collectionView.reloadItems(at: [indexPath])
			}
		}
		
		var parent: Grid<SelectionValue, Content>
		
		var sections: [[AnyView]]!
		var sectionsExtra: [[AnyView?]] = []
		
		init(_ parent: Grid<SelectionValue, Content>) {
			self.parent = parent
		}
		
		// MARK: - UICollectionViewDataSource.cell
		public func numberOfSections(in collectionView: UICollectionView) -> Int {
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
		public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
			return sections[section].count
		}
		
		public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
		public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			let anyView = sections[indexPath.section][indexPath.row]
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
			if let view = anyView.anyView {
				cell.hosting = .init(rootView: view, indexPath: indexPath, updateSource: self)
			}
			sections[indexPath.section][indexPath.item].needUpdate = true
			return cell
		}
		
		// MARK: - UICollectionViewDelegate.SelectItem
		public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
			parent.selection?.value = indexPath as? SelectionValue
		}
		// MARK: - UICollectionViewDelegate.headerFooter
		public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
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
		public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
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
		public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
			let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReusableView.identifier, for: indexPath) as! ReusableView
			if kind == UICollectionView.elementKindSectionHeader, let rootView = sectionsExtra[indexPath.section].first??.anyView {
				view.hosting = UIHostingController(rootView: rootView)
			}
			if kind == UICollectionView.elementKindSectionFooter, let rootView = sectionsExtra[indexPath.section].last??.anyView {
				view.hosting = UIHostingController(rootView: rootView)
			}
			return view
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
