//
//  UITableView+setBackgroundMessage.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import UIKit

extension UITableView {
    func setBackgroundMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func removeBackgroundMessage() {
        self.backgroundView = nil
    }
}
