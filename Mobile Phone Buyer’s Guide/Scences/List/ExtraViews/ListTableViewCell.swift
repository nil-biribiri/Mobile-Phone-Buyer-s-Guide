//
//  ListTableViewCell.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

protocol ListTableViewCellProtocol {
    func configure(with viewModel: List.DeviceList.ViewModel.DisplayPhone)
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet private weak var thumbnailImage: ImageCaching!
    @IBOutlet private weak var titleLabel: TitleLabel!
    @IBOutlet private weak var descriptionLabel: DetailLabel! {
        didSet {
            descriptionLabel <-< {
                $0.numberOfLines = 2
                $0.lineBreakMode = .byTruncatingTail
            }
        }
    }
    @IBOutlet private weak var priceLabel: DetailLabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.setImage(#imageLiteral(resourceName: "favoriteUnactive"), for: .normal)
            favoriteButton.imageView?.tintColor = .blue
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectionStyle = .none
    }
    
}

extension ListTableViewCell: ListTableViewCellProtocol {
    func configure(with viewModel: List.DeviceList.ViewModel.DisplayPhone) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        ratingLabel.text = viewModel.rating
        thumbnailImage.imageCaching(link: viewModel.thumbnailPath,
                                    contentMode: .scaleAspectFill,
                                    withDownloadIndicator: true)
    }


}
