//
//  RESTClient.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Alamofire
import Foundation
import Reachability
import RxSwift

enum RESTClient {
    case posts
    case comments
    case albums
    case photos
    case todos
    case users
}

// MARK: - Attributes -

extension RESTClient {
    /// A dictionary containing all the HTTP header fields
    fileprivate var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"] // "Authorization": Application.Auth.bearerToken()
        }
    }

    /// The URL of the receiver.
    internal var url: String {
        return host + path
    }

    /// The host, conforming to RFC 1808.
    fileprivate var host: String {
        return "https://jsonplaceholder.typicode.com"
    }

    /// The path, conforming to RFC 1808
    fileprivate var path: String {
//        return "/api/v1/" + endpoint
        return "/" + endpoint
    }

    /// API Endpoint
    fileprivate var endpoint: String {
        switch self {
        case .posts:
            return "posts"
        case .comments:
            return "comments"
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        case .todos:
            return "todos"
        case .users:
            return "users"
        }
    }

    /// The HTTP request method.
    fileprivate var method: HTTPMethod {
        return .get
    }

    /// The HTTP request parameters.
    fileprivate var parameters: [String: Any]? {
        return nil
    }

    /// A type used to define how a set of parameters are applied to a URLRequest.
    ///
    /// Returns a JSONEncoding instance with default writing options.
    fileprivate var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

// MARK: - Methods Closures -

extension RESTClient {
    /// Request using Alamofire
    ///
    /// - Parameter closure: RESTEvent<(RESTMeta, Any)>
    func request(parameter: [String: Any]? = nil, closure: @escaping (_ event: RESTEvent<(RESTMeta, Any)>) -> Void) {
        if Reachability()!.connection == .none {
            closure(RESTEvent.error(RESTError(message: "No internet connection.", type: .warning)))
        }

        // logRequest()

        Alamofire.request(url, method: method, parameters: parameter, encoding: encoding, headers: headers).responseData { response in
            switch response.result {
            case let .success(data):
                // self.logResponse(response: response, jsonResponse: jsonResponse)
                do {
                    closure(RESTEvent.success(try self.handleResponce(responce: response.response ?? HTTPURLResponse(), data: data)))
                } catch let error as RESTError {
                    closure(RESTEvent.error(error))
                } catch {
                    closure(RESTEvent.error(error))
                }

            case let .failure(error):
                closure(RESTEvent.error(self.handleError(error: error)))
            }
        }
    }

    /// Multipart Request using Alamofire and RxObservers
    ///
    /// - Returns: Rx Observer
    func upload(parameter: [String: Any]? = nil, closure: @escaping (_ event: RESTEvent<(RESTMeta, Any)>) -> Void) {
        // If No Internet Connection Throws error
        if Reachability()!.connection == .none {
            closure(RESTEvent.error(RESTError(message: "No internet connection.", type: .warning)))
        }

        Alamofire.upload(multipartFormData: { data in

            if parameter != nil {
                for (key, value) in parameter! {
                    var tmpValue: String = ""

                    if let strValue: String = value as? String {
                        tmpValue = strValue
                    } else if let numberValue: NSNumber = value as? NSNumber {
                        tmpValue = numberValue.stringValue
                    } else if let dicValue: NSDictionary = value as? NSDictionary {
                        tmpValue = dicValue.JSONString()
                    } else if let arrValue: NSArray = value as? NSArray {
                        tmpValue = arrValue.JSONString()
                    }

                    if let strData: Data = tmpValue.data(using: .utf8) {
                        data.append(strData, withName: key)
                    }
                }
            }
        }, to: url, method: method, headers: headers, encodingCompletion: { result in
            switch result {
            case .success(let request, _, _):
                request.responseData { response in
                    switch response.result {
                    case let .success(data):

                        // self.logResponse(response: response, jsonResponse: jsonResponse)
                        do {
                            closure(RESTEvent.success(try self.handleResponce(responce: response.response ?? HTTPURLResponse(), data: data)))
                        } catch let error as RESTError {
                            closure(RESTEvent.error(error))
                        } catch {
                            closure(RESTEvent.error(error))
                        }

                    case let .failure(error):
                        closure(RESTEvent.error(self.handleError(error: error)))
                    }
                }
            case let .failure(error):
                closure(RESTEvent.error(self.handleError(error: error)))
            }
        })
    }
}

// MARK: - Methods Rx -

extension RESTClient {
    /// Data Request using Alamofire and RxObservers
    ///
    /// - Returns: Rx Observer
    func request(parameter: [String: Any]? = nil) -> Observable<(RESTMeta, Any)> {
        // If No Internet Connection Throws error
        if Reachability()!.connection == .none {
            return Observable.error(RESTError(message: "No internet connection.", type: .warning))
        }

        // logRequest()

        // If Internet Connection Avaiable then request data
        return Observable.create { (observer) -> Disposable in

            Alamofire.request(self.url, method: self.method, parameters: parameter, encoding: self.encoding, headers: self.headers)
                .responseData { response in
                    switch response.result {
                    case let .success(data):

                        // self.logResponse(response: response, jsonResponse: jsonResponse)

                        do {
                            observer.onNext(try self.handleResponce(responce: response.response ?? HTTPURLResponse(), data: data))
                            observer.onCompleted()
                        } catch let restError as RESTError {
                            observer.onError(restError)
                        } catch {
                            observer.onError(error)
                        }
                    case let .failure(error):
                        observer.onError(self.handleError(error: error))
                    }
                }

            return Disposables.create()
        }
    }

    /// Multipart Request using Alamofire and RxObservers
    ///
    /// - Returns: Rx Observer
    func upload(parameter: [String: Any]? = nil, files: [MultiPartFile]? = nil) -> Observable<(RESTMeta, Any)> {
        // If No Internet Connection Throws error
        if Reachability()!.connection == .none {
            return Observable.error(RESTError(message: "No internet connection.", type: .warning))
        }

        // logRequest()

        // If Internet Connection Avaiable then request data
        return Observable.create { (observer) -> Disposable in

            Alamofire.upload(multipartFormData: { data in

                if let parameter = parameter {
                    for (key, value) in parameter {
                        var tmpValue: String = ""

                        if let strValue: String = value as? String {
                            tmpValue = strValue
                        } else if let numberValue: NSNumber = value as? NSNumber {
                            tmpValue = numberValue.stringValue
                        } else if let dicValue: NSDictionary = value as? NSDictionary {
                            tmpValue = dicValue.JSONString()
                        } else if let arrValue: NSArray = value as? NSArray {
                            tmpValue = arrValue.JSONString()
                        }

                        if let strData: Data = tmpValue.data(using: .utf8) {
                            data.append(strData, withName: key)
                        }
                    }
                }

                if let files = files {
                    for item in files {
                        data.append(item.data, withName: item.name, fileName: item.fileName, mimeType: item.mimeType)
                    }
                }

            }, to: self.url, method: self.method, headers: self.headers, encodingCompletion: { result in
                switch result {
                case .success(let request, _, _):
                    request.responseData { response in
                        switch response.result {
                        case let .success(data):

                            // self.logResponse(response: response, jsonResponse: jsonResponse)

                            do {
                                observer.onNext(try self.handleResponce(responce: response.response ?? HTTPURLResponse(), data: data))
                                observer.onCompleted()
                            } catch let restError as RESTError {
                                observer.onError(restError)
                            } catch {
                                observer.onError(error)
                            }
                        case let .failure(error):
                            observer.onError(self.handleError(error: error))
                        }
                    }
                case let .failure(error):
                    observer.onError(self.handleError(error: error))
                }
            })

            return Disposables.create()
        }
    }
}

// MARK: - Handle Responce -

extension RESTClient {
    /// Handle Error Thrown by Data Request
    ///
    /// - Parameter error: Error
    /// - Returns: Modified Error
    fileprivate func handleError(error: Error) -> Error {
        if let error = error as? AFError {
            if error.isResponseSerializationError {
                Log.error("ERROR: RESTClient Serialization Error HTML Responce")
                return RESTError(message: "Something went wrong, please try again.", type: .error)
            } else if error.isResponseValidationError {
                Log.error("ERROR: RESTClient Validation Error HTML Responce")
                return RESTError(message: "Something went wrong, please try again.", type: .error)
            } else if error.isMultipartEncodingError {
                Log.error("ERROR: RESTClient Multipart Encoding Error")
                return RESTError(message: "Something went wrong, please try again.", type: .error)
            } else if error.isParameterEncodingError {
                Log.error("ERROR: RESTClient Parameter Encoding Error")
                return RESTError(message: "Something went wrong, please try again.", type: .error)
            } else if error.isInvalidURLError {
                Log.error("ERROR: RESTClient InvalidURL Error")
                return RESTError(message: "Something went wrong, please try again.", type: .error)
            }
        }

        print("ERROR: RESTClient Unknown Error : \(error.localizedDescription)")
        return error
    }

    /// Handle Responce on Sucess of Data Request
    ///
    /// - Parameters:
    ///   - responce: HTTPURLResponse
    ///   - data: JSON Data
    /// - Returns: (RESTMeta, Any) Touple
    /// - Throws: Error
    fileprivate func handleResponce(responce: HTTPURLResponse, data: Data) throws -> (RESTMeta, Any) {
//        guard let dataDict: [String: Any] = data as? [String: Any] else {
//            // If cant able to convert responce in to dictionary
//            print("ERROR: RESTClient handleResponce cant able to convert responce in to dictionary")
//            throw RESTError(message: "Something went wrong, please try again.", type: .error, statusCode: responce.statusCode)
//        }
//
//        // Parse Meta
//        guard let meta: RESTMeta = RESTMeta(meta: dataDict["meta"]) else {
//            // If cant able to convert meta in to dictionary
//            print("ERROR: RESTClient handleResponce cant able to convert meta in to dictionary")
//            throw RESTError(message: "Something went wrong, please try again.", type: .error, statusCode: responce.statusCode)
//        }

        let meta: RESTMeta = RESTMeta(statusCode: responce.statusCode)

        if responce.statusCode == 200 || 200 ..< 300 ~= responce.statusCode {
            return (meta, parse(data: data))
        } else {
            throw RESTError(message: meta.message, type: meta.type, statusCode: responce.statusCode)
        }
    }
}
