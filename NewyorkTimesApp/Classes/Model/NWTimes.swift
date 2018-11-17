//
//  NWTimes.swift
//  NewyorkTimesApp
//

import UIKit
import SwiftyJSON

class NWTimes: NSObject {
    var abstract: String!
    var adx_keywords: String!
    var byline: String!
    var media = [Media]()
    var published_date: String!
    var section: String!
    var source: String!
    var title: String!
    var type: String!
    var url: String!
    var views: String!
}
