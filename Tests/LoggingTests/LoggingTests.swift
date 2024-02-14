import XCTest
@testable import AKLogger

final class AKLoggerTests: XCTestCase {
    func testLogOutput() {
        var loggedMessages: [String] = []
        var logger = AKLogger()
        logger.logHandler = { message in
            loggedMessages.append(message)
        }

        logger.trace("traceメッセージ")
        XCTAssertTrue(loggedMessages[0].contains("traceメッセージ"))

        logger.debug("debugメッセージ")
        XCTAssertTrue(loggedMessages[1].contains("debugメッセージ"))

        logger.info("infoメッセージ")
        XCTAssertTrue(loggedMessages[2].contains("infoメッセージ"))

        logger.notice("noticeメッセージ")
        XCTAssertTrue(loggedMessages[3].contains("noticeメッセージ"))

        logger.warn("warnメッセージ")
        XCTAssertTrue(loggedMessages[4].contains("warnメッセージ"))

        logger.error("errorメッセージ")
        XCTAssertTrue(loggedMessages[5].contains("errorメッセージ"))

        logger.criti("critiメッセージ")
        XCTAssertTrue(loggedMessages[6].contains("critiメッセージ"))

        print(loggedMessages)

    }
}
