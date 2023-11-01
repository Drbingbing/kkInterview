//
//  Extension+Array.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation

extension Array {
    
    public func merge(
        _ collection: [Element],
        on projection: (Element, Element) -> Bool,
        uniquingKeysWith combine: (Element, Element) -> Element
    ) -> [Element] {
        var result: [Element] = self
        
        for element in collection {
            if let index = result.firstIndex(where: { projection($0, element) }) {
                let uniqued = combine(element, result[index])
                result[index] = uniqued
            } else {
                result.append(element)
            }
        }
        return result
    }
}
