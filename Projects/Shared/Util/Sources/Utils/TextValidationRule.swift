//
//  TextValidationRule.swift
//  SharedUtil
//
//  Created by 지연 on 10/19/24.
//

import Foundation

public protocol TextValidationRule {
    func validate(_ text: String) -> Bool
    var errorMessage: String { get }
}

public struct LengthValidationRule: TextValidationRule {
    public let maxLength: Int
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.maxLength = Constants.maxNameLength
        self.errorMessage = errorMessage
    }
    
    public func validate(_ text: String) -> Bool {
        return text.count > 0 && text.count <= maxLength
    }
}

public struct WhitespaceValidationRule: TextValidationRule {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(_ text: String) -> Bool {
        return !text.contains(" ")
    }
}
