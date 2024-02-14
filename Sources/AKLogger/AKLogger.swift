// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

protocol AKLoggerProtocol {
    func trace<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func debug<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func info<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func warn<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func error<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func fatal<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
}

public struct AKLogger: AKLoggerProtocol {

    enum LogLevel: String {
        case trace  = "TRACE"
        case debug  = "DEBUG"
        case info   = "INFO "
        case warn   = "WARN "
        case error  = "ERROR"
        case fatal  = "FATAL"
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    func trace<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .trace, filename: filename, line: line, function: function)
    }

    func debug<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .debug, filename: filename, line: line, function: function)
    }

    func info<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .info, filename: filename, line: line, function: function)
    }

    func warn<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .warn, filename: filename, line: line, function: function)
    }

    func error<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .error, filename: filename, line: line, function: function)
    }

    func fatal<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .fatal, filename: filename, line: line, function: function)
    }

    private func log<T>(_ message: @autoclosure () -> T, level: LogLevel, filename: String, line: Int, function: String) {
        let msg = message()
        print("\(dateFormatter.string(from: Date())):\(level.rawValue):\(filename):\(line) - \(msg)")
    }
}
