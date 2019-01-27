//
//  ListTableViewCell.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

protocol ListTableViewCellConfigureProtocol {
    func configure(with viewModel: List.DeviceList.ViewModel.DisplayPhone)
    func configure(with viewModel: Favorite.FavoriteList.ViewModel.DisplayPhone)
}

protocol ListTableViewCellProtocol: class {
    func favoriteButtonDidSelected(id: Int)
}

class ListTableViewCell: UITableViewCell {
    private var id: Int = 0
    weak var delegate: ListTableViewCellProtocol?

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
            favoriteButton <-< {
                $0.addTarget(self, action: #selector(favoriteButtonAction(_:)), for: .touchUpInside)
            }
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

    @objc func favoriteButtonAction(_ sender: UIButton) {
        delegate?.favoriteButtonDidSelected(id: id)
    }

    func configureFavoriteButtonImage(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "favoriteActive")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favoriteInactive")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
}

extension ListTableViewCell: ListTableViewCellConfigureProtocol {
    func configure(with viewModel: List.DeviceList.ViewModel.DisplayPhone) {
        id = viewModel.id
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        ratingLabel.text = viewModel.rating
        thumbnailImage.imageCaching(link: viewModel.thumbnailPath,
                                    contentMode: .scaleAspectFill,
                                    withDownloadIndicator: true)
        configureFavoriteButtonImage(isFavorite: viewModel.isFavorite)
    }
    func configure(with viewModel: Favorite.FavoriteList.ViewModel.DisplayPhone) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        ratingLabel.text = viewModel.rating
        thumbnailImage.imageCaching(link: viewModel.thumbnailPath,
                                    contentMode: .scaleAspectFill,
                                    withDownloadIndicator: true)
        favoriteButton.isHidden = true
    }
}
