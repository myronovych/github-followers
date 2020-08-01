//
//  UIHelper.swift
//  Github followers
//
//  Created by rs on 29.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

enum UIHelper {
    static func createThreeColumnsLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumSpaceBetweenColumns: CGFloat = 10
        let availableSpace = width - (padding * 2) - (minimumSpaceBetweenColumns * 2)
        let widthForCell = availableSpace / 3
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: widthForCell, height: widthForCell + 38)
        
        return layout
    }
}
