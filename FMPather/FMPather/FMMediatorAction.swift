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
    
    public func mediator<T: UIViewController>(from: UIViewController?, to: T) {
        mediatorType.mediator(from: from, to: to)
    }
}

fileprivate extension FMMediatorAction.FMMediatorType {
    func mediator<T: UIViewController>(from: UIViewController?, to: T) {
        switch self {
        case .push:
            pushController(from: from ?? defaultController(isPush: true), to: to)
        case .present:
            presentController(from: from ?? defaultController(isPush: false), to: to)
        }
    }
    
    func pushController<T: UIViewController>(from: UIViewController, to: T) {
        //FIXME: 更多的动画或者相关操作属性可以基于MediatorAction来实现
        from.navigationController?.pushViewController(to,
                                                      animated: true)
    }
    
    func presentController<T: UIViewController>(from: UIViewController, to: T) {
        //FIXME: 更多的动画或者相关操作属性可以基于MediatorAction来实现
        from.present(to,
                     animated: true) { 
                        debugPrint("did shown")
        }
    }
    
    func defaultController(isPush: Bool) -> UIViewController {
        //        TODO: 需要修改为需要的Controller
        return UIViewController()
    }
}
