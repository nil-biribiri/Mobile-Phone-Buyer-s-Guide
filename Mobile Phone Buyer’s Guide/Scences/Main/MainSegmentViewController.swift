//
//  MainSegmentViewController.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

class MainSegmentViewController: UIViewController {
    // MARK: - Properties
    enum Scenes: Int, CaseIterable {
        case list = 0
        case favorite

        var sceneTitle: String {
            switch self {
            case .list:
                return "All"
            case .favorite:
                return "Favorite"
            }
        }
    }
    private var currentScene: Scenes = .list {
        didSet {
            listVC.view.isHidden = !(currentScene == .list)
            favVC.view.isHidden = !(currentScene == .favorite)
        }
    }

    // MARK: - Constants
    let animateDuration = 0.3
    let segmentTitleFont = UIFont.systemFont(ofSize: 18.0)

    // MARK: - View elements
    private lazy var navSegmentControl: UISegmentedControl = {
        let navSegmentControl = UISegmentedControl() <-< { segment in
            Scenes.allCases.enumerated().forEach {
                segment.insertSegment(withTitle: $0.element.sceneTitle, at: $0.offset, animated: false)
            }
            segment.backgroundColor = .clear
            segment.tintColor = .clear
            segment.setTitleTextAttributes([
                NSAttributedString.Key.font : segmentTitleFont,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
                ], for: .normal)
            segment.setTitleTextAttributes([
                NSAttributedString.Key.font : segmentTitleFont,
                NSAttributedString.Key.foregroundColor: UIColor.black
                ], for: .selected)
            segment.selectedSegmentIndex = currentScene.rawValue
            segment.translatesAutoresizingMaskIntoConstraints = false
        }
        return navSegmentControl
    }()
    private lazy var selectedSegmentBar: UIView = {
        return UIView() <-< {
            $0.backgroundColor = .black
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    private lazy var listVC: UIViewController = {
        let listVC = UIViewController()
        listVC.view.backgroundColor = .gray
        listVC.view.translatesAutoresizingMaskIntoConstraints = false
        return listVC
    }()
    private lazy var favVC: UIViewController = {
        let favVC = UIViewController()
        favVC.view.backgroundColor = .blue
        favVC.view.translatesAutoresizingMaskIntoConstraints = false
        return favVC
    }()

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setChildsVC()
        setUI()
        setNavSegmentControl()
    }

    // MARK: - View Setup
    private func setChildsVC() {
        add(listVC)
        add(favVC)
    }

    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(navSegmentControl)
        view.addSubview(selectedSegmentBar)
        navSegmentControl <-< {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UITabBarController().tabBar.frame.height).isActive = true
        }
        selectedSegmentBar <-< {
            $0.topAnchor.constraint(equalTo: navSegmentControl.bottomAnchor).isActive = true
            $0.leftAnchor.constraint(equalTo: navSegmentControl.leftAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            $0.widthAnchor.constraint(equalTo: navSegmentControl.widthAnchor, multiplier: 1 / CGFloat(navSegmentControl.numberOfSegments)).isActive = true
        }
        listVC <-< {
            $0.view.topAnchor.constraint(equalTo: selectedSegmentBar.bottomAnchor).isActive = true
            $0.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        favVC <-< {
            $0.view.topAnchor.constraint(equalTo: selectedSegmentBar.bottomAnchor).isActive = true
            $0.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }

    private func setNavSegmentControl() {
        // Set initail selected scene state
        currentScene = .list
        // Add lister method for segment value change
        navSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let selectScene = Scenes.init(rawValue: sender.selectedSegmentIndex) else { return }
        currentScene = selectScene
        UIView.animate(withDuration: animateDuration) {
            self.selectedSegmentBar.frame.origin.x = (sender.frame.width / CGFloat(sender.numberOfSegments)) * CGFloat(sender.selectedSegmentIndex)
        }
    }

}

