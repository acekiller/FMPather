//
//  ViewController.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button1 = UIButton(type: .custom)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.setTitle("no params", for: .normal)
        button1.addTarget(self, action: #selector(testOneAction), for: .touchUpInside)
        button1.sizeToFit()
        button1.center = CGPoint(x: view.frame.size.width / 2.0, y: view.frame.size.height / 2.0)
        view.addSubview(button1)
        
        let button2 = UIButton(type: .custom)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.setTitle("params", for: .normal)
        button2.addTarget(self, action: #selector(testTwoAction), for: .touchUpInside)
        button2.sizeToFit()
        button2.center = CGPoint(x: view.frame.size.width / 2.0, y: view.frame.size.height / 2.0 + 50)
        view.addSubview(button2)
    }
    
    func testOneAction() {
        FMPather.default.mediatorPage(for: "demo://test/api/hello")
    }
    
    func testTwoAction() {
        FMPather.default.mediatorPage(for: "demo://test/api/aaa/hello?name=feng&address=四川")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

