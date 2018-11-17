//
//  BaseViewController.swift
//  NewyorkTimesApp
//

import UIKit
import Alamofire
import SwiftyJSON

class BaseViewController: UIViewController
{
    var objHeaderView = HeaderView()

   static let shared: BaseViewController = BaseViewController()

    @IBOutlet weak var layoutConstraint_HeaderViewTopSpace: NSLayoutConstraint!

    //---------------------------------------------------------------------------------------------
    // MARK: View LifeCycle Methods
    //---------------------------------------------------------------------------------------------

    override func viewDidLoad()
    {
        super.viewDidLoad()
        objHeaderView = HeaderView.instanceFromNib() as! HeaderView
        objHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 90)
        self.view.addSubview(objHeaderView)
        objHeaderView.buttonMenu.addTarget(self, action: #selector(buttonMenuClicked), for: .touchUpInside)
   }
    
    //---------------------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool)
    {

    }
    
    //---------------------------------------------------------------------------------------------
    // MARK: Custom Action Methods
    //---------------------------------------------------------------------------------------------

    func displayAlertForNoInternet() {
        let alert = UIAlertController(title: KConstant.kAPPName, message:"Please check your internet conncetion and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    //---------------------------------------------------------------------------------------------
    
    class func checkIntenetConnection(completion:@escaping(_ isNetworkAvailable : Bool) ->())
    {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
        if !(reachabilityManager?.isReachable)!
        {
            let alert = UIAlertController(title: KConstant.kAPPName, message:"Please check your internet conncetion and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                alert.dismiss(animated: true, completion: nil)
            })
            //  KConstant.APP.window?.rootViewController?.present(alert, animated: true, completion: nil)
            completion(false)
            return
        }else{
            completion(true)
        }
    }
    //---------------------------------------------------------------------------------------------
    // MARK: Custom Action Methods
    //---------------------------------------------------------------------------------------------

    @IBAction func buttonMenuClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //---------------------------------------------------------------------------------------------

    func displayAlertWithOk(message: String) {
        let alert = UIAlertController(title: KConstant.kAPPName, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    //---------------------------------------------------------------------------------------------

}




