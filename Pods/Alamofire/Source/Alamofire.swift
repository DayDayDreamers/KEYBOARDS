//
//  Alamofire.swift
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

/// Types adopting the `URLConvertible` protocol can be used to construct URLs, which are then used to construct
/// URL requests.
public protocol URLConvertible {
    /// Returns a URL that conforms to RFC 2396 or throws an `Error`.
    ///
    /// - throws: An `Error` if the type cannot be converted to a `URL`.
    ///
    /// - returns: A URL or throws an `Error`.
    func asURL() throws -> URL
}

extension String: URLConvertible {
    /// Returns a URL if `self` represents a valid URL string that conforms to RFC 2396 or throws an `AFError`.
    ///
    /// - throws: An `AFError.invalidURL` if `self` is not a valid URL string.
    ///
    /// - returns: A URL or throws an `AFError`.
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw AFError.invalidURL(url: self) }
        return url
    }
}

extension URL: URLConvertible {
    /// Returns self.
    public func asURL() throws -> URL { return self }
}

extension URLComponents: URLConvertible {
    /// Returns a URL if `url` is not nil, otherwise throws an `Error`.
    ///
    /// - throws: An `AFError.invalidURL` if `url` is `nil`.
    ///
    /// - returns: A URL or throws an `AFError`.
    public func asURL() throws -> URL {
        guard let url = url else { throw AFError.invalidURL(url: self) }
        return url
    }
}

// MARK: -

/// Types adopting the `URLRequestConvertible` protocol can be used to construct URL requests.
public protocol URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    /// The URL request.
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    public func asURLRequest() throws -> URLRequest { return self }
}

// MARK: -

extension URLRequest {
    /// Creates an instance with the specified `method`, `urlString` and `headers`.
    ///
    /// - parameter url:     The URL.
    /// - parameter method:  The HTTP method.
    /// - parameter headers: The HTTP headers. `nil` by default.
    ///
    /// - returns: The new `URLRequest` instance.
    public init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()

        self.init(url: url)

        httpMethod = method.rawValue

        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }

    func adapt(using adapter: RequestAdapter?) throws -> URLRequest {
        guard let adapter = adapter else { return self }
        return try adapter.adapt(self)
    }
}

// MARK: - Data Request

/// Creates a `DataRequest` using the default `SessionManager` to retrieve the contents of the specified `url`,
/// `method`, `parameters`, `encoding` and `headers`.
///
/// - parameter url:        The URL.
/// - parameter method:     The HTTP method. `.get` by default.
/// - parameter parameters: The parameters. `nil` by default.
/// - parameter encoding:   The parameter encoding. `URLEncoding.default` by default.
/// - parameter headers:    The HTTP headers. `nil` by default.
///
/// - returns: The created `DataRequest`.
@discardableResult
public func request(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> DataRequest
{
    return SessionManager.default.request(
        url,
        method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers
    )
}

/// Creates a `DataRequest` using the default `SessionManager` to retrieve the contents of a URL based on the
/// specified `urlRequest`.
///
/// - parameter urlRequest: The URL request
///
/// - returns: The created `DataRequest`.
@discardableResult
public func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
    return SessionManager.default.request(urlRequest)
}

// MARK: - Download Request

// MARK: URL Request

/// Creates a `DownloadRequest` using the default `SessionManager` to retrieve the contents of the specified `url`,
/// `method`, `parameters`, `encoding`, `headers` and save them to the `destination`.
///
/// If `destination` is not specified, the contents will remain in the temporary location determined by the
/// underlying URL session.
///
/// - parameter url:         The URL.
/// - parameter method:      The HTTP method. `.get` by default.
/// - parameter parameters:  The parameters. `nil` by default.
/// - parameter encoding:    The parameter encoding. `URLEncoding.default` by default.
/// - parameter headers:     The HTTP headers. `nil` by default.
/// - parameter destination: The closure used to determine the destination of the downloaded file. `nil` by default.
///
/// - returns: The created `DownloadRequest`.
@discardableResult
public func download(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil,
    to destination: DownloadRequest.DownloadFileDestination? = nil)
    -> DownloadRequest
{
    return SessionManager.default.download(
        url,
        method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers,
        to: destination
    )
}

/// Creates a `DownloadRequest` using the default `SessionManager` to retrieve the contents of a URL based on the
/// specified `urlRequest` and save them to the `destination`.
///
/// If `destination` is not specified, the contents will remain in the temporary location determined by the
/// underlying URL session.
///
/// - parameter urlRequest:  The URL request.
/// - parameter destination: The closure used to determine the destination of the downloaded file. `nil` by default.
///
/// - returns: The created `DownloadRequest`.
@discardableResult
public func download(
    _ urlRequest: URLRequestConvertible,
    to destination: DownloadRequest.DownloadFileDestination? = nil)
    -> DownloadRequest
{
    return SessionManager.default.download(urlRequest, to: destination)
}

// MARK: Resume Data

/// Creates a `DownloadRequest` using the default `SessionManager` from the `resumeData` produced from a
/// previous request cancellation to retrieve the contents of the original request and save them to the `destination`.
///
/// If `destination` is not specified, the contents will remain in the temporary location determined by the
/// underlying URL session.
///
/// On the latest release of all the Apple platforms (iOS 10, macOS 10.12, tvOS 10, watchOS 3), `resumeData` is broken
/// on background URL session configurations. There's an underlying bug in the `resumeData` generation logic where the
/// data is written incorrectly and will always fail to resume the download. For more information about the bug and
/// possible workarounds, please refer to the following Stack Overflow post:
///
///    - http://stackoverflow.com/a/39347461/1342462
///
/// - parameter resumeData:  The resume data. This is an opaque data blob produced by `URLSessionDownloadTask`
///                          when a task is cancelled. See `URLSession -downloadTask(withResumeData:)` for additional
///                          information.
/// - parameter destination: The closure used to determine the destination of the downloaded file. `nil` by default.
///
/// - returns: The created `DownloadRequest`.
@discardableResult
public func download(
    resumingWith resumeData: Data,
    to destination: DownloadRequest.DownloadFileDestination? = nil)
    -> DownloadReq