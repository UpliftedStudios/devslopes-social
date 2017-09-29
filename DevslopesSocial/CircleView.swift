//
//  CircleView.swift
//  DevslopesSocial
//
//  Created by Raphael M. Hidalgo on 9/23/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
