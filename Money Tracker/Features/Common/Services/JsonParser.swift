//
//  JsonParser.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation

enum RequestType {
    case post
    case get
}

struct RequestParams {
    var apiType: RequestType = .post
    var endPointURL: String = ""
    var params: [String: Any]? = nil
}
