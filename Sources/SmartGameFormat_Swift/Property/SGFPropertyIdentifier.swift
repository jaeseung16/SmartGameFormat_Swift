//
//  SGFPropertyIdentifier.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/7/25.
//

public enum SGFPropertyIdentifier: String {
    case AB // setup        Add black
    case AE // setup        Add empty
    case AN // game-info    Annotation
    case AP // root         Application
    case AR // -            Arrow
    case AW // setup        Add white
    case B  // move         Black
    case BL // move         Black time left
    case BM // move         Bad move
    case BR // game-info    Black rank
    case BT // game-info    Black team
    case C  // -            Comment
    case CA // root         Charset
    case CP // game-info    Copyright
    case CR // -            Circle
    case DD // - [inherit]  Dim points
    case DM // -            Even position
    case DO // move         Doubtful
    case DT // game-info    Date
    case EV // game-info    Event
    case FF // root         Fileformat
    case FG // -            Figure
    case GB // -            Good for Black
    case GC // game-info    Game comment
    case GM // root         Game
    case GN // game-info    Game name
    case GW // -            Good for White
    case HA // game-info    Handicap
    case HO // -            Hotspot
    case IT // move         Interesting
    case KM // game-info    Komi
    case KO // move         Ko
    case LB // -            Label
    case LN // -            Line
    case MA // -            Mark
    case MN // move         set move number
    case N  // -            Nodename
    case OB // move         OtStones Black
    case ON // game-info    Opening
    case OT // game-info    Overtime
    case OW // move         OtStones White
    case PB // game-info    Player Black
    case PC // game-info    Place
    case PL // setup        Player to play
    case PM // - [inherit]  Print move mode
    case PW // game-info    Player White
    case RE // game-info    Result
    case RO // game-info    Round
    case RU // game-info    Rules
    case SL // -            Selected
    case SO // game-info    Source
    case SQ // -            Square
    case ST // root         Style
    case SZ // root         Size
    case TB // -            Territory Black
    case TE // move         Tesuji
    case TM // game-info    Timelimit
    case TR // -            Triangle
    case TW // -            Territory White
    case UC // -            Unclear pos
    case US // game-info    User
    case V  // -            Value
    case VW // - [inherit]  View
    case W  // move         White
    case WL // move         White time left
    case WR // game-info    White rank
    case WT // game-info    White team
}
