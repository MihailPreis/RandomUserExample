//
//  Logger.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

private enum LogLevel: String {
    case info = "INFO"
    case debug = "DEBUG"
    case warn = "WARN"
    case error = "ERROR"
}

func logInfo(_ message: String, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log(level: .info, message: message, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
}

func logWarn(_ message: String, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log(level: .warn, message: message, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
}

func logDebug(_ message: String, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log(level: .debug, message: message, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
}

func logError(_ message: String, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log(level: .error, message: message, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
}

func logError(_ error: Error, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log(level: .error, message: error.localizedDescription, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
}

private func log(level: LogLevel, message: String, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    #if !DEBUG
    if case .debug = level {
        return
    }
    #endif
    NSLog(
        "[%@] %@:%@ %@ :: %@",
        level.rawValue,
        URL(fileURLWithPath: filePath).lastPathComponent,
        lineNumber.description,
        functionName,
        message
    )
}
