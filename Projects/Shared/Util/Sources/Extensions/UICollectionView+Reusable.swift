//
//  UICollectionView+Reusable.swift
//  SharedUtil
//
//  Created by 지연 on 10/20/24.
//

import UIKit

extension UICollectionView {
    public final func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: Reusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    public final func dequeueReusableCell<Cell: UICollectionViewCell>(
        for indexPath: IndexPath,
        cellType: Cell.Type = Cell.self
    ) -> Cell where Cell: Reusable {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        return cell
    }
}
