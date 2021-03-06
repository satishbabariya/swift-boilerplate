//
//  Logger.swift
//  MasterProject
//
//  Created by Satish Babariya on 18/07/18.
//  Copyright © 2015, 2017 IBM Corporation. All rights reserved.
//

import Foundation

// Log messages
// Add log messages to your application:
//
// Log.warning("This is a warning.")
// Log.error("This is an error.")
// Define a logger
// You need to define a logger in order to output these messages:
//
// Log.logger = ...

/// The type of a particular log message. It is passed with the message to be logged to the
/// actual logger implementation. It is also used to enable filtering of the log based
/// on the minimal type to log.
public enum LoggerMessageType: Int {
    /// Log message type for logging when entering into a function.
    case entry = 1
    /// Log message type for logging when exiting from a function.
    case exit = 2
    /// Log message type for logging a debugging message.
    case debug = 3
    /// Log message type for logging messages in verbose mode.
    case verbose = 4
    /// Log message type for logging an informational message.
    case info = 5
    /// Log message type for logging a warning message.
    case warning = 6
    /// Log message type for logging an error message.
    case error = 7
}

/// Implement the `CustomStringConvertible` protocol for the `LoggerMessageType` enum
extension LoggerMessageType: CustomStringConvertible {
    /// Convert a `LoggerMessageType` into a printable format.
    public var description: String {
        switch self {
        case .entry:
            return "ENTRY"
        case .exit:
            return "EXIT"
        case .debug:
            return "DEBUG"
        case .verbose:
            return "VERBOSE"
        case .info:
            return "INFO"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }
}

/// A logger protocol implemented by Logger implementations. This API is used by Kitura
/// throughout its implementation when logging.
public protocol Logger {
    /// Output a logged message.
    ///
    /// - Parameter type: The type of the message (`LoggerMessageType`) being logged.
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API.
    func log(_ type: LoggerMessageType, msg: String,
             functionName: String, lineNum: Int, fileName: String)

    /// Indicates if a message with a specified type (`LoggerMessageType`) will be in the logger
    /// output (i.e. will not be filtered out).
    ///
    /// - Parameter type: The type of message (`LoggerMessageType`).
    ///
    /// - Returns: A Boolean indicating whether a message of the specified type
    ///           (`LoggerMessageType`) will be in the logger output.
    func isLogging(_ level: LoggerMessageType) -> Bool
}

final class ApplicationLogger: Logger {
    fileprivate let type: LoggerMessageType

    /// Create a `Logger` instance.
    ///
    /// - Parameter type: The most detailed message type (`LoggerMessageType`) to see in the
    ///                  output of the logger. Defaults to `verbose`.
    public init(_ type: LoggerMessageType = .verbose) {
        self.type = type
    }

    func doPrint(_ message: String) {
        print(message)
    }

    func log(_ type: LoggerMessageType, msg: String, functionName: String, lineNum: Int, fileName: String) {
        guard isLogging(type) else {
            return
        }
        doPrint("[\(type)] [\(getFile(fileName)):\(lineNum) \(functionName)] \(msg)")
    }

    func getFile(_ path: String) -> String {
        guard let range = path.range(of: "/", options: .backwards) else {
            return path
        }
        return String(path[range.upperBound...])
    }

    /// Indicates if a message with a specified type (`LoggerMessageType`) will be in the logger
    /// output (i.e. will not be filtered out).
    ///
    /// ### Usage Example: ###
    /// The logger is set up to log `warning` level messages and all levels below, that is, it will
    /// show messages of type `warning` and `error`. This means a `verbose` level message will not be displayed.
    /// ```swift
    /// let logger = ApplicationLogger(.warning)
    /// Log.logger = logger
    /// logger.isLogging(.warning) // Returns true
    /// logger.isLogging(.verbose) // Returns false
    /// ```
    /// - Parameter type: The type of message (`LoggerMessageType`).
    ///
    /// - Returns: A Boolean indicating whether a message of the specified type
    ///           (`LoggerMessageType`) will be in the logger output.
    public func isLogging(_ type: LoggerMessageType) -> Bool {
        return type.rawValue >= self.type.rawValue
    }
}

/// A class of static members used by anyone who wants to log messages.
public class Log {
    /// An instance of the logger. It should usually be the one and only reference
    /// of the `Logger` protocol implementation in the system.
    public static var logger: Logger?

    /// Log a message for use when in verbose logging mode.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public static func verbose(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.verbose) {
            logger.log(.verbose, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Log an informational message.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public class func info(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.info) {
            logger.log(.info, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Log a warning message.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public class func warning(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.warning) {
            logger.log(.warning, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Log an error message.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public class func error(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.error) {
            logger.log(.error, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Log a debugging message.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public class func debug(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.debug) {
            logger.log(.debug, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Log a message when entering a function.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public class func entry(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.entry) {
            logger.log(.entry, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Log a message when exiting a function.
    ///
    /// - Parameter msg: The message to be logged.
    /// - Parameter functionName: The name of the function invoking the logger API.
    ///                          Defaults to the name of the function invoking
    ///                          this function.
    /// - Parameter lineNum: The line in the source code of the function invoking the
    ///                     logger API. Defaults to the line of the
    ///                     function invoking this function.
    /// - Parameter fileName: The file containing the source code of the function invoking the
    ///                      logger API. Defaults to the name of the file containing the function
    ///                      which invokes this function.
    public class func exit(_ msg: @autoclosure () -> String, functionName: String = #function, lineNum: Int = #line, fileName: String = #file) {
        if let logger = logger, logger.isLogging(.exit) {
            logger.log(.exit, msg: msg(), functionName: functionName, lineNum: lineNum, fileName: fileName)
        }
    }

    /// Indicates if a message with a specified type (`LoggerMessageType`) will be in the logger
    /// output (i.e. will not be filtered out).
    ///
    /// - Parameter type: The type of message (`LoggerMessageType`).
    ///
    /// - Returns: A Boolean indicating whether a message of the specified type
    ///           (`LoggerMessageType`) will be in the logger output.
    public class func isLogging(_ level: LoggerMessageType) -> Bool {
        guard let logger = logger else {
            return false
        }
        return logger.isLogging(level)
    }
}
