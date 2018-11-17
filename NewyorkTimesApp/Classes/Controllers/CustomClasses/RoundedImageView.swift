//
//  RoundedImageView.swift
//  NewyorkTimesApp
//


import UIKit

class RoundedImageView: UIImageView {

  
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
 

}
