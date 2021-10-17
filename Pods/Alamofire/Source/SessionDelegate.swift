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
    open var dataTaskDidReceiveResponseWithCompletion: ((URLSession, URLSessionDataTask, URLResponse, @escaping (URLSession.ResponseDisposition) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didBecome:)`.
    open var dataTaskDidBecomeDownloadTask: ((URLSession, URLSessionDataTask, URLSessionDownloadTask) -> Void)?

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didReceive:)`.
    open var dataTaskDidReceiveData: ((URLSession, URLSessionDataTask, Data) -> Void)?

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:willCacheResponse:completionHandler:)`.
    open var dataTaskWillCacheResponse: ((URLSession, URLSessionDataTask, CachedURLResponse) -> CachedURLResponse?)?

    /// Overrides all behavior for URLSessionDataDelegate method `urlSession(_:dataTask:willCacheResponse:completionHandler:)` and
    /// requires caller to call the `completionHandler`.
    open var dataTaskWillCacheResponseWithCompletion: ((URLSession, URLSessionDataTask, CachedURLResponse, @escaping (CachedURLResponse?) -> Void) -> Void)?

    // MARK: URLSessionDownloadDelegate Overrides

    /// Overrides default behavior for URLSessionDownloadDelegate method `urlSession(_:downloadTask:didFinishDownloadingTo:)`.
    open var downloadTaskDidFinishDownloadingToURL: ((URLSession, URLSessionDownloadTask, URL) -> Void)?

    /// Overrides default behavior for URLSessionDownloadDelegate method `urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)`.
    open var downloadTaskDidWriteData: ((URLSession, URLSessionDownloadTask, Int64, Int64, Int64) -> Void)?

    /// Overrides default behavior for URLSessionDownloadDelegate method `urlSession(_:downloadTask:didResumeAtOffset:expectedTotalBytes:)`.
    open var downloadTaskDidResumeAtOffset: ((URLSession, URLSessionDownloadTask, Int64, Int64) -> Void)?

    // MARK: URLSessionStreamDelegate Overrides

#if !os(watchOS)

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:readClosedFor:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskReadClosed: ((URLSession, URLSessionStreamTask) -> Void)? {
        get {
            return _streamTaskReadClosed as? (URLSession, URLSessionStreamTask) -> Void
        }
        set {
            _streamTaskReadClosed = newValue
        }
    }

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:writeClosedFor:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskWriteClosed: ((URLSession, URLSessionStreamTask) -> Void)? {
        get {
            return _streamTaskWriteClosed as? (URLSession, URLSessionStreamTask) -> Void
        }
        set {
            _streamTaskWriteClosed = newValue
        }
    }

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:betterRouteDiscoveredFor:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskBetterRouteDiscovered: ((URLSession, URLSessionStreamTask) -> Void)? {
        get {
            return _streamTaskBetterRouteDiscovered as? (URLSession, URLSessionStreamTask) -> Void
        }
        set {
            _streamTaskBetterRouteDiscovered = newValue
        }
    }

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:streamTask:didBecome:outputStream:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskDidBecomeInputAndOutputStreams: ((URLSession, URLSessionStreamTask, InputStream, OutputStream) -> Void)? {
        get {
            return _streamTaskDidBecomeInputStream as? (URLSession, URLSessionStreamTask, InputStream, OutputStream) -> Void
        }
        set {
            _streamTaskDidBecomeInputStream = newValue
        }
    }

    var _streamTaskReadClosed: Any?
    var _streamTaskWriteClosed: Any?
    var _streamTaskBetterRouteDiscovered: Any?
    var _streamTaskDidBecomeInputStream: Any?

#endif

    // MARK: Properties

    var retrier: RequestRetrier?
    weak var sessionManager: SessionManager?

    private var requests: [Int: Request] = [:]
    private let lock = NSLock()

    /// Access the task delegate for the specified task in a thread-safe manner.
    open subscript(task: URLSessionTask) -> Request? {
        get {
            lock.lock() ; defer { lock.unlock() }
            return requests[task.taskIdentifier]
        }
        set {
            lock.lock() ; defer { lock.unlock() }
            requests[task.taskIdentifier] = newValue
        }
    }

    // MARK: Lifecycle

    /// Initializes the `SessionDelegate` instance.
    ///
    /// - returns: The new `SessionDelegate` instance.
    public override init() {
        super.init()
    }

    // MARK: NSObject Overrides

    /// Returns a `Bool` indicating whether the `SessionDelegate` implements or inherits a method that can respond
    /// to a specified message.
    ///
    /// - parameter selector: A selector that identifies a message.
    ///
    /// - returns: `true` if the receiver implements or inherits a method that can respond to selector, otherwise `false`.
    open override func responds(to selector: Selector) -> Bool {
        #if !os(macOS)
            if selector == #selector(URLSessionDelegate.urlSessionDidFinishEvents(forBackgroundURLSession:)) {
                return sessionDidFinishEventsForBackgroundURLSession != nil
            }
        #endif

        #if !os(watchOS)
            if #available(iOS 9.0, macOS 10.11, tvOS 9.0, *) {
                switch selector {
                case #selector(URLSessionStreamDelegate.urlSession(_:readClosedFor:)):
                    return streamTaskReadClosed != nil
                case #selector(URLSessionStreamDelegate.urlSession(_:writeClosedFor:)):
                    return streamTaskWriteClosed != nil
                case #selector(URLSessionStreamDelegate.urlSession(_:betterRouteDiscoveredFor:)):
                    return streamTaskBetterRouteDiscovered != nil
                case #selector(URLSessionStreamDelegate.urlSession(_:streamTask:didBecome:outputStream:)):
                    return streamTaskDidBecomeInputAndOutputStreams != nil
                default:
                    break
                }
            }
        #endif

        switch selector {
        case #selector(URLSessionDelegate.urlSession(_:didBecomeInvalidWithError:)):
            return sessionDidBecomeInvalidWithError != nil
        case #selector(URLSessionDelegate.urlSession(_:didReceive:completionHandler:)):
            return (sessionDidReceiveChallenge != nil  || sessionDidReceiveChallengeWithCompletion != nil)
        case #selector(URLSessionTaskDelegate.urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)):
            return (taskWillPerformHTTPRedirection != nil || taskWillPerformHTTPRedirectionWithCompletion != nil)
        case #selector(URLSessionDataDelegate.urlSession(_:dataTask:didReceive:completionHandler:)):
            return (dataTaskDidReceiveResponse != nil || dataTaskDidReceiveResponseWithCompletion != nil)
        default:
            return type(of: self).instancesRespond(to: selector)
        }
    }
}

// MARK: - URLSessionDelegate

extension SessionDelegate: URLSessionDelegate {
    /// Tells the delegate that the session has been invalidated.
    ///
    /// - parameter session: The session object that was invalidated.
    /// - parameter error:   The error that caused invalidation, or nil if the invalidation was explicit.
    open func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        sessionDidBecomeInvalidWithError?(session, error)
    }

    /// Requests credentials from the delegate in response to a session-level authentication request from the
    /// remote server.
    ///
    /// - parameter session:           The session containing the task that requested authentication.
    /// - parameter challenge:         An object that contains the request for authentication.
    /// - parameter completionHandler: A handler that your delegate method must call providing the disposition
    ///                                and credential.
    open func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        guard sessionDidReceiveChallengeWithCompletion == nil else {
            sessionDidReceiveChallengeWithCompletion?(session, challenge, completionHandler)
            return
        }

        var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
        var credential: URLCredential?

        if let sessionDidReceiveChallenge = sessionDidReceiveChallenge {
            (disposition, credential) = sessionDidReceiveChallenge(session, challenge)
        } else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let host = challenge.protectionSpace.host

            if
                let serverTrustPolicy = session.serverTrustPolicyManager?.serverTrustPolicy(forHost: host),
                let serverTrust = challenge.protectionSpace.serverTrust
            {
                if serverTrustPolicy.evaluate(serverTrust, forHost: host) {
                    disposition = .useCredential
                    credential = URLCredential(trust: serverTrust)
                } else {
                    disposition = .cancelAuthenticationChallenge
                }
            }
        }

        completionHandler(disposition, credential)
    }

#if !os(macOS)

    /// Tells the delegate that all messages enqueued for a session have been delivered.
    ///
    /// - parameter session: The session that no longer has any outstanding requests.
    open func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        sessionDidFinishEventsForBackgroundURLSession?(session)
    }

#endif
}

// MARK: - URLSessionTaskDelegate

extension SessionDelegate: URLSessionTaskDelegate {
    /// Tells the delegate that the remote server requested an HTTP redirect.
    ///
    /// - parameter session:           The session containing the task whose request resulted in a redirect.
    /// - parameter task:              The task whose request resulted in a redirect.
    /// - parameter response:          An object containing the server’s response to the original request.
    /// - parameter request:           A URL request object filled out with the new location.
    /// - parameter completionHandler: A closure that your handler should call with either the value of the request
    ///                                parameter, a modified URL request object, or NULL to refuse the redirect and
    ///                                return the body of the redirect response.
    open func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void)
    {
        guard taskWillPerformHTTPRedirectionWithCompletion == nil else {
            taskWillPerformHTTPRedirectionWithCompletion?(session, task, response, request, completionHandler)
            return
        }

        var redirectRequest: URLRequest? = request

        if let taskWillPerformHTTPRedirection = taskWillPerformHTTPRedirection {
            redirectRequest = taskWillPerformHTTPRedirection(session, task, response, request)
        }

        completionHandler(redirectRequest)
    }

    /// Requests credentials from the delegate in response to an authentication request from the remote server.
    ///
    /// - parameter session:           The session containing the task whose request requires authentication.
    /// - parameter task:              The task whose request requires authentication.
    /// - parameter challenge:         An object that contains the request for authentication.
    /// - parameter completionHandler: A handler that your delegate method must call providing the disposition
    ///                                and credential.
    open func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        guard taskDidReceiveChallengeWithCompletion == nil else {
            taskD