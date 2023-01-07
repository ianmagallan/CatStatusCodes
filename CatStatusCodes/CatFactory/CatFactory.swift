//
//  CatFactory.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Foundation

protocol CatFactoring {
    static func makeCats() -> [Cat]
}

enum CatFactory: CatFactoring {
    static func makeCats() -> [Cat] {
        [
            .init(statusCode: 100, description: "Continue"),
            .init(statusCode: 101, description: "Switching protocols"),
            .init(statusCode: 102, description: "Processing"),
            .init(statusCode: 103, description: "Early Hints"),
            .init(statusCode: 200, description: "OK"),
            .init(statusCode: 201, description: "Created"),
            .init(statusCode: 202, description: "Accepted"),
            .init(statusCode: 203, description: "Non-Authoritative Information"),
            .init(statusCode: 204, description: "No content"),
            .init(statusCode: 205, description: "Reset content"),
            .init(statusCode: 206, description: "Partial Content"),
            .init(statusCode: 207, description: "Multi-Status"),
            .init(statusCode: 208, description: "Already Reported"),
            .init(statusCode: 226, description: "IM Used"),
            .init(statusCode: 300, description: "Multiple Choices"),
            .init(statusCode: 301, description: "Moved Permanently"),
            .init(statusCode: 302, description: "Found (Previously \"Moved Temporarily\")"),
            .init(statusCode: 303, description: "See Other"),
            .init(statusCode: 304, description: "Not Modified"),
            .init(statusCode: 305, description: "Use Proxy"),
            .init(statusCode: 306, description: "Switch Proxy"),
            .init(statusCode: 307, description: "Temporary Redirect"),
            .init(statusCode: 308, description: "Permanent Redirect"),
            .init(statusCode: 400, description: "Bad Request"),
            .init(statusCode: 401, description: "Unauthorized"),
            .init(statusCode: 402, description: "Payment Required"),
            .init(statusCode: 403, description: "Forbidden"),
            .init(statusCode: 404, description: "Not Found"),
            .init(statusCode: 405, description: "Method Not Allowed"),
            .init(statusCode: 406, description: "Not Acceptable"),
            .init(statusCode: 407, description: "Proxy Authentication Required"),
            .init(statusCode: 408, description: "Request Timeout"),
            .init(statusCode: 409, description: "Conflict"),
            .init(statusCode: 410, description: "Gone"),
            .init(statusCode: 411, description: "Length Required"),
            .init(statusCode: 412, description: "Precondition Failed"),
            .init(statusCode: 413, description: "Payload Too Large"),
            .init(statusCode: 414, description: "URI Too Long"),
            .init(statusCode: 415, description: "Unsupported Media Type"),
            .init(statusCode: 416, description: "Range Not Satisfiable"),
            .init(statusCode: 417, description: "Expectation Failed"),
            .init(statusCode: 418, description: "I'm a Teapot"),
            .init(statusCode: 421, description: "Misdirected Request"),
            .init(statusCode: 422, description: "Unprocessable Entity"),
            .init(statusCode: 423, description: "Locked"),
            .init(statusCode: 424, description: "Failed Dependency"),
            .init(statusCode: 425, description: "Too Early"),
            .init(statusCode: 426, description: "Upgrade Required"),
            .init(statusCode: 428, description: "Precondition Required"),
            .init(statusCode: 429, description: "Too Many Requests"),
            .init(statusCode: 431, description: "Request Header Fields Too Large"),
            .init(statusCode: 451, description: "Unavailable For Legal Reasons"),
            .init(statusCode: 500, description: "Internal Server Error"),
            .init(statusCode: 501, description: "Not Implemented"),
            .init(statusCode: 502, description: "Bad Gateway"),
            .init(statusCode: 503, description: "Service Unavailable"),
            .init(statusCode: 504, description: "Gateway Timeout"),
            .init(statusCode: 505, description: "HTTP Version Not Supported"),
            .init(statusCode: 506, description: "Variant Also Negotiates"),
            .init(statusCode: 507, description: "Insufficient Storage"),
            .init(statusCode: 508, description: "Loop Detected"),
            .init(statusCode: 510, description: "Not Extended"),
            .init(statusCode: 511, description: "Network Authentication Required")

        ]
    }
}
