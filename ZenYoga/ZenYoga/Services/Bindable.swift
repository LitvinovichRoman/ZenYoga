//
//  Bindable.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 05/02/2024.
//

import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T { didSet { listener?(value) } }
    init(_ v: T) { value = v }
    func bind(listener: Listener?) { self.listener = listener; listener?(value) }
}
