//
//  DetailCollectionViewCell.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 28/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

protocol DetailCollectionViewCellConfigureProtocol {
    func configure(withImagePath imagePath: String)
}

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: ImageCaching!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension DetailCollectionViewCell: DetailCollectionViewCellConfigureProtocol {
    func configure(withImagePath imagePath: String) {
        imageView.imageCaching(link: imagePath,
                               contentMode: .scaleAspectFit,
                               withDownloadIndicator: true)
    }

}
