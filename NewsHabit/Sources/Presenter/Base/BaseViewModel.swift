//
//  BaseViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import Combine
import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}
