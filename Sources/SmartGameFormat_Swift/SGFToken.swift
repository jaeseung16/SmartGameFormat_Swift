//
//  SGFToken.swift
//  Go
//
//  Created by Jae Seung Lee on 1/13/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public enum SGFToken: String {
    // SGF Properties (FF[4]) https://www.red-bean.com/sgf/properties.html
    case NONE
    case UNKNOWN
    case B // Execute a black move
    case W // Execute a white move
    case AB // Add black stones to the board
    case AW // Add white stones to the board
    case AE // Clear the given points on the board
    case N // Provides a name for the node
    case C // Provides a comment text for the given node
    case BL // Time left for black
    case WL // Time left for white after the move was made
    case OB // Number of black moves left
    case OW // Number of white moves left
    case FF // Defines the used file format
    case CA // Provides the used charset for SimpleText and Text type
    case GM // Defines the type of game
    case SZ // Defines the size of the board
    case ST // Defines how variations should be shown
    case AP // Provides the name and version number of the application used to create this gametree
    case GN // Provides a name for the game
    case GC // Provides some extra information about the following game
    case PB // rovides the name of the black player
    case PW // Provides the name of the white player
    case BR // Provides the rank of the black player
    case WR // Provides the rank of the white player
    case PC // Provides the place where the games was played
    case DT // Provides the date when the game was played
    case RE // Provides the result of the game
    case KM // Defines the komi
    case KI
    case HA // Defines the number of handicap stones
    case TM // Provides the time limits of the game
    case EV // Provides the name of the event
    case RO // Provides round-number and type of round
    case SO // Provides the name of the source
    case US // Provides the name of the user
    case BT // Provides the name of the black team
    case WT // Provide the name of the white team
    case RU // Provides the used rules for this game
    case AN // Provides the name of the person
    case OT // Describes the method used for overtime (byo-yomi)
    case ON // Provides some information about the opening played
    case CP // Any copyright information
    case L
    case LB // Writes the given text on the board
    case AR // Viewers should draw an arrow pointing FROM the first point TO the second point
    case LN // Applications should draw a simple line form one point to the other
    case M
    case MA // Marks the given points with an 'X'
    case TR // Marks the given points with a triangle
    case CR // Marks the given points with a circle
    case TB // Specifies the black territory or area
    case TW // Specifies the white territory or area
    case SQ // Marks the given points with a square
    case SL // Selected points. Type of markup unknown
    case DD // Dim (grey out) the given points
    case PL // PL tells whose turn it is to play
    case V // Define a value for the node
    case GB // Something good for black
    case GW // Something good for white
    case UC // The position is unclear
    case DM // The position is even
    case TE // The played move is a tesuji (good move)
    case BM // The played move is bad
    case DO // The played move is doubtful
    case IT // The played move is interesting
    case HO // Node is a 'hotspot'
    case KO // Execute a given move (B or W) even it's illegal
    case FG // The figure property is used to divide a game into different figures for printing
    case MN // Sets the move number to the given value
    case VW // View only part of the board
    case PM // This property is used for printing
}
