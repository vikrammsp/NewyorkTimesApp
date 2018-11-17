//
//  HeaderView.swift
//  NewyorkTimesApp
//


import UIKit

class HeaderView: UIView {

    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonDots: UIButton!

    override func draw(_ rect: CGRect) {
        // Drawing code
        //self.textFieldRecipeName.setBottomBorder()
    }


    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
 
}


extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
