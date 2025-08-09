//
//  SGFGameTest.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/5/25.
//

import Testing
import Foundation
@testable import SmartGameFormat_Swift

struct SGFGameTest {
    
    let sgfString = """
        (
        ;FF[1]SZ[19]PB[Player]PW[COMLv12]BS[0]WS[12]KM[6.5]HA[0]RU[JP]AP[Champ Go HD]VW[]
        GN[Champ Go HD]GC[]DT[2025-06-28 11:17:07]RE[B+R]
        ;B[pp]TL[0,0];W[qn]TL[0,0];B[dp]TL[1,0];W[nq]TL[0,0]
        ;B[pn]TL[8,0];W[pm]TL[0,0];B[on]TL[0,0];W[qo]TL[0,0]
        ;B[qp]TL[0,0];W[qj]TL[0,0];B[np]TL[2,0];W[dd]TL[0,0]
        ;B[pc]TL[5,0];W[pe]TL[0,0];B[qe]TL[2,0];W[qf]TL[0,0]
        ;B[qd]TL[0,0];W[pf]TL[0,0];B[nc]TL[0,0];W[fq]TL[0,0]
        ;B[hq]TL[4,0];W[jq]TL[0,0];B[fp]TL[1,0];W[gq]TL[0,0]
        ;B[gp]TL[2,0];W[hr]TL[0,0];B[hp]TL[0,0];W[iq]TL[0,0]
        ;B[mq]TL[3,0];W[eq]TL[0,0];B[dq]TL[3,0];W[dr]TL[0,0]
        ;B[cr]TL[2,0];W[ep]TL[0,0];B[eo]TL[1,0];W[do]TL[0,0]
        ;B[er]TL[3,0];W[fr]TL[0,0];B[ds]TL[0,0];W[en]TL[0,0]
        ;B[fo]TL[1,0];W[co]TL[0,0];B[fs]TL[5,0];W[gr]TL[0,0]
        ;B[fn]TL[5,0];W[bq]TL[0,0];B[br]TL[7,0];W[cq]TL[0,0]
        ;B[jo]TL[3,0];W[em]TL[0,0];B[kp]TL[3,0];W[kq]TL[0,0]
        ;B[lq]TL[1,0];W[ip]TL[0,0];B[io]TL[1,0];W[lr]TL[0,0]
        ;B[mr]TL[1,0];W[kr]TL[0,0];B[is]TL[1,0];W[ir]TL[0,0]
        ;B[js]TL[0,0];W[cp]TL[0,0];B[dr]TL[1,0];W[bs]TL[0,0]
        ;B[ar]TL[1,0];W[fm]TL[0,0];B[hn]TL[2,0];W[hl]TL[0,0]
        ;B[cf]TL[8,0];W[gc]TL[0,0];B[ci]TL[5,0];W[jc]TL[0,0]
        ;B[ni]TL[35,0];W[mf]TL[0,0];B[lc]TL[1,0];W[ke]TL[0,0]
        ;B[nl]TL[5,0];W[oj]TL[0,0];B[nj]TL[1,0];W[ok]TL[0,0]
        ;B[nk]TL[4,0];W[oi]TL[0,0];B[ng]TL[1,0];W[mh]TL[0,0]
        ;B[nh]TL[0,0];W[od]TL[0,0];B[oc]TL[1,0];W[rf]TL[0,0]
        ;B[cm]TL[14,0];W[bl]TL[0,0];B[cl]TL[4,0];W[bm]TL[0,0]
        ;B[bk]TL[4,0];W[cd]TL[0,0];B[be]TL[1,0];W[ck]TL[0,0]
        ;B[bj]TL[4,0];W[dk]TL[0,0];B[bn]TL[0,0];W[df]TL[0,0]
        ;B[dg]TL[5,0];W[eg]TL[0,0];B[ef]TL[4,0];W[ff]TL[0,0]
        ;B[de]TL[0,0];W[ee]TL[0,0];B[df]TL[0,0];W[di]TL[0,0]
        ;B[fe]TL[2,0];W[ge]TL[0,0];B[ed]TL[0,0];W[ec]TL[0,0]
        ;B[fg]TL[1,0];W[gf]TL[0,0];B[eh]TL[1,0];W[ei]TL[0,0]
        ;B[fi]TL[4,0];W[fj]TL[0,0];B[gi]TL[1,0];W[ii]TL[0,0]
        ;B[am]TL[9,0];W[dn]TL[0,0];B[ls]TL[5,0];W[ks]TL[0,0]
        ;B[ms]TL[1,0];W[aq]TL[0,0];B[gs]TL[7,0];W[hs]TL[0,0]
        ;B[jp]TL[1,0];W[es]TL[0,0];B[fs]TL[0,0];W[ch]TL[0,0]
        ;B[bh]TL[6,0];W[gj]TL[0,0];B[hi]TL[2,0];W[hj]TL[0,0]
        ;B[bc]TL[1,0];W[fd]TL[0,0];B[ee]TL[1,0];W[gg]TL[0,0]
        ;B[hh]TL[1,0];W[ig]TL[0,0];B[kb]TL[0,0];W[jb]TL[0,0]
        ;B[ja]TL[1,0];W[ia]TL[0,0];B[ka]TL[0,0];W[sc]TL[0,0]
        ;B[rc]TL[1,0];W[sd]TL[0,0];B[sb]TL[1,0];W[rp]TL[0,0]
        ;B[rq]TL[1,0];W[om]TL[0,0];B[nm]TL[1,0];W[ro]TL[0,0]
        ;B[qr]TL[1,0];W[bd]TL[0,0];B[ad]TL[1,0];W[fh]TL[0,0]
        ;B[eg]TL[3,0];W[dh]TL[0,0];B[cg]TL[1,0];W[rb]TL[0,0]
        ;B[se]TL[2,0];W[cj]TL[0,0];B[bi]TL[1,0];W[re]TL[0,0]
        ;B[rd]TL[1,0];W[cb]TL[0,0];B[cc]TL[3,0];W[dc]TL[0,0]
        ;B[bb]TL[0,0];W[po]TL[0,0];B[oo]TL[1,0];W[sq]TL[0,0]
        ;B[sr]TL[0,0];W[md]TL[0,0];B[sp]TL[11,0];W[mc]TL[0,0]
        ;B[mb]TL[1,0];W[sf]TL[0,0];B[sd]TL[1,0];W[mg]TL[0,0]
        ;B[pg]TL[3,0];W[ph]TL[0,0];B[og]TL[0,0];W[hb]TL[0,0]
        ;B[kc]TL[2,0];W[jr]TL[0,0];B[is]TL[1,0];W[jm]TL[0,0]
        ;B[kl]TL[6,0];W[gh]TL[0,0];B[jh]TL[5,0];W[km]TL[0,0]
        ;B[jl]TL[3,0];W[il]TL[0,0];B[im]TL[1,0];W[ll]TL[0,0]
        ;B[lk]TL[5,0];W[kk]TL[0,0];B[jk]TL[0,0];W[kj]TL[0,0]
        ;B[lm]TL[1,0];W[lj]TL[0,0];B[ml]TL[1,0];W[hm]TL[0,0]
        ;B[in]TL[1,0];W[gn]TL[0,0];B[ho]TL[1,0];W[qm]TL[0,0]
        ;B[ol]TL[1,0];W[pl]TL[0,0];B[jj]TL[1,0];W[ji]TL[0,0]
        ;B[mi]TL[5,0];W[da]TL[0,0];B[li]TL[2,0];W[ki]TL[0,0]
        ;B[lh]TL[0,0];W[kh]TL[0,0];B[lg]TL[0,0];W[ba]TL[0,0]
        ;B[ae]TL[2,0];W[ab]TL[0,0];B[ac]TL[0,0];W[ce]TL[0,0]
        ;B[bf]TL[1,0];W[qg]TL[0,0];B[ej]TL[10,0];W[dj]TL[0,0]
        ;B[dl]TL[0,0];W[ek]TL[0,0];B[el]TL[1,0];W[fl]TL[0,0]
        ;B[kd]TL[6,0];W[cn]TL[0,0];B[al]TL[4,0];W[jd]TL[0,0]
        ;B[le]TL[3,0];W[kf]TL[0,0];B[kg]TL[3,0];W[jg]TL[0,0]
        ;B[lf]TL[0,0];W[nd]TL[0,0];B[me]TL[1,0];W[nf]TL[0,0]
        ;B[of]TL[2,0];W[ld]TL[0,0];B[nb]TL[15,0];W[ne]TL[0,0]
        ;B[pd]TL[9,0];W[oe]TL[0,0];B[qh]TL[3,0];W[rh]TL[0,0]
        ;B[oh]TL[0,0];W[pi]TL[0,0];B[ik]TL[8,0];W[so]TL[0,0]
        ;B[hk]TL[3,0];W[gk]TL[0,0];B[gm]TL[1,0];W[gl]TL[0,0]
        ;B[bo]TL[1,0];W[ao]TL[0,0];B[an]TL[2,0];W[ap]TL[0,0]
        ;B[mj]TL[6,0];W[ij]TL[0,0];B[ll]TL[1,0];W[ca]TL[0,0]
        ;B[aa]TL[2,0];W[la]TL[0,0];B[lb]TL[1,0];W[sq]TL[0,0]
        ;B[ab]TL[8,0];W[dm]TL[0,0];B[sp]TL[1,0];W[bm]TL[0,0]
        ;B[bl]TL[1,0];W[sq]TL[0,0];B[jf]TL[6,0];W[je]TL[0,0]
        ;B[sp]TL[0,0];W[bg]TL[0,0];B[ag]TL[2,0];W[sq]TL[0,0]
        ;B[ea]TL[10,0];W[db]TL[0,0];B[sp]TL[0,0];W[oq]TL[0,0]
        ;B[op]TL[6,0];W[sq]TL[0,0];B[gd]TL[4,0];W[fc]TL[0,0]
        ;B[sp]TL[0,0]
        )
        """
    
    @Test func testGetMainSequence() async throws {
        if let sgfGame = SGFGame.from(string: sgfString) {
            if let children = sgfGame.root?.children {
                children.forEach { print($0.debugDescription) }
            }
            print("mainSequence=\(sgfGame.mainSequence)")
            #expect(sgfGame.mainSequence.count == 297)
        }
    }
    
    // TODO: - generate a sgf file from sgfGame
    @Test func testSerialize() async throws {
        if let sgfGame = SGFGame.from(string: sgfString) {
            //print("\(sgfGame.mainSequence)")
            let result = sgfGame.serialize()
            print("result = \(result)")
        }
    }
    
}
