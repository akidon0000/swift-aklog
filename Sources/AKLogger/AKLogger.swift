// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public protocol LogDestination {
    func log<T>( _ message: @escaping @autoclosure () -> T, level: LogLevel, filename: String, line: Int)
}

public struct AKLogger {
    static var logDestinations: [LogDestination] = [] // インスタンス変数からクラス変数へ変更

    public static func trace<T>( _ message: @autoclosure () -> T, filename: String = #file, line: Int = #line) {
        logInternal(message, level: LogLevel.trace, filename: filename, line: line)
    }

    public static func debug<T>( _ message: @autoclosure () -> T, filename: String = #file, line: Int = #line) {
        logInternal(message, level: LogLevel.debug, filename: filename, line: line)
    }

    public static func info<T>( _ message: @autoclosure () -> T, filename: String = #file, line: Int = #line) {
        logInternal(message, level: LogLevel.info, filename: filename, line: line)
    }

    public static func warn<T>( _ message: @autoclosure () -> T, filename: String = #file, line: Int = #line) {
        logInternal(message, level: LogLevel.warn, filename: filename, line: line)
    }

    public static func error<T>( _ message: @autoclosure () -> T, filename: String = #file, line: Int = #line) {
        logInternal(message, level: LogLevel.error, filename: filename, line: line)
    }

    public static func fatal<T>( _ message: @autoclosure () -> T, filename: String = #file, line: Int = #line) {
        logInternal(message, level: LogLevel.fatal, filename: filename, line: line)
    }

    fileprivate static func logInternal<T>( _ message: @autoclosure () -> T, level: LogLevel, filename: String, line: Int) {
        // let cleanedfile = filename // コメントアウトされたコードの扱いを確認
        for dest in logDestinations {
            dest.log(message, level: level, filename: filename, line: line)
        }
    }
}

public enum LogLevel: String {
    case trace  = "TRACE"
    case debug  = "DEBUG"
    case info   = "INFO "
    case warn   = "WARN "
    case error  = "ERROR"
    case fatal  = "FATAL"
}

class ConsoleDestination: LogDestination {
    let dateFormatter = DateFormatter()
    let serialLogQueue: DispatchQueue = DispatchQueue(label: "ConsoleDestinationQueue")

    init() {
        dateFormatter.dateFormat = "HH:mm:ss:SSS"
    }

    func log<T>( _ message: @escaping @autoclosure () -> T, level: LogLevel, filename: String, line: Int) {
        let serialLogQueue: DispatchQueue = DispatchQueue(label: "ConsoleDestinationQueue")
        serialLogQueue.async {
            let msg = message()
            print("\(self.dateFormatter.string(from: Date())):\(level):\(filename):\(line) - \(msg)")
        }
    }
}
