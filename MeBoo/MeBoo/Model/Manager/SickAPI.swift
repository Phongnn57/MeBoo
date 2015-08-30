//
//  SickAPI.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/4/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class SickAPI: NSObject {
   
    
    class func createSickUser(patientID: Int, sick: [Int]!, completion:()-> Void, failure:(error: String) ->Void) {
        
        var params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params["patient_id"] = patientID
        params["sicks"] = sick
        
        ModelManager.shareManager.postRequest(AppConstant.API.KEYs.Sick_CreateSickUser, params: params, success: { (responseData) -> Void in
            print(responseData)
            completion()
            }) { (errorMessage) -> Void in
                failure(error: errorMessage)
        }
    }

}
