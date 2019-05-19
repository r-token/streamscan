//
//  API.swift
//  Streamr
//
//  Created by Ryan Token on 5/8/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class API {
    
    func getChannels(from service: String, priceCompletionHandler: @escaping (String?) -> (), channelCompletionHandler: @escaping ([String]?) -> ()) {
        
        Alamofire.request("https://polar-tor-80040.herokuapp.com/api/" + service)
            
            .responseJSON { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching channels: \(String(describing: response.result.error))")
                        channelCompletionHandler(nil)
                        return
                }
                
                // successfully received the data, continue on
                let results = JSON(value).dictionary
                
                let price = results?["Price"]?.stringValue
                let channels = results?["Channels"]?.array?.map { json in
                    json.stringValue
                }
                
                priceCompletionHandler(price)
                channelCompletionHandler(channels)
        }
    }
    
}
