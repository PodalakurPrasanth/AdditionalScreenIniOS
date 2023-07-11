//
//  IMLoadingView.swift
//  IMcash
//
//  Created by Clapping Ape on 08/11/19.
//  Copyright © 2019 Indosat. All rights reserved.
//

import UIKit

class IMLoadingView: UIView {

    let kCONTENT_XIB_NAME = "IMLoadingView"
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
    }

}
