//
//  SGFGameInfo.swift
//  Go
//
//  Created by Jae Seung Lee on 1/18/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public struct SGFGameInfo {
    private static let emptyString = ""
    public static let tokens: Set<SGFToken> = [.C, .AP, .CA, .FF, .GM, .ST, .SZ,
                                        .AN, .BR, .BT, .CP, .DT,
                                        .EV, .GN, .GC, .OT, .PB,
                                        .PC, .PW, .RE, .RO, .RU,
                                        .SO, .TM, .US, .WR, .WT]
    
    public var infos: [SGFToken: String] = [:]
    
    // Provides the name and version number of the application used to create this gametree.
    public var comment: String {
        return infos[.C] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name and version number of the application used to create this gametree.
    public var application: String {
        return infos[.AP] ?? SGFGameInfo.emptyString
    }
    
    // Provides the used charset for SimpleText and Text type.
    public var characterSet: String {
        return infos[.CA] ?? SGFGameInfo.emptyString
    }
    
    // Defines the used file format.
    public var fileFormat: String {
        return infos[.FF] ?? SGFGameInfo.emptyString
    }
    
    // Defines the type of game. Valid numbers are:
    // Go = 1, Othello = 2, chess = 3,
    // Gomoku+Renju = 4, Nine Men's Morris = 5, Backgammon = 6,
    // Chinese chess = 7, Shogi = 8, Lines of Action = 9,
    // Ataxx = 10, Hex = 11, Jungle = 12, Neutron = 13,
    // Philosopher's Football = 14, Quadrature = 15, Trax = 16,
    // Tantrix = 17, Amazons = 18, Octi = 19, Gess = 20,
    // Twixt = 21, Zertz = 22, Plateau = 23, Yinsh = 24,
    // Punct = 25, Gobblet = 26, hive = 27, Exxit = 28,
    // Hnefatal = 29, Kuba = 30, Tripples = 31, Chase = 32,
    // Tumbling Down = 33, Sahara = 34, Byte = 35, Focus = 36,
    // Dvonn = 37, Tamsk = 38, Gipf = 39, Kropki = 40.
    public var gameType: String {
        return infos[.GM] ?? SGFGameInfo.emptyString
    }
    
    // Defines how variations should be shown
    // 1) show variations of successor node (children) (value: 0)
    //    show variations of current node   (siblings) (value: 1)
    // 2) do board markup         (value: 0)
    //    no (auto-) board markup (value: 2)
    // The  final number is calculated by adding the values of each option.
    // Example: 3 = no board markup/variations of current node
    //          1 = board markup/variations of current node
    // Default value: 0
    public var variationStyle: String {
        return infos[.ST] ?? SGFGameInfo.emptyString
    }
    
    // Defines the size of the board.
    public var boardSize: String {
        return infos[.SZ] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the person, who made the annotations to the game.
    public var annotator: String {
        return infos[.AN] ?? SGFGameInfo.emptyString
    }
    
    // Provides the rank of the black player.
    public var rankBalck: String {
        return infos[.BR] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the black team
    public var teamBlack: String {
        return infos[.BT] ?? SGFGameInfo.emptyString
    }
    
    // Any copyright information
    public var copyright: String {
        return infos[.CP] ?? SGFGameInfo.emptyString
    }
    
    // Provides the date when the game was played.
    public var date: String {
        return infos[.DT] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the event.
    public var eventName: String {
        return infos[.EV] ?? SGFGameInfo.emptyString
    }
    
    // Provides a name for the game.
    public var gameName: String {
        return infos[.GN] ?? SGFGameInfo.emptyString
    }
    
    // Provides some extra information about the following game.
    public var gameComment: String {
        return infos[.GC] ?? SGFGameInfo.emptyString
    }
    
    // Provides some information about the opening played
    public var openingPattern: String {
        return infos[.OT] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the white player.
    public var playerBlack: String {
        return infos[.PB] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the white player.
    public var place: String {
        return infos[.PC] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the white player.
    public var playerWhite: String {
        return infos[.PW] ?? SGFGameInfo.emptyString
    }
    
    // Provides round-number and type of round
    // It is MANDATORY to use the following format:
    // "0" (zero) or "Draw" for a draw (jigo),
    // "B+" ["score"] for a black win and
    // "W+" ["score"] for a white win
    // Score is optional (some games don't have a score e.g. chess).
    // If the score is given it has to be given as a real value, e.g. "B+0.5", "W+64", "B+12.5"
    // Use "B+R" or "B+Resign" and "W+R" or "W+Resign" for a win by resignation. Applications must not write "Black resigns".
    // Use "B+T" or "B+Time" and "W+T" or "W+Time" for a win on time,
    // "B+F" or "B+Forfeit" and "W+F" or "W+Forfeit" for a win by forfeit,
    // "Void" for no result or suspended play and
    // "?" for an unknown result.
    public var result: String {
        return infos[.RE] ?? SGFGameInfo.emptyString
    }
    
    // Provides round-number and type of round
    public var round: String {
        return infos[.RO] ?? SGFGameInfo.emptyString
    }
    
    // Provides the used rules for this game.
    public var rule: String {
        return infos[.RU] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the source (e.g. book, journal, ...).
    public var source: String {
        return infos[.SO] ?? SGFGameInfo.emptyString
    }
    
    // Provides the time limits of the game. The time limit is given in seconds.
    public var timeLimit: String {
        return infos[.TM] ?? SGFGameInfo.emptyString
    }
    
    // Provides the name of the user (or program), who entered the game.
    public var userName: String {
        return infos[.US] ?? SGFGameInfo.emptyString
    }
    
    // Provides the rank of the white player
    public var rankWhite: String {
        return infos[.WR] ?? SGFGameInfo.emptyString
    }
    
    // Provide the name of the white team, if game was part of a team-match
    public var teamWhite: String {
        return infos[.WT] ?? SGFGameInfo.emptyString
    }
}
