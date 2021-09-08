////
////  RequestManager.swift
////  NMNetwork
////
////  Created by flowerflower on 2021/8/26.
////
//
//import Foundation
//import Alamofire
//class RequestManager {
//    static let shared = RequestManager()
//    private var requestTasks = [String: RequestTaskManager]()
//    private var timeoutIntervalForRequest: TimeInterval? /// 超时时间
//    
//    func timeoutIntervalForRequest(_ timeInterval :TimeInterval) {
//        self.timeoutIntervalForRequest = timeInterval
//        RequestManager.shared.timeoutIntervalForRequest = timeoutIntervalForRequest
//        
//    }
//    func request(_ url: String,
//                 method:HTTPMethod = .get,
//                 params:Parameters? = nil,
//                 encoding: ParameterEncoding = URLEncoding.default,
//                 headers:HTTPHeaders? = nil) ->RequestTaskManager{
//        
//        let key = cacheKey(url, params)
//        var taskManager : RequestTaskManager?
//        if requestTasks[key] == nil {
//            if timeoutIntervalForRequest != nil {
//                taskManager = RequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
//            }else{
//                taskManager = RequestTaskManager()
//            }
//            requestTasks[key] = taskManager
//        }else{
//            taskManager = requestTasks[key]
//        }
//        taskManager?.completionClosure = {
//            self.requestTasks.removeValue(forKey: key)
//        }
//        taskManager?.request(url, method: method, params: params==nil ? [:] : params!, cacheKey: "", encoding: encoding, headers: headers)
//        return taskManager!
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    /// 取消请求
//    func cancel(_ url: String,params:Parameters? = nil){
//        let key = cacheKey(url, params)
//        let taskManager = requestTasks[key]
//        taskManager?.dataRequest?.cancel()
//        
//    }
//    
//    /// 清除所有缓存
//    
//    
//    ///根据key值清除缓存
//    
//    
//    
//    
//}
///// MARK: - 请求任务
//public class RequestTaskManager {
//    fileprivate var dataRequest:DataRequest?
//    fileprivate var cache: Bool = false
//    fileprivate var cacheKey: String!
//    fileprivate var sessionManager: SessionManager?
//    fileprivate var completionClosure: (()->())?
//
//    @discardableResult
//    fileprivate func timeoutIntervalForRequest(_ timeInterval :TimeInterval) -> RequestTaskManager {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = timeInterval
//        let sessionManager = Alamofire.SessionManager(configuration: configuration)
//        self.sessionManager = sessionManager
//        return self
//    }
//    
//    @discardableResult
//    fileprivate func request(_ url:String,
//                             method:HTTPMethod = .get,
//                             params:Parameters? = nil,
//                             cacheKey:String,
//                             encoding:ParameterEncoding = URLEncoding.default,
//                             headers:HTTPHeaders? = nil) -> RequestTaskManager{
//        
//        self.cacheKey = cacheKey
//        if sessionManager != nil {
//            dataRequest = sessionManager?.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
//        }else{
//            dataRequest = SessionManager.default.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
//        }
//        return self
//    }
//    
//    /// request
//    ///
//    /// - Parameters:
//    ///   - urlRequest: urlRequest
//    ///   - cacheKey: cacheKey
//    /// - Returns: RequestTaskManager
//    @discardableResult
//    fileprivate func request(
//        urlRequest: URLRequestConvertible,
//        cacheKey: String)
//        -> RequestTaskManager {
//            self.cacheKey = cacheKey
//            if sessionManager != nil {
//                dataRequest = sessionManager?.request(urlRequest)
//            } else {
//                dataRequest = SessionManager.default.request(urlRequest)
//            }
//        return self
//    }
//    
//}
//
