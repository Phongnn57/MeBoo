//
//  ModelManager.swift
//  Sổ Y Bạ
//
//  Created by Nam Phong on 7/16/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import UIKit

class ModelManager: NSObject {
    static let shareManager = ModelManager(baseURL: AppConstant.API.URLs.BaseURL)
    
    var mainManager:AFHTTPRequestOperationManager!
    
    init(baseURL:String) {
        super.init()
        
        mainManager = AFHTTPRequestOperationManager(baseURL: NSURL(string: baseURL))
        mainManager.responseSerializer = AFJSONResponseSerializer()
        mainManager.requestSerializer = AFJSONRequestSerializer()
        mainManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        mainManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}