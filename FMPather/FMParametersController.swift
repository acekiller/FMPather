//
//  FMParametersController.swift
//  FMPather
//
//  Created by fantasy on 2017/10/6.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class FMParametersController: UIViewController, FMPatherPathData {
    var querys: [String : String] = [:]
    var dynamicNode: [String : String] = [:]
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parameters"
        debugPrint("url: \(url)")
        debugPrint("querys: \(querys)")
        debugPrint("dynamicNode: \(dynamicNode)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
