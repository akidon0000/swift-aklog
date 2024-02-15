import XCTest
@testable import AKLogger

final class AKLoggerTests: XCTestCase {

    func testLogOutput() {
        var loggedMessages: [String] = []
        var logger = AKLogger()
        logger.logHandler = { message in
            loggedMessages.append(message)
        }
        logger.dateFormatter = { date in
            return "00:00:00"
        }

        logger.trace("traceメッセージ")
        let traceMessage = "00:00:00 [TRACE] LoggingTests.swift:\(#line-1) - \(#function):traceメッセージ"
        XCTAssertEqual(loggedMessages[0], traceMessage)


        logger.debug("debugメッセージ")
        let debugMessage = "00:00:00 [DEBUG] LoggingTests.swift:\(#line-1) - \(#function):debugメッセージ"
        XCTAssertEqual(loggedMessages[1], debugMessage)


        logger.info("infoメッセージ")
        let infoMessage = "00:00:00 [INFO] LoggingTests.swift:\(#line-1) - \(#function):infoメッセージ"
        XCTAssertEqual(loggedMessages[2], infoMessage)


        logger.notice("noticeメッセージ")
        let noticeMessage = "00:00:00 [NOTICE] LoggingTests.swift:\(#line-1) - \(#function):noticeメッセージ"
        XCTAssertEqual(loggedMessages[3], noticeMessage)


        logger.warn("warnメッセージ")
        let warnMessage = "00:00:00 [WARN] LoggingTests.swift:\(#line-1) - \(#function):warnメッセージ"
        XCTAssertEqual(loggedMessages[4], warnMessage)


        logger.error("errorメッセージ")
        let errorMessage = "00:00:00 [ERROR] LoggingTests.swift:\(#line-1) - \(#function):errorメッセージ"
        XCTAssertEqual(loggedMessages[5], errorMessage)


        logger.critical("criticalメッセージ")
        let criticalMessage = "00:00:00 [CRITICAL] LoggingTests.swift:\(#line-1) - \(#function):criticalメッセージ"
        XCTAssertEqual(loggedMessages[6], criticalMessage)

    }
}
