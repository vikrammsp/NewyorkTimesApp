//
//  ServerRequest.swift
//  NewyorkTimesApp
//

import UIKit
import Alamofire
import ZVProgressHUD
import SwiftyJSON


class ServerRequest: NSObject {

    
//----------------------------------------------------------------------------------------------------------------
    
    class func sendServerRequest_GET(_ dictData : NSMutableDictionary, completion:@escaping(_ response : DataResponse<Any>, _ isSuccess : Bool)->())
    {
        let strPeriod = dictData ["period"] as! String
       
        let strOtherURL = String(format: "%@.%@", strPeriod,KConstant.kServerPartURL)
        let strURL = KConstant.kServerURL + strOtherURL
        let manager = Alamofire.SessionManager.default
        
        BaseViewController.checkIntenetConnection{ (isConnected) in
            if (isConnected)
            {
                // sending request to fetch all news artiles from the server
                
                manager.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                    switch response.result{
                    case .success( _):
                        ZVProgressHUD.dismiss()
                        completion(response, true)
                        break
                    case .failure(let error):
                        ZVProgressHUD.dismiss()
                        print(error)
                        break
                    }
                }
            }
            else
            {
                    ZVProgressHUD.dismiss()
                    let alert = UIAlertController(title: KConstant.kAPPName, message:"Sorry, Could not get data from server!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            
                        return
                    })
                
            }
        }
        
    }
    
    //------------------------------------------------------------------------------------------------------------
    
}



