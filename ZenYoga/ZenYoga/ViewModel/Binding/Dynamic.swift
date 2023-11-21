//
//  Dynamic.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 21/11/2023.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listner: Listener?
    
    func bind(_ listner: Listener?){
        self.listner = listner
    }
    
    var value: T { didSet { listner?(value) } }
    
    init(_ v:T) { value = v }
}
