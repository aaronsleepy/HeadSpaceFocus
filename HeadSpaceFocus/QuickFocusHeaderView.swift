//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by Aaron on 2022/11/25.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
