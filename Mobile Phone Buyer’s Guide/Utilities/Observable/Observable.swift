//
//  Observable.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 27/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> ()
    private var listener: Listener?
    private var queue: DispatchQueue = DispatchQueue.main

    var value: T {
        didSet {
            fire()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(withQueue queue: DispatchQueue = DispatchQueue.main, _ listener: Listener?) {
        self.listener = listener
        self.queue = queue
    }

    func bindAndFire(withQueue queue: DispatchQueue = DispatchQueue.main, _ listener: Listener?) {
        self.listener = listener
        self.queue = queue
        fire()
    }

    func removeObserver() {
        listener = nil
    }

    private func fire() {
        self.queue.async {
            self.listener?(self.value)
        }
    }

}
