//
//  Core.swift
//  Hanoi
//
//  Created by Jack Huey on 7/25/26.
//

import Foundation

///A  representation of a game piece
public class Piece: Equatable {
    public let size: Int
    
    public init(size: Int) {
        self.size = size
    }
    
    public static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.size == rhs.size
    }
}

///A  representation of a group of `Piece`s
public class Stack: Equatable {
    let id = UUID()
    public private(set) var pieces: [Piece] = []
    weak var game: Game?
    
    public init?(pieces: [Piece] = [], game: Game) {
        self.pieces = pieces
        self.game = game
    }
    
    ///Moves the top piece from the `Stack` supplying this method to `target`. Calls `game.beforeMove` before incrementing `game.moves` and moving the `Piece` , and `game.afterMove` after
    public func moveTop(to target: Stack) {
        guard let game = self.game else { return }
        guard !self.pieces.isEmpty else { return }
        game.beforeMove(game, self, target)
        game.moves += 1
        target.pieces.insert(self.pieces[0], at: 0)
        self.pieces.remove(at: 0)
        game.afterMove(game, self, target)
    }
    
    ///Solves how to move `count` pieces from the `Stack` supplying this method to `target` and moves them one by one using `moveTop`
    public func solve(count: Int, to target: Stack) {
        guard count > 0 else { return }
        guard let game = self.game else { return }
        guard !self.pieces.isEmpty else { return }
        guard let other = game.stacks.first(where: { $0 != self && $0 != target }) else { return }
        
        if count == 1 {
            self.moveTop(to: target)
        } else {
            self.solve(count: count - 1, to: other)
            self.moveTop(to: target)
            other.solve(count: count - 1, to: target)
        }
    }
    
    public static func == (lhs: Stack, rhs: Stack) -> Bool {
        return lhs.id == rhs.id
    }
}

///A controller for the whole game.
public class Game {
    let count: Int
    ///The number of total moves this game's `Stack`s have made
    public fileprivate(set) var moves: Int = 0
    ///The minimum number of moves it will take to solve the puzzle
    public let minMoves: Int
    public lazy var stacks: [Stack] = {
        return [Stack(pieces: (1...self.count).map { Piece(size: $0) }, game: self)!,
                Stack(game: self)!,
                Stack(game: self)!]
    }()
    
    ///Called before any `Stack`s in this `Game` move pieces and passed a reference to this `Game` instance, a reference to the `Stack` instance that the `Piece` will be moved from, and a reference to the `Stack` instance that the `Piece` will be moved to
    public var beforeMove: (Game, Stack, Stack) -> Void = {_, _, _ in}
    ///Called after any `Stack`s in this `Game` move pieces and passed a reference to this `Game` instance, a reference to the `Stack` instance that the `Piece` was moved from, and a reference to the `Stack` instance that the `Piece` was moved to
    public var afterMove: (Game, Stack, Stack) -> Void = {_, _, _ in}
    
    public init(pieces count: Int) {
        self.count = count
        self.minMoves = Int(pow(2.0, Double(count)) - 1)
    }
}
