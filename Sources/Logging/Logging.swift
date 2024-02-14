import Foundation

protocol AKLoggerProtocol {
    func trace<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func debug<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func info<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func notice<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func warn<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func error<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
    func criti<T>(_ message: @autoclosure () -> T, filename: String, line: Int, function: String)
}

public struct AKLogger: AKLoggerProtocol {

    internal var logHandler: (String) -> Void = { message in
        print(message)
    }

    private enum LogLevel: Int {
        case trace  = 100
        case debug  = 200
        case info   = 300
        case notice = 400
        case warn   = 500
        case error  = 600
        case criti  = 700

        func stringValue() -> String {
            switch self {
            case .trace:  return "TRACE"
            case .debug:  return "DEBUG"
            case .info:   return "INFO"
            case .notice: return "NOTICE"
            case .warn:   return "WARN"
            case .error:  return "ERROR"
            case .criti:  return "CRITI"
            }
        }
    }

    private func log<T>(_ message: @autoclosure () -> T,
                        level: LogLevel, filename: String, line: Int, function: String) {
        let cleanedfile = cleanedFilename(filename)

        let msg = message()
        var logMessage = ""

        logMessage = "\(dateFormatter.string(from: Date())) [\(level.stringValue())] \(cleanedfile):\(line) - \(msg)"
        logHandler(logMessage)
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    private var cleanedFilenamesCache: NSCache<AnyObject, AnyObject> = NSCache()
    private func cleanedFilename(_ filename: String) -> String {
        if let cleanedfile:String = cleanedFilenamesCache.object(forKey: filename as AnyObject) as? String {
            return cleanedfile
        } else {
            var retval = ""
            let items = filename.split{$0 == "/"}.map(String.init)

            if items.count > 0 {
                retval = items.last!
            }
            cleanedFilenamesCache.setObject(retval as AnyObject, forKey: filename as AnyObject)
            return retval
        }
    }
}

extension AKLogger {
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

    public func criti<T>(_ message: @autoclosure () -> T,
                         filename: String = #file, line: Int = #line, function: String = #function) {
        log(message(), level: .criti, filename: filename, line: line, function: function)
    }
}
