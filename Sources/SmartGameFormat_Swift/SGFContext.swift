//
//  SGFContext.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/7/25.
//

import Foundation
import Logging

public class SGFContext {
    private static let logger = Logger(label: "SGFContext")
    
    let size: Int
    let encoding: String.Encoding
    
    public init(size: Int, encoding: String.Encoding) {
        self.size = size
        self.encoding = encoding
    }
    
    public var encodingName: String {
        let cfStringEncoding = CFStringConvertNSStringEncodingToEncoding(encoding.rawValue)
        return CFStringConvertEncodingToIANACharSetName(cfStringEncoding) as String
    }
    
    public func encode(_ value: String, using another: String.Encoding) -> String? {
        return decode(value, encodedWith: self.encoding, using: another)
    }
    
    public func decode(_ value: String, using another: String.Encoding) -> String? {
        return decode(value, encodedWith: another, using: self.encoding)
    }
    
    private func decode(_ value: String, encodedWith original: String.Encoding, using another: String.Encoding) -> String? {
        guard let data = value.data(using: original) else {
            SGFContext.logger.warning("Can't encode \(value) using \(original)")
            return nil
        }
        guard let decoded = String(data: data, encoding: another) else {
            SGFContext.logger.warning("Can't convert data to string for \(value) using \(another)")
            return nil
        }
        return decoded
    }
    
    public func encoding(from charsetName: String) -> String.Encoding {
        let cfStringEncoding = CFStringConvertIANACharSetNameToEncoding(charsetName as CFString)
        let nsStringEndoding = CFStringConvertEncodingToNSStringEncoding(cfStringEncoding)
        return String.Encoding(rawValue: nsStringEndoding)
    }
    
    public func interpretAsPoint(_ value: String) -> (Int, Int)  {
        if value == "" || value == "tt" {
            return (-1, -1)
        }
        
        let point = Array(value.utf16)
        let col = Int(point[0]) - 97
        let row = size - Int(point[1]) + 96
        return (row, col)
    }
    
    private static let columnNames: [Character] = Array("abcdefghijklmnopqrstuvwxy")
    private static let rowNames: [Character] = Array("abcdefghijklmnopqrstuvwxy")
    
    public func serialize(point: SGFPoint) -> String {
       return serialize(point: (point.row, point.col))
    }
    
    public func serialize(point: (Int, Int)) -> String {
        let (row, col) = point
        
        if row < 0 || col < 0 || row >= size || col >= size {
            SGFContext.logger.error("\(point) is not valid point")
        }
        
        return String(SGFContext.columnNames[col]) + String(SGFContext.rowNames[size - row - 1])
    }
    
    public func escape(text: String) -> String {
        return text.replacing("\\", with: "\\\\").replacing("]", with: "\\]")
    }
}
