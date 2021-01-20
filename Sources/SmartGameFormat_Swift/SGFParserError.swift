//
//  SGFParserError.swift
//  Go
//
//  Created by Jae Seung Lee on 1/13/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public enum SGFParserError: Error {
    case EndOfDataParseError
    case GameTreeParseError(String)
    case NodePropertyParseError
    case PropertyValueParseError
    case DirectAccessError
    case DuplicatePropertyError
    case GameTreeNavigationError
    case GameTreeEndError
}
