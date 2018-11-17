//
//  DetailsViewController.swift
//  NewyorkTimesApp
//

import UIKit
import SwiftyJSON

class DetailsViewController: BaseViewController
{
    var dictData = JSON().dictionary
    
    var objNWTimes = NWTimes()
    @IBOutlet weak var labelAbstract: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewPic: UIImageView!
    @IBOutlet weak var labelCopyright: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //---------------------------------------------------------------------------------------------
    // MARK:  View LifeCycle Methods
    //---------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomValues()
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK:  Custom Methods
    //---------------------------------------------------------------------------------------------
    
    
    func setCustomValues(){
            objHeaderView.buttonMenu.setImage(UIImage(named: "back_icon"), for: .normal)
   
            objHeaderView.labelTitle.text = objNWTimes.title

            labelAbstract.text = objNWTimes.abstract
  
            let formattedStringDate = NSMutableAttributedString()
            let formattedStringSource = NSMutableAttributedString()
            let formattedStringCopyright = NSMutableAttributedString()

            formattedStringSource.bold("Source : ").normal(objNWTimes.source)
            formattedStringDate.bold("Published Date : ").normal(objNWTimes.published_date)
        
            labelSource.attributedText = formattedStringSource
            labelDate.attributedText = formattedStringDate
        
            if objNWTimes.media.count > 0 {
                formattedStringCopyright.bold("Copyright : ").normal(objNWTimes.media[0].copyright)
                labelCopyright.attributedText = formattedStringCopyright
                let arrMetaDataTemp = objNWTimes.media[0].mediametadata
                if arrMetaDataTemp.count > 0 {
                    let strFullURL = objNWTimes.media[0].mediametadata[0].url
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData:NSData = NSData(contentsOf: URL(string: strFullURL)!)!
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData as Data)
                            self.imageViewPic.image = image
                            self.activityIndicator.isHidden = true
                        }
                    }
                }
            }
            self.hideControls(true)
    }
    
    //---------------------------------------------------------------------------------------------
    
    func hideControls(_ isHidden : Bool){
        objHeaderView.buttonDots.isHidden = isHidden
        objHeaderView.buttonSearch.isHidden = isHidden
        
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK: Custom Action Methods
    //---------------------------------------------------------------------------------------------
    
    @IBAction override func buttonMenuClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //---------------------------------------------------------------------------------------------
    
}

extension NSMutableAttributedString {
    
    //---------------------------------------------------------------------------------------------
    
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 14)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    //---------------------------------------------------------------------------------------------
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
    //---------------------------------------------------------------------------------------------
    
}
