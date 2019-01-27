//
//  FavoritePresenter.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 27/1/2562 BE.
//  Copyright (c) 2562 NilNilNil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FavoritePresentationLogic: BasePresenterLogic {
    func presentSomething(response: Favorite.FavoriteList.Response)
}

class FavoritePresenter: BasePresenter, FavoritePresentationLogic {
    weak var viewController: FavoriteDisplayLogic? {
        didSet{
            baseViewController = viewController
        }
    }
    // MARK: Do something
    func presentSomething(response: Favorite.FavoriteList.Response) {
        defer { hideLoading() }
        var viewModel = Favorite.FavoriteList.ViewModel(displayPhone: [])
        if let favoritePhoneList = response.favoritePhoneList {
            favoritePhoneList.forEach {
                let favoriteModel = Favorite.FavoriteList.ViewModel.DisplayPhone(id: $0.id,
                                                                        name: $0.name,
                                                                        description: $0._description,
                                                                        price: "Price: $\(String(format: "%.2f", $0.price))",
                    rating: "Rating: \($0.rating)",
                    thumbnailPath: $0.thumbImageURL)
                viewModel.displayPhone.append(favoriteModel)
            }
            viewController?.displayFavoriteList(viewModel: viewModel)
        }
//        else if let errorMessage = response.errorMessage {
//            let error = List.DeviceList.Error(errorMessage: errorMessage)
//            viewController?.displayError(error: error)
//        }
    }
}
