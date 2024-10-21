//
//  TextValidator.swift
//  SharedUtil
//
//  Created by 지연 on 10/19/24.
//

import Foundation

public protocol TextValidator {
    var rules: [TextValidationRule] { get }
    func validate(_ text: String) -> String?
}

public final class NameValidator: TextValidator {
    public var rules: [TextValidationRule]
    
    public init() {
        rules = [
            LengthValidationRule(errorMessage: "1~\(Constants.maxNameLength)자의 이름을 사용해주세요"),
            WhitespaceValidationRule(errorMessage: "공백은 사용할 수 없어요")
        ]
    }
    
    public func validate(_ text: String) -> String? {
        for rule in rules {
            if !rule.validate(text) {
                return rule.errorMessage
            }
        }
        return nil
    }
}
