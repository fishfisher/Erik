//
//  Future.swift
//  Erik
/*
The MIT License (MIT)
Copyright (c) 2015-2016 Eric Marchand (phimage)
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


import Foundation
import BrightFutures

extension Erik {

    public typealias FutureError = NSError // TODO AnyError?
    fileprivate static func toFutureError(_ error: Error) -> FutureError {
        return error as FutureError
    }

    public func visitFuture(url: URL) -> Future<Document, FutureError> {
        let promise = Promise<Document, FutureError>()
        
        self.visit(url: url) { (result) -> Void in
            if let document = result.document {
                promise.success(document)
            }
            else if let error = result.error {
                promise.failure(Erik.toFutureError(error))
            }
        }
        
        return promise.future
    }

    public func currentContentFuture() -> Future<Document, FutureError> {
        let promise = Promise<Document, FutureError>()
        
        self.currentContent { (result) -> Void in
            if let document = result.document {
                promise.success(document)
            }
            else if let error = result.error {
                promise.failure(Erik.toFutureError(error))
            }
        }

        return promise.future
    }

    public func evaluateFuture(javaScript: String) -> Future<Any?, FutureError> {
        let promise = Promise<Any?, FutureError>()
        
        self.evaluate(javaScript: javaScript) { (obj, err) -> Void in
            if let error = err {
                promise.failure(Erik.toFutureError(error))
            }
            else {
                promise.success(obj)
            }
        }
        
        return promise.future
    }

    public static func visitFuture(url: URL) -> Future<Document, FutureError> {
        return Erik.sharedInstance.visitFuture(url: url)
    }

    public static func currentContentFuture() -> Future<Document, FutureError> {
        return Erik.sharedInstance.currentContentFuture()
    }
    
    public static func evaluateFuture(javaScript: String) -> Future<Any?, FutureError>  {
        return Erik.sharedInstance.evaluateFuture(javaScript: javaScript)
    }
}

extension Element {

    public typealias FutureError = NSError // TODO AnyError?
    fileprivate static func toFutureError(_ error: Error) -> FutureError {
        return error as FutureError
    }

    public func clickFuture() -> Future<Any?, FutureError> {
        let promise = Promise<Any?, FutureError>()

        self.click { (obj, err) -> Void in
            if let obj = obj {
                promise.success(obj)
            }
            else if let error = err {
                promise.failure(Erik.toFutureError(error))
            }
            else {
                promise.success(nil)
            }
        }

        return promise.future
    }

}

extension Form {

    open func submitFuture() -> Future<Any?, FutureError> {
        let promise = Promise<Any?, FutureError>()

        self.click { (obj, err) -> Void in
            if let obj = obj {
                promise.success(obj)
            }
            else if let error = err {
                promise.failure(Erik.toFutureError(error))
            }
            else {
                promise.success(nil)
            }
        }

        return promise.future
    }

    open func resetFuture() -> Future<Any?, FutureError> {
        let promise = Promise<Any?, FutureError>()

        self.reset { (obj, err) -> Void in
            if let obj = obj {
                promise.success(obj)
            }
            else if let error = err {
                promise.failure(Erik.toFutureError(error))
            }
            else {
                promise.success(nil)
            }
        }

        return promise.future
    }

}
