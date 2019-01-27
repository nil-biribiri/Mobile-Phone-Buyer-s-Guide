//
//  UICollectionView.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 28/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.stringClass
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.stringClass, for: indexPath) as? T
    }


}
