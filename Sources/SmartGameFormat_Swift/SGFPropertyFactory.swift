//
//  SGFPropertyTypeFactory.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFPropertyFactory {
    public static func create(identifier: SGFPropertyIdentifier, values: [String], context: SGFContext) -> (any SGFProperty)? {
        switch identifier {
            // number
        case .FF, .GM, .HA, .MN, .OB, .OW, .PM, .ST, .SZ:
            return SGFNumber(values: values, context: context)
            // real
        case .BL, .KM, .TM, .V, .WL:
            return SGFReal(values: values, context: context)
            // double
        case .BM, .DM, .GB, .GW, .HO, .TE, .UC:
            return SGFDouble(values: values, context: context)
            // color
        case .PL:
            return SGFColor.from(values)
            // simpletext
        case .AN, .BR, .BT, .CA, .CP, .DT, .EV, .GN, .N, .ON, .OT, .PB, .PC, .PW, .RE, .RO, .RU, .SO, .US, .WR, .WT:
            return SGFSimpleText(values: values, context: context)
            // text
        case .C, .GC:
            return SGFText(values: values, context: context)
            // point?
            // move
        case .B, .W:
            return SGFMove(values: values, context: context)
            // point list
        case .AE, .CR, .MA, .SL, .SQ, .TR:
            return SGFPointList(values: values, context: context)
            // point elist
        case .DD, .TB, .TW, .VW:
            return SGFPointElist(values: values, context: context)
            // stone list
        case .AB, .AW:
            return SGFStoneList(values: values, context: context)
            // AP
        case .AP:
            // ARLN list
            return SGFAP(values: values, context: context)
        case .AR, .LN:
            return SGFARLNList(values: values, context: context)
            // FG
        case .FG:
            return SGFFG(values: values, context: context)
            // LB list
        case .LB:
            return SGFLBList(values: values, context: context)
        default :
            return values.isEmpty ? SGFNone(context: context) : SGFSimpleText(values: values, context: context)
        }
    }
}
