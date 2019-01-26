//
//  DetailLabel.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 27/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

class DetailLabel: UILabel {

    @IBInspectable var size: CGFloat = 14.0 {
        didSet {
            setFont()
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    func commonInit(){
        self.setFont()
        self.textColor = .gray
        self.numberOfLines = 0
        self.setNeedsDisplay()
    }

    private func setFont() {
        self.font = UIFont.systemFont(ofSize: size)
    }

}
