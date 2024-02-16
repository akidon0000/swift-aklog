import Foundation

protocol AKLoggerProtocol {
    static func trace<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    static func debug<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    static func info<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    static func notice<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    static func warn<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    static func error<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    static func critical<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
}

public struct AKLog: AKLoggerProtocol {

    static var logHandler: (String) -> Void = { message in
        print(message)
    }

    static var dateFormatter: (Date) -> String = { date in
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }

    // MEMO: 現在はLogLevelのIntは使用していないが、後にレベルごとに出力内容を変える可能性がある。
    private enum LogLevel: Int {
        case trace = 100, debug = 200, info = 300, notice = 400, warn = 500, error = 600, critical = 700

        func stringValue() -> String {
            switch self {
            case .trace:    return "TRACE"
            case .debug:    return "DEBUG"
            case .info:     return "INFO"
            case .notice:   return "NOTICE"
            case .warn:     return "WARN"
            case .error:    return "ERROR"
            case .critical: return "CRITICAL"
            }
        }
    }

    private static func log<T>(_ message: @autoclosure () -> T, level: LogLevel, filename: String, line: Int, function: String) {
        let date = dateFormatter(Date())
        let levelStr = level.stringValue()
        // フルパス+ファイル名から、ファイル名のみを抽出
        let cleanedFilename = filename.components(separatedBy: "/").last ?? filename

        let logMessage = "\(date) [\(levelStr)] \(cleanedFilename):\(line) - \(function):\(message())"
        logHandler(logMessage)
    }

    public static func trace<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .trace, filename: filename, line: line, function: function)
    }

    public static func debug<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .debug, filename: filename, line: line, function: function)
    }

    public static func info<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .info, filename: filename, line: line, function: function)
    }

    public static func notice<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .notice, filename: filename, line: line, function: function)
    }

    public static func warn<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .warn, filename: filename, line: line, function: function)
    }

    public static func error<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .error, filename: filename, line: line, function: function)
    }

    public static func critical<T>(_ message: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .critical, filename: filename, line: line, function: function)
    }
}
