//
//  ForEachWithIndex.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import SwiftUI

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public struct ForEachWithIndex<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    public var data: Data
    public var id: KeyPath<Data.Element, ID>
    public var content: (_ index: Data.Index, _ element: Data.Element) -> Content

    public init(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (_ index: Data.Index, _ element: Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.content = content
    }

    public var body: some View {
        ForEach(
            zip(self.data.indices, self.data).map { index, element in
                IndexInfo(
                    index: index,
                    id: self.id,
                    element: element
                )
            },
            id: \.elementID
        ) { indexInfo in
            self.content(indexInfo.index, indexInfo.element)
        }
    }
}

