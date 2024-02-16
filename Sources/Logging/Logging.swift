import Foundation

protocol AKLoggerProtocol {
    func trace<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func debug<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func info<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func notice<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func warn<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func error<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func critical<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
}

public struct AKLog: AKLoggerProtocol {

    internal var logHandler: (String) -> Void = { message in
        print(message)
    }

    internal var dateFormatter: (Date) -> String = { date in
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }

    // MEMO: 現在はLogLevelのIntは使用していないが、後にレベルごとに出力内容を変える可能性がある。
    private enum LogLevel: Int {
        case trace    = 100
        case debug    = 200
        case info     = 300
        case notice   = 400
        case warn     = 500
        case error    = 600
        case critical = 700

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

    private func log<T>(_ message: @autoclosure () -> T,
                        level: LogLevel, filename: String, line: Int, function: String) {
        let date = dateFormatter(Date())
        let levelStr = level.stringValue()
        let cleanedfile = cleanedFilename(filename)
        let msg = message()

        let logMessage = "\(date) [\(levelStr)] \(cleanedfile):\(line) - \(function):\(msg)"
        logHandler(logMessage)
    }

    private var cleanedFilenamesCache: NSCache<AnyObject, AnyObject> = NSCache()
    // 「フルパス+ファイル名」から「ファイル名」のみに抽出
    private func cleanedFilename(_ filename: String) -> String {
        if let cleanedfile: String = cleanedFilenamesCache.object(forKey: filename as AnyObject) as? String {
            return cleanedfile
        } else {
            var retval = ""
            let items = filename.split { $0 == "/" }.map(String.init)

            if items.count > 0 {
                retval = items.last!
            }
            cleanedFilenamesCache.setObject(retval as AnyObject, forKey: filename as AnyObject)
            return retval
        }
    }
}

extension AKLog {
    public func trace<T>(_ message: @autoclosure () -> T,
                         filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .trace, filename: filename, line: line, function: function)
    }

    public func debug<T>(_ message: @autoclosure () -> T,
                         filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .debug, filename: filename, line: line, function: function)
    }

    public func info<T>(_ message: @autoclosure () -> T,
                        filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .info, filename: filename, line: line, function: function)
    }

    public func notice<T>(_ message: @autoclosure () -> T,
                          filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .notice, filename: filename, line: line, function: function)
    }

    public func warn<T>(_ message: @autoclosure () -> T,
                        filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .warn, filename: filename, line: line, function: function)
    }

    public func error<T>(_ message: @autoclosure () -> T,
                         filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .error, filename: filename, line: line, function: function)
    }

    public func critical<T>(_ message: @autoclosure () -> T,
                            filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .critical, filename: filename, line: line, function: function)
    }
}
