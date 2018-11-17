
//
//  ViewController.swift
//  NewyorkTimesApp
//

import UIKit
import ZVProgressHUD
import SwiftyJSON
import SBPickerSelector

class ViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,SBPickerSelectorDelegate {

    @IBOutlet weak var tableViewTimes: UITableView!
    var strSelectedPeriod = "1"
    var arrPeriod = ["1","7", "30"]
    
    var arrNewsTimes : NSMutableArray = NSMutableArray()
    
    //---------------------------------------------------------------------------------------------
    // MARK:  View LifeCycle Methods
    //---------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrNewsTimes = NSMutableArray()
        self.getNWTimesData()
        self.setCustomValues()
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK:  Custom Methods
    //---------------------------------------------------------------------------------------------
    
    func getNWTimesData()
    {
        self.arrNewsTimes.removeAllObjects()
        ZVProgressHUD.show()
        let dictParams = ["period":strSelectedPeriod] as NSMutableDictionary
        ServerRequest.sendServerRequest_GET(dictParams ) { (response, isSuccess) in
            if isSuccess == true
            {
                ZVProgressHUD.dismiss()
                
                let dictRes = JSON(response.result.value ?? "")
                let arrRes =  dictRes["results"].array
                for dict in arrRes!
                {
                    // Parsing data from server to user defined classes to have clear picture of server response
                    
                    let objNWTimes = NWTimes()
                    objNWTimes.abstract = dict["abstract"].string
                    objNWTimes.adx_keywords = dict["adx_keywords"].string
                    objNWTimes.byline = dict["byline"].string

                    var arr =  dict["media"].array
                    let strCaption =  arr![0]["caption"].string
                    let strCopyright =  arr![0]["copyright"].string
                   
                    let arrMetadata =  arr![0]["media-metadata"].array
                    
                    var arrMetadaTemp = [MediaMetadata]()
                    
                    for dict in arrMetadata!{
                        let objMetadata = MediaMetadata()
                        objMetadata.url = dict["url"].string!
                        objMetadata.format = dict["format"].string!
                        arrMetadaTemp.append(objMetadata)
                    }
                    
                    let objMedia = Media()
                    objMedia.caption = strCaption
                    objMedia.copyright = strCopyright
                    objMedia.mediametadata = arrMetadaTemp

                    objNWTimes.media = [objMedia]
                    objNWTimes.published_date = dict["published_date"].string
                    objNWTimes.section = dict["section"].string
                    objNWTimes.source = dict["source"].string
                    objNWTimes.title = dict["title"].string
                    objNWTimes.type = dict["type"].string
                    objNWTimes.url = dict["url"].string
                    objNWTimes.views = dict["views"].string
                    self.arrNewsTimes.add(objNWTimes)
                }
                self.tableViewTimes.reloadData()
                print(self.arrNewsTimes.count)
                if self.arrNewsTimes.count == 0{
                    self.displayAlertWithOk(message: "No articles found.\n Please change your period to fetch different articles.")
                    return
                }
            }
        }
    }
    
    //---------------------------------------------------------------------------------------------
    
    func setCustomValues(){
        objHeaderView.buttonDots.addTarget(self, action: #selector(buttonDotsClicked), for: .touchUpInside)
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK: Custom Action Methods
    //---------------------------------------------------------------------------------------------
    
    @IBAction func buttonDotsClicked(_ sender: Any) {
        let picker: SBPickerSelector = SBPickerSelector()
        picker.pickerData =  arrPeriod
        picker.tag = 1
        picker.delegate = self
        picker.pickerType = .text
        picker.doneButtonTitle = "Done"
        picker.cancelButtonTitle = "Cancel"
        picker.showPicker(from: self.view, in: self)
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK: UITableView Delegate Methods
    //---------------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  self.arrNewsTimes.count
    }
    
    //---------------------------------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    //---------------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120
    }
    
    //---------------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : NWTimesCell = tableView.dequeueReusableCell(withIdentifier: "NWTimesCell", for: indexPath ) as! NWTimesCell
        
        let objNWTimes = self.arrNewsTimes.object(at: indexPath.row) as! NWTimes
     
        cell.labelTitle.text = objNWTimes.abstract
        cell.labelByLine.text =  objNWTimes.byline
        cell.labelName.text =  objNWTimes.source
        cell.labelDate.text =  objNWTimes.published_date
   
        // Following code placed for loading the zero indexed image.
        
        if objNWTimes.media.count > 0
        {
            let arrMetaDataTemp = objNWTimes.media[0].mediametadata
            if arrMetaDataTemp.count > 0 {
                let strFullURL = objNWTimes.media[0].mediametadata[0].url
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData:NSData = NSData(contentsOf: URL(string: strFullURL)!)!
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData as Data)
                        cell.imageViewProfile.image = image
                    }
                }
            }
        }
        
        cell.imageViewProfile.clipsToBounds = true
        return cell
    }
    
    //---------------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        objDetailsViewController.objNWTimes = self.arrNewsTimes.object(at: indexPath.row) as! NWTimes
        self.navigationController?.pushViewController(objDetailsViewController, animated: true)
    }
    
    // ------------------------------------------------------------------------------------------------------------------
    // MARK: - SBPickerSelector Delegate Methods
    // ------------------------------------------------------------------------------------------------------------------
    
    func pickerSelector(_ selector: SBPickerSelector, selectedValues values: [String], atIndexes idxs: [NSNumber])
    {
        let m = idxs[0] as! Int // m is an `Int64`
        strSelectedPeriod =  (selector.pickerData[m] as? String)!
        self.getNWTimesData()
    }
    
    // ------------------------------------------------------------------------------------------------------------------
    
    func pickerSelector(_ selector: SBPickerSelector, cancelPicker cancel: Bool)
    {
        selector.dismiss(animated: true, completion: nil)
    }
    //---------------------------------------------------------------------------------------------
    
    
    
}

