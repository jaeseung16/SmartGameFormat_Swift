import XCTest
import os
@testable import SmartGameFormat_Swift

final class SmartGameFormat_SwiftTests: XCTestCase {
    func testSGFParseVariation() throws {
        // an example used in sgflib.py from http://gotools.sourceforge.net/sgfsummary/index.html
        let sgfString = "       (;GM [1]US[someone]CoPyright[\\ Permission to reproduce this game is given.]GN[a-b]EV[None]RE[B+Resign]PW[a]WR[2k*]PB[b]BR[4k*]PC[somewhere]DT[2000-01-16]SZ[19]TM[300]KM[4.5]HA[3]AB[pd][dp][dd];W[pp];B[nq];W[oq]C[ x started observation.](;B[qc]C[ [b\\]: \\\\ hi x! ;-) \\];W[kc])(;B[hc];W[oe]))   "
        
        let parser = SGFParser(sgfString)
        do {
            try parser.parse()
        } catch {
            print("Failed parsing sgfString: \(error)")
        }
    }
    
    func testSGFParseChampGoHD() throws {
        // Generated by 'Champ Go HD'
        let sgfString = "(\n;FF[1]SZ[19]PB[Player]PW[COMLv10]BS[0]WS[10]KM[6.5]HA[0]RU[JP]AP[Champ Go HD]VW[]\nGN[Champ Go HD]GC[]DT[2020-12-31 09:44:05]RE[B+R]\n;B[pq]TL[0,0];W[dp]TL[0,0];B[pd]TL[1,0];W[dc]TL[0,0]\n;B[ce]TL[2,0];W[dh]TL[0,0];B[ed]TL[2,0];W[ec]TL[0,0]\n;B[fd]TL[1,0];W[gc]TL[0,0];B[he]TL[0,0];W[cd]TL[0,0]\n;B[be]TL[2,0];W[ef]TL[0,0];B[de]TL[2,0];W[hc]TL[0,0]\n;B[ci]TL[2,0];W[ch]TL[0,0];B[bh]TL[0,0];W[bg]TL[0,0]\n;B[bj]TL[0,0];W[ah]TL[0,0];B[bi]TL[1,0];W[ej]TL[0,0]\n;B[cm]TL[3,0];W[em]TL[0,0];B[bp]TL[1,0];W[cq]TL[0,0]\n;B[di]TL[6,0];W[ei]TL[0,0];B[eh]TL[0,0];W[fh]TL[0,0]\n;B[eg]TL[0,0];W[dg]TL[0,0];B[fg]TL[0,0];W[gg]TL[0,0]\n;B[ff]TL[0,0];W[gf]TL[0,0];B[fe]TL[2,0];W[ge]TL[0,0]\n;B[gd]TL[5,0];W[hd]TL[0,0];B[gh]TL[0,0];W[fi]TL[0,0]\n;B[hg]TL[0,0];W[gi]TL[0,0];B[hh]TL[1,0];W[ij]TL[0,0]\n;B[jp]TL[25,0];W[hp]TL[0,0];B[fo]TL[29,0];W[fp]TL[0,0]\n;B[do]TL[2,0];W[eo]TL[0,0];B[en]TL[0,0];W[ep]TL[0,0]\n;B[fn]TL[0,0];W[dn]TL[0,0];B[dm]TL[1,0];W[co]TL[0,0]\n;B[bo]TL[3,0];W[bq]TL[0,0];B[fl]TL[2,0];W[el]TL[0,0]\n;B[fm]TL[2,0];W[nc]TL[0,0];B[ld]TL[9,0];W[ne]TL[0,0]\n;B[pf]TL[0,0];W[pb]TL[0,0];B[qc]TL[0,0];W[qh]TL[0,0]\n;B[qj]TL[2,0];W[oh]TL[0,0];B[qb]TL[4,0];W[po]TL[0,0]\n;B[qo]TL[2,0];W[qn]TL[0,0];B[qp]TL[0,0];W[pn]TL[0,0]\n;B[nq]TL[1,0];W[jq]TL[0,0];B[kq]TL[1,0];W[iq]TL[0,0]\n;B[kr]TL[0,0];W[kp]TL[0,0];B[jo]TL[2,0];W[lp]TL[0,0]\n;B[mr]TL[1,0];W[kn]TL[0,0];B[jn]TL[2,0];W[km]TL[0,0]\n;B[jm]TL[0,0];W[kl]TL[0,0];B[jl]TL[0,0];W[kk]TL[0,0]\n;B[jk]TL[0,0];W[jj]TL[0,0];B[kj]TL[2,0];W[ki]TL[0,0]\n;B[lj]TL[0,0];W[li]TL[0,0];B[mj]TL[0,0];W[ni]TL[0,0]\n;B[ko]TL[2,0];W[lo]TL[0,0];B[ln]TL[0,0];W[mm]TL[0,0]\n;B[mn]TL[1,0];W[nn]TL[0,0];B[mo]TL[0,0];W[mp]TL[0,0]\n;B[no]TL[0,0];W[np]TL[0,0];B[nm]TL[2,0];W[ml]TL[0,0]\n;B[oo]TL[7,0];W[op]TL[0,0];B[on]TL[0,0];W[ol]TL[0,0]\n;B[om]TL[60,0];W[pm]TL[0,0];B[nl]TL[1,0];W[nk]TL[0,0]\n;B[ok]TL[8,0];W[pl]TL[0,0];B[mk]TL[0,0];W[nj]TL[0,0]\n;B[ll]TL[2,0];W[mi]TL[0,0];B[lm]TL[1,0];W[pp]TL[0,0]\n;B[qr]TL[1,0];W[oq]TL[0,0];B[or]TL[0,0];W[lb]TL[0,0]\n;B[ie]TL[7,0];W[jd]TL[0,0];B[je]TL[1,0];W[rf]TL[0,0]\n;B[qe]TL[1,0];W[re]TL[0,0];B[rd]TL[0,0];W[pc]TL[0,0]\n;B[oe]TL[2,0];W[od]TL[0,0];B[nf]TL[1,0];W[me]TL[0,0]\n;B[qf]TL[1,0];W[rg]TL[0,0];B[pa]TL[1,0];W[dl]TL[0,0]\n;B[cl]TL[1,0];W[hn]TL[0,0];B[hm]TL[1,0];W[mf]TL[0,0]\n;B[ng]TL[1,0];W[ke]TL[0,0];B[bc]TL[7,0];W[fk]TL[0,0]\n;B[hk]TL[6,0];W[hi]TL[0,0];B[jh]TL[1,0];W[ji]TL[0,0]\n;B[fc]TL[3,0];W[fb]TL[0,0];B[id]TL[0,0];W[ic]TL[0,0]\n;B[jc]TL[1,0];W[kd]TL[0,0];B[gb]TL[1,0];W[hb]TL[0,0]\n;B[eb]TL[1,0];W[ga]TL[0,0];B[db]TL[0,0];W[bn]TL[0,0]\n;B[cn]TL[1,0];W[oa]TL[0,0];B[qa]TL[2,0];W[nb]TL[0,0]\n;B[pi]TL[30,0];W[og]TL[0,0];B[of]TL[1,0];W[qk]TL[0,0]\n;B[pk]TL[1,0];W[rk]TL[0,0];B[rj]TL[1,0];W[rn]TL[0,0]\n;B[ro]TL[0,0];W[so]TL[0,0];B[sp]TL[0,0];W[sn]TL[0,0]\n;B[rq]TL[0,0];W[gk]TL[0,0];B[hl]TL[1,0];W[ik]TL[0,0]\n;B[dk]TL[4,0];W[ek]TL[0,0];B[dj]TL[0,0];W[ih]TL[0,0]\n;B[ig]TL[1,0];W[kh]TL[0,0];B[jg]TL[1,0];W[mg]TL[0,0]\n;B[nh]TL[1,0];W[qg]TL[0,0];B[oi]TL[2,0];W[sd]TL[0,0]\n;B[sc]TL[1,0];W[se]TL[0,0];B[rl]TL[2,0];W[ql]TL[0,0]\n;B[sk]TL[1,0];W[oj]TL[0,0];B[pj]TL[0,0];W[ri]TL[0,0]\n;B[hs]TL[3,0];W[hr]TL[0,0];B[js]TL[0,0];W[gs]TL[0,0]\n;B[is]TL[0,0];W[mq]TL[0,0];B[nr]TL[0,0];W[kg]TL[0,0]\n;B[kf]TL[6,0];W[lf]TL[0,0];B[jf]TL[0,0];W[gr]TL[0,0]\n;B[lq]TL[1,0];W[il]TL[0,0];B[im]TL[1,0];W[rm]TL[0,0]\n;B[sl]TL[2,0];W[si]TL[0,0];B[bm]TL[11,0]\n)\n"
        
        let parser = SGFParser(sgfString)
        do {
            try parser.parse()
        } catch {
            print("Failed parsing sgfString: \(error)")
        }
    }
    
    func testSGFParseFF4EX() throws {
        // ff4_ex.sgf from https://www.red-bean.com/sgf/examples/
        let sgfString = "(;FF[4]AP[Primiview:3.1]GM[1]SZ[19]GN[Gametree 1: properties]US[Arno Hollosi]\n\n(;B[pd]N[Moves, comments, annotations]\nC[Nodename set to: \"Moves, comments, annotations\"];W[dp]GW[1]\nC[Marked as \"Good for White\"];B[pp]GB[2]\nC[Marked as \"Very good for Black\"];W[dc]GW[2]\nC[Marked as \"Very good for White\"];B[pj]DM[1]\nC[Marked as \"Even position\"];W[ci]UC[1]\nC[Marked as \"Unclear position\"];B[jd]TE[1]\nC[Marked as \"Tesuji\" or \"Good move\"];W[jp]BM[2]\nC[Marked as \"Very bad move\"];B[gd]DO[]\nC[Marked as \"Doubtful move\"];W[de]IT[]\nC[Marked as \"Interesting move\"];B[jj];\nC[White \"Pass\" move]W[];\nC[Black \"Pass\" move]B[tt])\n\n(;AB[dd][de][df][dg][do:gq]\n  AW[jd][je][jf][jg][kn:lq][pn:pq]\nN[Setup]C[Black & white stones at the top are added as single stones.\n\nBlack & white stones at the bottom are added using compressed point lists.]\n;AE[ep][fp][kn][lo][lq][pn:pq]\nC[AddEmpty\n\nBlack stones & stones of left white group are erased in FF[3\\] way.\n\nWhite stones at bottom right were erased using compressed point list.]\n;AB[pd]AW[pp]PL[B]C[Added two stones.\n\nNode marked with \"Black to play\".];PL[W]\nC[Node marked with \"White to play\"])\n\n(;AB[dd][de][df][dg][dh][di][dj][nj][ni][nh][nf][ne][nd][ij][ii][ih][hq]\n[gq][fq][eq][dr][ds][dq][dp][cp][bp][ap][iq][ir][is][bo][bn][an][ms][mr]\nAW[pd][pe][pf][pg][ph][pi][pj][fd][fe][ff][fh][fi][fj][kh][ki][kj][os][or]\n[oq][op][pp][qp][rp][sp][ro][rn][sn][nq][mq][lq][kq][kr][ks][fs][gs][gr]\n[er]N[Markup]C[Position set up without compressed point lists.]\n\n;TR[dd][de][df][ed][ee][ef][fd:ff]\n MA[dh][di][dj][ej][ei][eh][fh:fj]\n CR[nd][ne][nf][od][oe][of][pd:pf]\n SQ[nh][ni][nj][oh][oi][oj][ph:pj]\n SL[ih][ii][ij][jj][ji][jh][kh:kj]\n TW[pq:ss][so][lr:ns]\n TB[aq:cs][er:hs][ao]\nC[Markup at top partially using compressed point lists (for markup on white stones); listed clockwise, starting at upper left:\n- TR (triangle)\n- CR (circle)\n- SQ (square)\n- SL (selected points)\n- MA (\'X\')\n\nMarkup at bottom: black & white territory (using compressed point lists)]\n;LB[dc:1][fc:2][nc:3][pc:4][dj:a][fj:b][nj:c]\n[pj:d][gs:ABCDEFGH][gr:ABCDEFG][gq:ABCDEF][gp:ABCDE][go:ABCD][gn:ABC][gm:AB]\n[mm:12][mn:123][mo:1234][mp:12345][mq:123456][mr:1234567][ms:12345678]\nC[Label (LB property)\n\nTop: 8 single char labels (1-4, a-d)\n\nBottom: Labels up to 8 char length.]\n\n;DD[kq:os][dq:hs]\nAR[aa:sc][sa:ac][aa:sa][aa:ac][cd:cj]\n  [gd:md][fh:ij][kj:nh]\nLN[pj:pd][nf:ff][ih:fj][kh:nj]\nC[Arrows, lines and dimmed points.])\n\n(;B[qd]N[Style & text type]\nC[There are hard linebreaks & soft linebreaks.\nSoft linebreaks are linebreaks preceeded by \'\\\\\' like this one >o\\\nk<. Hard line breaks are all other linebreaks.\nSoft linebreaks are converted to >nothing<, i.e. removed.\n\nNote that linebreaks are coded differently on different systems.\n\nExamples (>ok< shouldn\'t be split):\n\nlinebreak 1 \"\\\\n\": >o\\\nk<\nlinebreak 2 \"\\\\n\\\\r\": >o\\\n\rk<\nlinebreak 3 \"\\\\r\\\\n\": >o\\\r\nk<\nlinebreak 4 \"\\\\r\": >o\\\rk<]\n\n(;W[dd]N[W d16]C[Variation C is better.](;B[pp]N[B q4])\n(;B[dp]N[B d4])\n(;B[pq]N[B q3])\n(;B[oq]N[B p3])\n)\n(;W[dp]N[W d4])\n(;W[pp]N[W q4])\n(;W[cc]N[W c17])\n(;W[cq]N[W c3])\n(;W[qq]N[W r3])\n)\n\n(;B[qr]N[Time limits, captures & move numbers]\nBL[120.0]C[Black time left: 120 sec];W[rr]\nWL[300]C[White time left: 300 sec];B[rq]\nBL[105.6]OB[10]C[Black time left: 105.6 sec\nBlack stones left (in this byo-yomi period): 10];W[qq]\nWL[200]OW[2]C[White time left: 200 sec\nWhite stones left: 2];B[sr]\nBL[87.00]OB[9]C[Black time left: 87 sec\nBlack stones left: 9];W[qs]\nWL[13.20]OW[1]C[White time left: 13.2 sec\nWhite stones left: 1];B[rs]\nC[One white stone at s2 captured];W[ps];B[pr];W[or]\nMN[2]C[Set move number to 2];B[os]\nC[Two white stones captured\n(at q1 & r1)]\n;MN[112]W[pq]C[Set move number to 112];B[sq];W[rp];B[ps]\n;W[ns];B[ss];W[nr]\n;B[rr];W[sp];B[qs]C[Suicide move\n(all B stones get captured)])\n)\n\n(;FF[4]AP[Primiview:3.1]GM[1]SZ[19]C[Gametree 2: game-info\n\nGame-info properties are usually stored in the root node.\nIf games are merged into a single game-tree, they are stored in the node\\\n where the game first becomes distinguishable from all other games in\\\n the tree.]\n;B[pd]\n(;PW[W. Hite]WR[6d]RO[2]RE[W+3.5]\nPB[B. Lack]BR[5d]PC[London]EV[Go Congress]W[dp]\nC[Game-info:\nBlack: B. Lack, 5d\nWhite: W. Hite, 6d\nPlace: London\nEvent: Go Congress\nRound: 2\nResult: White wins by 3.5])\n(;PW[T. Suji]WR[7d]RO[1]RE[W+Resign]\nPB[B. Lack]BR[5d]PC[London]EV[Go Congress]W[cp]\nC[Game-info:\nBlack: B. Lack, 5d\nWhite: T. Suji, 7d\nPlace: London\nEvent: Go Congress\nRound: 1\nResult: White wins by resignation])\n(;W[ep];B[pp]\n(;PW[S. Abaki]WR[1d]RO[3]RE[B+63.5]\nPB[B. Lack]BR[5d]PC[London]EV[Go Congress]W[ed]\nC[Game-info:\nBlack: B. Lack, 5d\nWhite: S. Abaki, 1d\nPlace: London\nEvent: Go Congress\nRound: 3\nResult: Balck wins by 63.5])\n(;PW[A. Tari]WR[12k]KM[-59.5]RO[4]RE[B+R]\nPB[B. Lack]BR[5d]PC[London]EV[Go Congress]W[cd]\nC[Game-info:\nBlack: B. Lack, 5d\nWhite: A. Tari, 12k\nPlace: London\nEvent: Go Congress\nRound: 4\nKomi: -59.5 points\nResult: Black wins by resignation])\n))\n"
        
        let parser = SGFParser(sgfString)
        do {
            try parser.parse()
        } catch {
            print("Failed parsing sgfString: \(error)")
        }
    }

    static var allTests = [
        ("testSGFParseVariation", testSGFParseVariation),
        ("testSGFParseChampGoHD", testSGFParseChampGoHD),
        ("testSGFParseFF4EX", testSGFParseFF4EX),
    ]
}
