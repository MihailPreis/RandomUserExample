//
//  Safety.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

func safety(_ action: () throws -> Void, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    do {
        try action()
    } catch {
        logError(error, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
    }
}

func safety<T>(_ action: () throws -> T, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) -> T? {
    do {
        return try action()
    } catch {
        logError(error, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
        return nil
    }
}
