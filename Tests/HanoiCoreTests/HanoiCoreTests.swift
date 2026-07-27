import XCTest
@testable import HanoiCore

final class HanoiCoreTests: XCTestCase {
    func testAscendingPieces() {
        let counts = [3, 4, 5, 6, 10]
        
        for count in counts {
            XCTContext.runActivity(named: "Testing for ascending pieces with \(count) pieces") { _ in
                let game = Game(pieces: count)
                game.afterMove = { game, from, to in
                    XCTAssert(zip(to.pieces, to.pieces.dropFirst()).allSatisfy { $0.size < $1.size }, "A piece can't be on a piece that's smaller than it.")
                }
                game.stacks[0].solve(count: count, to: game.stacks[2])
            }
        }
    }
    
    func testSolve() {
        let counts = [3, 4, 5, 6, 10]
        
        for count in counts {
            XCTContext.runActivity(named: "Testing for correctly solving with \(count) pieces") { _ in
                let game = Game(pieces: count)
                game.stacks[0].solve(count: count, to: game.stacks[2])
                XCTAssertEqual(game.stacks[0].pieces.count, 0, "The first stack shouldn't have any pieces.")
                XCTAssertEqual(game.stacks[1].pieces.count, 0, "The second stack shouldn't have any pieces.")
                XCTAssertEqual(game.stacks[2].pieces.count, count, "The third stack should have all of the pieces.")
            }
        }
    }
}
