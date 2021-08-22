//
//  SessionDelegate.swift
//
//  Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// Responsible for handling all delegate callbacks for the underlying session.
open class SessionDelegate: NSObject {

    // MARK: URLSessionDelegate Overrides

    /// Overrides default behavior for URLSessionDelegate method `urlSession(_:didBecomeInvalidWithError:)`.
    open var sessionDidBecomeInvalidWithError: ((URLSession, Error?) -> Void)?

    /// Overrides default behavior for URLSessionDelegate method `urlSession(_:didReceive:completionHandler:)`.
    open var sessionDidReceiveChallenge: ((URLSession, URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?))?

    /// Overrides all behavior for URLSessionDelegate method `urlSession(_:didReceive:completionHandler:)` and requires the caller to call the `completionHandler`.
    open var sessionDidReceiveChallengeWithCompletion: ((URLSession, URLAuthenticationChallenge, @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionDelegate method `urlSessionDidFinishEvents(forBackgroundURLSession:)`.
    open var sessionDidFinishEventsForBackgroundURLSession: ((URLSession) -> Void)?

    // MARK: URLSessionTaskDelegate Overrides

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)`.
    open var taskWillPerformHTTPRedirection: ((URLSession, URLSessionTask, HTTPURLResponse, URLRequest) -> URLRequest?)?

    /// Overrides all behavior for URLSessionTaskDelegate method `urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)` and
    /// requires the caller to call the `completionHandler`.
    open var taskWillPerformHTTPRedirectionWithCompletion: ((URLSession, URLSessionTask, HTTPURLResponse, URLRequest, @escaping (URLRequest?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:didReceive:completionHandler:)`.
    open var taskDidReceiveChallenge: ((URLSession, URLSessionTask, URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?))?

    /// Overrides all behavior for URLSessionTaskDelegate method `urlSession(_:task:didReceive:completionHandler:)` and
    /// requires the caller to call the `completionHandler`.
    open var taskDidReceiveChallengeWithCompletion: ((URLSession, URLSessionTask, URLAuthenticationChallenge, @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:needNewBodyStream:)`.
    open var taskNeedNewBodyStream: ((URLSession, URLSessionTask) -> InputStream?)?

    /// Overrides all behavior for URLSessionTaskDelegate method `urlSession(_:task:needNewBodyStream:)` and
    /// requires the caller to call the `completionHandler`.
    open var taskNeedNewBodyStreamWithCompletion: ((URLSession, URLSessionTask, @escaping (InputStream?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)`.
    open var taskDidSendBodyData: ((URLSession, URLSessionTask, Int64, Int64, Int64) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:didCompleteWithError:)`.
    open var taskDidComplete: ((URLSession, URLSessionTask, Error?) -> Void)?

    // MARK: URLSessionDataDelegate Overrides

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didReceive:completionHandler:)`.
    open var dataTaskDidReceiveResponse: ((URLSession, URLSessionDataTask, URLResponse) -> URLSession.ResponseDisposition)?

    /// Overrides all behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didReceive:completionHandler:)` and
    /// requires caller to call the `completionHandler`.
    open var data