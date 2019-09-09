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
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(OSX, unavailable)
public struct Grid<SelectionValue, Content> where SelectionValue : Hashable, Content : View {
	
	var selection: Binding<SelectionValue?>?
	var selectionSet: Binding<Set<SelectionValue>>?
	var viewList: Content!
	let axis: Axis
	private let defaultFrame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
	
	public typealias UIViewType = UICollectionView
	let collectionView: UICollectionView

	public init(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), selection: Binding<Set<SelectionValue>>?, @ViewBuilder content: () -> Content) {
		
		self.axis = axis
		self.selectionSet = selection
		self.viewList = content()
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	public init(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), selection: Binding<SelectionValue?>?, @ViewBuilder content: () -> Content) {
		
		self.axis = axis
		self.selection = selection
		self.viewList = content()
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
}

extension Grid {
	public init<Data, RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Data, selection: Binding<Set<SelectionValue>>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
		self.axis = axis
		self.selectionSet = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	public init<Data, ID, RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Data, id: KeyPath<Data.Element, ID>, selection: Binding<Set<SelectionValue>>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.selectionSet = selection
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	public init<RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Range<Int>, selection: Binding<Set<SelectionValue>>?, @ViewBuilder rowContent: @escaping (Int) -> RowContent) where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View {
		self.axis = axis
		self.selectionSet = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	public init<Data, RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Data, selection: Binding<SelectionValue?>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	public init<Data, ID, RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Data, id: KeyPath<Data.Element, ID>, selection: Binding<SelectionValue?>?, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	public init<RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Range<Int>, selection: Binding<SelectionValue?>?, @ViewBuilder rowContent: @escaping (Int) -> RowContent) where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View {
		self.axis = axis
		self.selection = selection
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
}

extension Grid where SelectionValue == Never {
	
	public init(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), @ViewBuilder content: () -> Content) {
		
		self.axis = axis
		self.viewList = content()
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
	public init<Data, RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Data, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
		self.axis = axis
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	/// Creates a List that identifies its rows based on the `id` key path to a
	/// property on an underlying data element.
	public init<Data, ID, RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View {
		self.axis = axis
		self.viewList = ForEach(data, id: id) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
	}
	
	public init<RowContent>(_ axis: Axis = .vertical, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), data: Range<Int>, @ViewBuilder rowContent: @escaping (Int) -> RowContent) where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View {
		self.axis = axis
		self.viewList = ForEach(data) { element in
			HStack {
				rowContent(element)
			}
		}
		self.collectionView = UICollectionView(frame: defaultFrame, collectionViewLayout: layout)
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
				parent.collectionView.reloadItems(at: [indexPath])
			}
		}
		
		var parent: Grid<SelectionValue, Content>
		
		var sections: [[AnyView]]!
		var sectionsExtra: [(header: AnyView?, footer: AnyView?)] = []
		
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
						sectionsExtra.append((nil, nil))
					}
					sections.append(section.contents)
					checkingSection = []
					sectionsExtra.append((section.header, section.footer))
				} else {
					checkingSection.append(_view)
				}
			}
			if !checkingSection.isEmpty {
				sections.append(checkingSection)
				sectionsExtra.append((nil, nil))
			}
			
			return sections.count
		}
		public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
			return sections[section].count
		}
		
		public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			var anyView = sections[indexPath.section][indexPath.row]
			if anyView._hostingCache == nil {
				anyView._hostingCache = Cell.Hosting(rootView: anyView.anyView, indexPath: indexPath, updateSource: self)
			}
			var size: CGSize
			if (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical {
				size = sections[indexPath.section][indexPath.row].hostingCache().sizeThatFits(in: CGSize(width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
			} else {
				size = sections[indexPath.section][indexPath.row].hostingCache().sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
			}
			if size.height == CGFloat.greatestFiniteMagnitude || size.height == 0{
				size.height = 50
			}
			if size.width == CGFloat.greatestFiniteMagnitude || size.width == 0 {
				size.width = 50
			}
			sections[indexPath.section][indexPath.row] = anyView
			return size
		}
		public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			var anyView = sections[indexPath.section][indexPath.row]
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
			cell.hosting = anyView.hostingCache() as? Cell.Hosting
			sections[indexPath.section][indexPath.row] = anyView
			return cell
		}
		// MARK: - UICollectionViewDelegate.SelectItem
		public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
			parent.selection?.wrappedValue = indexPath as? SelectionValue
		}
		// MARK: - UICollectionViewDelegate.headerFooter
		public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
			if sectionsExtra[section].header != nil {
				var size: CGSize
				if (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical {
					size = sectionsExtra[section].header!.hostingCache().sizeThatFits(in: CGSize(width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
					if size.height == CGFloat.greatestFiniteMagnitude {
						size.height = 0
					}
				} else {
					size = sectionsExtra[section].header!.hostingCache().sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
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
			if sectionsExtra[section].footer != nil {
				var size: CGSize
				if (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical {
					size = sectionsExtra[section].footer!.hostingCache().sizeThatFits(in: CGSize(width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
					if size.height == CGFloat.greatestFiniteMagnitude {
						size.height = 50
					}
				} else {
					size = sectionsExtra[section].footer!.hostingCache().sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
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
			if kind == UICollectionView.elementKindSectionHeader, sectionsExtra[indexPath.section].header != nil {
				view.hosting = sectionsExtra[indexPath.section].header!.hostingCache()
			}
			if kind == UICollectionView.elementKindSectionFooter, sectionsExtra[indexPath.section].footer != nil {
				view.hosting = sectionsExtra[indexPath.section].footer!.hostingCache()
			}
			return view
		}
	}
}
extension Grid {
	class ReusableView: UICollectionReusableView {
		static var identifier: String { "SwiftUI.mikun.Grid.ReusableView" }
		var hosting: UIHostingController<SwiftUI.AnyView?>? {
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
				if let view = hosting?.view {
					contentView.subviews.forEach {
						$0.removeFromSuperview()
					}
					contentView.addSubview(view)
					view.frame = contentView.bounds
					
				}
			}
		}
		
		override func layoutSubviews() {
			super.layoutSubviews()
			hosting?.view.frame = contentView.bounds
		}
		class Hosting: UIHostingController<SwiftUI.AnyView?> {
			var indexPath: IndexPath!
			weak var updateSource: CollectionUpdate?
			convenience init(rootView: SwiftUI.AnyView?, indexPath: IndexPath, updateSource: CollectionUpdate) {
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
