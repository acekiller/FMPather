//
//  FMPather.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public typealias FMMediatorPrepareBlock<T> = (T) -> Void

public class FMPather {
    fileprivate var mediators = [FMMediator]()
    
    public static let pather = FMPather()
    public let defaultMediator = FMMediator(scheme: String.appScheme, host: String.appHost)
    
    init() {
        mediators.append(defaultMediator)
    }
}

public extension FMPather {
    
    public func register(scheme: String,
                         host: String,
                         regex: String = ":[a-z,A-Z,0-9,_]+")
        -> FMMediator {
            if !hasMediator(scheme: scheme, host: host) {
                return mediators.mediator(scheme: scheme, host: host)!
            }
            return addMeditor(scheme: scheme, host: host, regex: regex)
    }
    
    public func mediator(scheme: String, host: String) -> FMMediator? {
        return mediators.mediator(scheme:scheme, host:host)
    }
    
    public func registerRestful<T: NSObject>(restfulPath: String,
                                builder: @escaping (FMPatherPage)->T) -> FMPatherError
    {
        return mediator(scheme: restfulPath.scheme, host: restfulPath.host)?.registerRestful(restfulPath: restfulPath, builder: builder) ?? .registerFailed
    }
    
    public func object<T: NSObject>(for path: String, prepare block: FMMediatorPrepareBlock<T>)-> T? where T: FMPatherPathData {
        let m = mediator(scheme: path.scheme, host: path.host)
        guard let object = m?.object(for: path) as? T else {
            return nil
        }
        object.querys = m!.querys(for: path)
        object.dynamicNode = m!.dynamicPathComponents(for: path)
        object.url = path
        block(object)
        return object
    }
    
    public func controller<T: UIViewController>(for path: String, prepare block: FMMediatorPrepareBlock<T>) -> T? where T: FMPatherPathData {
        return object(for: path, prepare: block)
    }
    
    public func mediatorPage<T: UIViewController>(for path: String,
                             fromController: UIViewController? = nil,
                             mediatorAction: FMMediatorAction = FMMediatorAction(mediatorType: .push),
    prepare block: FMMediatorPrepareBlock<T> = {_ in}) where T: FMPatherPathData {
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
