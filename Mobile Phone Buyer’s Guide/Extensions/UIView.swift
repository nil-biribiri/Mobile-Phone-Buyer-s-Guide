//
//  UIView.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

extension UIView {
    func addSubview( _ subview: UIView,
                     attachedTo anchorsView: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
            subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
            ])
    }
}
