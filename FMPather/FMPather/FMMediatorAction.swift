//
//  FMMediatorAction.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public class FMMediatorAction {
    public enum FMMediatorType {
        case push
        case present
    }
    
    fileprivate var mediatorType: FMMediatorType
    
    public init(mediatorType: FMMediatorType) {
        self.mediatorType = mediatorType
    }
    
    public func mediator(from: UIViewController?, to: UIViewController) {
        mediatorType.mediator(from: from, to: to)
    }
}

fileprivate extension FMMediatorAction.FMMediatorType {
    func mediator(from: UIViewController?, to: UIViewController) {
        switch self {
        case .push:
            pushController(from: from ?? top(), to: to)
        case .present:
            presentController(from: from ?? top(), to: to)
        }
    }
    
    func pushController(from: UIViewController?, to: UIViewController) {
        //FIXME: 更多的动画或者相关操作属性可以基于MediatorAction来实现
        assert(from != nil, "from is NULL")
        assert(from!.navigationController != nil, "from's navigationController is NULL")
        from!.navigationController?.pushViewController(to,
                                                      animated: true)
    }
    
    func presentController(from: UIViewController?, to: UIViewController) {
        //FIXME: 更多的动画或者相关操作属性可以基于MediatorAction来实现
        from?.present(to,
                     animated: true) { 
                        debugPrint("did shown")
        }
    }
    
    func top() -> UIViewController? {
        var result = top(controller: UIApplication.shared.keyWindow!.rootViewController)
        while result?.presentedViewController != nil {
            result = top(controller: result?.presentedViewController)
        }
        return result
    }
    
    func top(controller: UIViewController?) -> UIViewController? {
        assert(controller != nil, "controller is NULL")
        if controller is UINavigationController {
            return top(controller:(controller as! UINavigationController).topViewController)
        } else if controller is UITabBarController {
            return top(controller:(controller as! UITabBarController).selectedViewController)
        } else {
            return controller
        }
    }
}
