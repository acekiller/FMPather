//
//  FMPather.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public typealias FMMediatorPrepareBlock = (AnyObject) -> Void

public class FMPather {
    fileprivate var mediators = [FMMediator]()
    
    public static let `default` = FMPather()
    public let defaultMediator = FMMediator(scheme: String.appScheme, host: String.appHost)
    
    init() {
        mediators.append(defaultMediator)
    }
}

public extension FMPather {
     /**
     注册支持的路由、对应主机和动态路由的匹配规则。
     :param scheme 支持的路由协议，与
     */
    public func register(scheme: String,
                         host: String,
                         regex: String = ":[a-z,A-Z,0-9,_]+")
        -> FMMediator {
            if hasMediator(scheme: scheme, host: host) {
                return mediators.mediator(scheme: scheme, host: host)!
            }
            return addMeditor(scheme: scheme, host: host, regex: regex)
    }
    /**
     获取指定协议及主机的路由调节器
     */
    public func mediator(scheme: String, host: String) -> FMMediator? {
        if defaultMediator.scheme == scheme && defaultMediator.host == host {
            return defaultMediator
        }
        return mediators.mediator(scheme:scheme, host:host)
    }
    /**
     注册需要监听的路由地址,如果监听的路由scheme和host没有注册，将返回 .registerFailed错误
     */
    public func registerRestful(restfulPath: String,
                                builder: @escaping (FMPatherPage)->AnyObject) -> FMPatherError
    {
        return mediator(scheme: restfulPath.scheme, host: restfulPath.host)?.registerRestful(restfulPath: restfulPath, builder: builder) ?? .registerFailed
    }
    
    /**
     获取路由目标对象
     */
    public func object(for path: String, prepare block: FMMediatorPrepareBlock)-> AnyObject? {
        let m = mediator(scheme: path.scheme, host: path.host)
        guard let object = m?.object(for: path) else {
            return nil
        }
//        object.querys = m!.querys(for: path)
//        object.dynamicNode = m!.dynamicPathComponents(for: path)
//        object.url = path
        block(object)
        return object
    }
    
    /**
     获取路由目标Controller
     */
    public func controller(for path: String, prepare block: FMMediatorPrepareBlock) -> UIViewController? {
        return object(for: path, prepare: block) as? UIViewController
    }
    
    /**
     跳转到指定路由对应的Controller
     */
    public func mediatorPage(for path: String,
                             fromController: UIViewController? = nil,
                             mediatorAction: FMMediatorAction = FMMediatorAction(mediatorType: .push),
    prepare block: FMMediatorPrepareBlock = {_ in}) {
        let destnationController = controller(for: path, prepare: block)
        guard let destnation = destnationController else {
            return
        }
        
        mediatorAction.mediator(from: fromController, to: destnation)
    }
}

/**
 *  FMPather私有方法
 */
fileprivate extension FMPather {
    fileprivate func hasMediator(scheme: String, host: String) -> Bool {
        return mediators.mediator(scheme: scheme, host: host) != nil
    }
    
    fileprivate func addMeditor(scheme: String, host: String, regex: String) -> FMMediator {
        let mediator = FMMediator(scheme: scheme, host: host, regex: regex)
        mediators.append(mediator)
        return mediator
    }
}

/**
 *  mediator数组查询处理方式
 */
fileprivate extension Array where Element == FMMediator {
    fileprivate func mediator(scheme: String, host: String) -> FMMediator? {
        return self.filter {$0.scheme == scheme && $0.host == host}.first
    }
}
