//
//  CLI.swift
//  Hanoi
//
//  Created by Jack Huey on 7/25/26.
//

import ArgumentParser
import HanoiCore

@main
public struct Hanoi: ParsableCommand {
    public static var configuration = CommandConfiguration(
        abstract: "A utility to solve the Tower of Hanoi.",
        version: "1.0.0"
    )
    
    @Argument(help: "How many pieces the Tower should have.")
    var pieces: Int

    @Flag(name: .customShort("a"), help: "Don't wait for confirmation after each move.")
    var showAll = false
    
    public init() {}
    
    public mutating func run() throws {
        let game = Game(pieces: pieces)
        if game.minMoves >= 50 {
            var ask = true
            print("It would take \(game.minMoves) moves to solve it with this many pieces! Are you sure you want to see the moves? (y/n) ", terminator: "")
            while ask {
                if let confirm = readLine()?.lowercased(), ["y", "n"].contains(confirm) {
                    guard confirm == "y" else { return }
                    ask = false
                } else {
                    print("(y/n) ", terminator: "")
                }
            }
        }
        
        game.beforeMove = { [showAll] game, from, to in
            print((showAll || game.moves == 0 ? "" : "\u{001B}[1A\u{001B}[2K") + "Move \(game.moves + 1)/\(game.minMoves): Move \(from.pieces[0].size) from stack \(game.stacks.firstIndex(of: from)! + 1) to \(game.stacks.firstIndex(of: to)! + 1).")
            if !showAll && game.moves != game.minMoves - 1 {
                print("Click enter to continue. ", terminator: "")
                _ = readLine()
            }
        }
        
        game.stacks[0].solve(count: pieces, to: game.stacks[2])
        
    }
}
