//
//  TabBarMenuWireframe.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class TabBarMenuWireframe: BaseWireframe, TabBarMenuWireframeContract {
    weak var output: TabBarMenuWireframeOutputContract!
    weak var view: UIViewController!

    weak var loadingDelegate: LoadingViewDelegate!
    

    /// Show basic loading
    /// - Parameters:
    ///   - text: text
    func showBasicLoading(text: String) {
        let loadingVC = LoadingViewController()
        self.loadingDelegate = loadingVC
        
        self.presentView(from: self.view, useCase: loadingVC, withTransition: .modal,
                         modalPresentationStyle: .overCurrentContext, animated: false, completion: {
            loadingVC.updateTitle(with: text)
        })
    }
    
    /// Hide basic loading
    func hideBasicLoading(completion: @escaping (() -> Void)) {
        self.loadingDelegate?.dismiss {
            completion()
        }
    }
    
}
