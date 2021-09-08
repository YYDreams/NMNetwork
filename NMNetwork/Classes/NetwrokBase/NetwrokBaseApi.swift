//
//  NetwrokBaseApi.swift
//  Alamofire
//
//  Created by flowerflower on 2021/8/15.
//

import Foundation
import Alamofire
import DaisyNet


open class NetwrokBaseApi {
    open class var shared: NetwrokBaseApi {
        get {
            let instance = NetwrokBaseApi()
            instance.setConfig()
            return instance
        }
    }
    fileprivate func setConfig(){
        DaisyNet.openResultLog = false
        DaisyNet.openUrlLog = false
        /// 20s过期
        DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.seconds(20))
        /// 10s超时
        DaisyNet.timeoutIntervalForRequest(10)
        
    }
    
    // MARK: - 网络请求

    /// 网络请求
    ///
    /// - Parameters:
    ///   - url: url
    ///   - method: .get .post ...
    ///   - params: 参数字典
    ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
    ///   - encoding: 编码方式
    ///   - headers: 请求头
    /// - Returns:
    public func request(_ url:String,
                        method: HTTPMethod = .get,
                        params:Parameters? = nil,
                        dynamicParams: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil) -> RequestTaskManager{
        
        //formatNetworkParams(params)
        return  DaisyNet.request(url, method: method, params: params,dynamicParams:dynamicParams, encoding: encoding, headers: headers)
        
    }
    
    
    ///  配置默认参数
    
    //https://mobile.ximalaya.com/discovery-feed/v3/mix/ts-1630842779636?firstInstall=0&appid=0&topBuzzVersion=3&click=false&deviceId=37B45C87-58E6-4F1D-A9BD-C3C7B9FA0F4F&onlyBody=false&operator=3&code=43_440000_4403&osUpdateTime=1607275041.713700&giftTag=0&hotPlayModuleShowTimes=1&channel=ios-b1&ageRange=&interestedCategories=&systemIDFA=61CEAF02-54AA-4995-8C6B-6F0FE3EEC379&version=8.3.21&idfaLimit=0&guessPageId=11&offset=3&uid=136001372&xt=1630842779636&countyCode=440306&scale=3&network=WIFI&traitValue=&traitKey=&device=iPhone&categoryId=-2
    
    public func formatNetworkParams(_ originParams: [String: Any]?) -> [String: Any] {
        
        var defaultParams: [String : Any] = ["version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "",
                                             "build_version": Bundle.main.infoDictionary?["CFBundleVersion"] ?? "",
                                             "channel_no": Bundle.main.infoDictionary?["ChannelNo"] ?? "",
                                             "device": "iPhone",
                                             "deviceId": UIDevice.current.identifierForVendor?.uuidString ?? "",  //获取设备唯一标识符,
                                             "client": "6", // app 端定义为 6
                                             "xt": Int64(Date().timeIntervalSince1970),
                                             "nonce": arc4random()%100
        ]
        
//
//        if XAAppCore.shared.environmentType  == .developEnvironment {
//            defaultParams["app_id"] = XAAppCore.shared.currentAccessShopModel.appId ?? ""
//        }
        
        var params: [String: Any] = originParams != nil ? originParams! : [:]
        params.merge(defaultParams) { (param, defaultParam) -> Any in
            return param
        }
        
        return params

    }
    
    
    
    
    
}





