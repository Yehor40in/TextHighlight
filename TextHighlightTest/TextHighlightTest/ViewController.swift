//
//  ViewController.swift
//  TextHighlightTest
//
//  Created by Yehor Sorokin on 07.02.2020.
//  Copyright © 2020 Yehor Sorokin. All rights reserved.
//

import UIKit
import Foundation

final class ViewController: UIViewController {
    
    var contentView: ContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
    }
    
    private func setupContentView() -> Void {
        let text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        contentView = ContentView(frame: view.frame)
        contentView.message = text
        view.addSubview(contentView)
    }
    
}
