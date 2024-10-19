//
//  MonthlyRecordView.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

public final class MonthlyRecordView: UIView {
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint.withAlphaComponent(0.1)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
