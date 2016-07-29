//
//  Fetcher.swift
//  Lecture10
//
//  Created by Kobi Greene on 7/25/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import Foundation

class Fetcher: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    func session() -> NSURLSession {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15.0
        
        return NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    //MARK: NSURLSessionTaskDelegate
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        //
    }
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        //
    }
    typealias RequestCompletionHandler = (data: NSData?, message: String?) -> Void
    func request(url: NSURL, completion: RequestCompletionHandler ) {
        let task = session().dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            completion(data: data, message: nil)
        }
    }
    
    typealias JSONRequestionCompletionHandler = (json: NSObject?, message: String?) -> Void
    func requestJSON(url: NSURL, completion: JSONRequestionCompletionHandler) {
        request(url) { (data, message) in
            var json: NSObject?
            if let data = data {
                json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSObject
            }
            completion(json: json, message: nil)
        }
    }
    
}

 //MARK: NSURLSessionDelegate
extension Fetcher {
    
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        NSLog("\(#function): Session became invalid: \(error?.localizedDescription)")
    }
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        //
    }
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        //
    }
}