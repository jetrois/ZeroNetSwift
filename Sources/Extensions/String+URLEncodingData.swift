//
//  String+URLEncodingData.swift
//  LearnSwift
//
//  Created by Rick Li on 1/13/18.
//

import Foundation


extension String {
    
    static let asciiSpace: UInt8 = 32
    static let asciiPercentage: UInt8 = 37
    
    init(urlEncodingData data: Data) {
        self = String.urlEncode(data)
    }
    
    private static func urlEncode(_ data: Data) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-_~")
        let result = NSMutableString()
        
        for i in 0..<data.count {
            
            let byte = data.correctingIndicies[i]
            
            if byte == asciiSpace {
                result.append("%20")
            } else if byte == asciiPercentage {
                result.append("%25")
            } else {
                let c = UnicodeScalar(byte)
                if allowedCharacters.contains(c) {
                    let string = String(c)
                    result.append(string)
                } else {
                    result.appendFormat("%%%02X", byte)
                }
            }
        }
        
        return result as String
    }
}

