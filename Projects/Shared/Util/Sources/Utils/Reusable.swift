//
//  Reusable.swift
//  SharedUtil
//
//  Created by 지연 on 10/20/24.
//

import Foundation

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
