//
//  ListInteractor.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright (c) 2562 NilNilNil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Realm
import RealmSwift

protocol ListBusinessLogic {
    func fetchPhoneList(request: List.DeviceList.Request)
    func setFavoritePhone(withId id: Int)
}

protocol ListDataStore {
    var phoneList: [Phone] { get }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    var presenter: ListPresentationLogic?
    var worker = ListWorker()
    var phoneList: [Phone] = []
    var request: List.DeviceList.Request?
    var phoneListToken: NotificationToken? = nil
    var sortToken: NotificationToken? = nil

    deinit {
        phoneListToken?.invalidate()
        sortToken?.invalidate()
    }

    // MARK: Do something
    func fetchPhoneList(request: List.DeviceList.Request) {
        presenter?.showLoading()
        self.request = request
        var response = List.DeviceList.Response()
        worker.fetchPhoneList(withPredicate: request.fetchPridicate) { [weak self] (result) in
            switch result {
            case .success(let value):
                response.phoneList = value
                self?.phoneList = value
            case .failure(let error):
                response.errorMessage = error.localizedDescription
            }
            self?.presenter?.presentPhoneList(response: response)
            self?.setObserver()
        }
    }

    func setFavoritePhone(withId id: Int) {
        worker.setFavorite(withId: id)
    }

    func setObserver() {
        phoneListToken = worker.getObervePhoneList()?.observe({ [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .update(_, _, _, _) :
                guard let request = self?.request,
                    let updatedPhoneList = self?.worker.loadPhoneList(withPredicate: request.fetchPridicate) else { return }
                self?.phoneList = updatedPhoneList
                let response = List.DeviceList.Response.init(phoneList: updatedPhoneList, errorMessage: nil)
                self?.presenter?.presentPhoneList(response: response)
            default:
                break
            }
        })


        sortToken = worker.getOberveSort()?.first?.observe({ [weak self] (change) in
            switch change {
            case .change(let predicate):
                if let updatedPredicate = PhoneStore.Predicate.init(rawValue: predicate.first?.newValue as! Int) {
                    self?.request? = List.DeviceList.Request.init(withPredicate: updatedPredicate)
                    let updatedPhoneList = self?.worker.loadPhoneList(withPredicate: updatedPredicate)
                    let response = List.DeviceList.Response.init(phoneList: updatedPhoneList, errorMessage: nil)
                    self?.presenter?.presentPhoneList(response: response)
                }
            default:
                break
            }
        })
    }

}
