/***** リストビューモジュール *****/
#module "listviewMod"

#define LVM_INSERTCOLUMN 0x101b	;新しい列（カラム）を挿入するメッセージ
;wParam = iCol, lParam = pcol
;iCol = カラムの挿入位置のインデックス, pcol = LVCOLUMN構造体のアドレス
;戻り値：新しいカラムの実際のインデックス。失敗時は-1。
#define LVM_INSERTITEM 0x1007	;新しいアイテムを挿入するメッセージ
;wParam = 0, lParam = pitem
;pitem = LVITEM構造体のアドレス
;戻り値：新しいアイテムの実際のインデックス。失敗時は-1。
#define LVM_GETITEM 0x1005	;アイテム及びサブアイテムの属性を取得するメッセージ
;wParam = 0, lParam = pitem
;pitem = LVITEM構造体のアドレス
;戻り値：0以外の値。失敗時は0。
#define LVM_SETITEM 0x1006	;アイテム及びサブアイテムの属性を設定及び変更するメッセージ
;wParam = 0, lParam = pitem
;pitem = LVITEM構造体のアドレス
;戻り値：0以外の値。失敗時は0。
#define LVM_DELETEITEM 0x1008	;アイテムを削除するメッセージ
;wParam = iItem, lParam = 0
;iItem = 削除するアイテムのインデックス
;戻り値：0以外の値。失敗時は0。
#define LVM_GETNEXTITEM 0x100c
;wParam = iStart, lParam = flags
;iStart = 検索開始インデックス（-1で先頭から）
;flags = 検索する方向と検索するアイテムの状態を指定するフラグ
;戻り値：該当アイテムのインデックス。無かった場合は-1。
#define LVM_FINDITEM 0x100d
;wParam = iStart, lParam = plvfi
;iStart = 検索開始インデックス（-1で先頭から）
;plvfi = LVFINDINFO構造体のアドレス
;戻り値：該当アイテムのインデックス。無かった場合は-1。
#define LVM_ENSUREVISIBLE 0x1013
;wParam = i, lParam = fPartialOK
;i = 表示させる行のインデックス
;fPartialOK = 完全に表示させる必要があるか。
;戻り値：0以外の値。失敗時は0。
#define LVM_HITTEST	0x1012
;wParam = 0, lParam = pinfo
;pinfo = LVHITTESTINFO構造体へのポインタ
;戻り値：指定位置のアイテムのインデックス。無ければ-1。

#define LVM_SETEXTENDEDLISTVIEWSTYLE 0x1036
;wParam = dwExMask, lParam = dwExStyle
;dwExMask = 変更する拡張スタイルの指定
;dwExStyle = 拡張スタイル
;戻り値：変更前の拡張スタイル

;リストビュー固有のスタイル
#define global LVS_REPORT 0x0001			;「詳細表示」を行う
#define global LVS_SINGLESEL 0x0004		;一度に１つのアイテムしか選択出来ない様にする。
#define global LVS_SHOWSELALWAYS 0x0008	;コントロールがフォーカスを持っていなくても選択状態を表示する
#define global LVS_SORTASCENDING 0x0010	;テキストを元に昇順ソートする
#define global LVS_SORTDESCENDING 0x0020	;テキストを元に降順ソートする
#define global LVS_NOSORTHEADER 0x8000	;カラムのヘッダをボタンの様に動作させない
;リストビュー固有の拡張スタイル
#define global LVS_EX_GRIDLINES 0x00000001		;罫線を表示する（詳細表示のみ）
#define global LVS_EX_CHECKBOXES 0x00000004	;チェックボックスを表示する
#define global LVS_EX_HEADERDRAGDROP 0x00000010;カラムをドラッグアンドドロップで入れ替える（詳細表示のみ）
#define global LVS_EX_FULLROWSELECT 0x00000020	;アイテム選択時に行全体を強調表示する
#define global LVS_EX_ONECLICKACTIVATE 0x00000040	;シングルクリック時にLVN_ITEMACTIVATEを送る。また、カーソルがアイテムの上に来たときに強調表示する
#define global LVS_EX_TWOCLICKACTIVATE 0x00000080	;ダブルクリック時
#define global LVS_EX_FLATSB 0x00000100		;フラットスクロールバーを使用する
#define global LVS_EX_UNDERLINEHOT	0x00000800	;カーソルが上に来たときに下線を引く（LVS_EX_ONE(TWO)CLICKACTIVATE有効時）
;LVCOLUMN構造体
#define LVCF_FMT 0x0001			;有効なメンバを指定するマスク（表示位置）
#define LVCF_WIDTH 0x0002		;幅
#define LVCF_TEXT 0x0004		;ヘッダのテキスト
#define LVCF_SUBITEM 0x0008		;サブアイテムのインデックス
#define LVCFMT_LEFT 0x0000		;カラムの文字の表示位置（左）
#define LVCFMT_RIGHT 0x0001		;右
#define LVCFMT_CENTER 0x0002	;中央
;LVITEM構造体
#define LVIF_TEXT 0x0001		;有効なメンバを指定するマスク（pszText）
#define LVIF_STATE 0x0008		;同上（state）
#define LVIS_FOCUSED 0x0001		;アイテムはフォーカスを持つ。（点線で囲まれる）
#define LVIS_SELECTED 0x0002	;アイテムは選択状態になる。（Windowsの設定がデフォルトのままなら青で表示）
;LVFINDINFO構造体
#define LVFI_STRING 0x0002		;完全一致検索
#define LVFI_PARTIAL 0x0008		;前方一致検索
#define LVFI_NEARESTXY 0x0040	;ptメンバで指定された位置からvkDirectionの方向に最も近いアイテムを検索
;GETNEXTIEMのlParam(flags)の定数
#define LVNI_ALL 0x0000			;指定されたアイテム（wParam）以降を検索する。
#define LVNI_FOCUSED 0x0001		;フォーカスのあるアイテムを検索する。
#define LVNI_SELECTED 0x0002	;選択されているアイテムを検索する。
;LVHITTESTINFO構造体のflagsメンバ
#define LVHT_ONITEM 0x000E		;アイテム上にある
;LVFINDINFO構造体のvkDirectionメンバで指定される仮想キーコード
#define global VK_PRIOR 0x21	;PageUp
#define global VK_NEXT 0x22		;PageDown
#define global VK_END 0x23		;End
#define global VK_HOME 0x24		;Home
#define global VK_LEFT 0x25		;←
#define global VK_UP 0x26		;↑
#define global VK_RIGHT 0x27	;→
#define global VK_DOWN 0x28		;↓

#deffunc createListview int listWidth, int listHeight, int styles, int exStyles, local objid
;winobjを使用してリストビューを作成する。
;createListView p1, p2, p3, p4(, p5)
;p1 = listWidth……リストビューの幅
;p2 = listHeight……リストビューの高さ
;p3 = styles……スタイル
;p4 = exStyles……拡張スタイル
;(p5) = objid……オブジェクトID
;返り値：作成したリストビューのオブジェクトID

	winobj "SysListView32", "", 0, styles, listWidth, listHeight, 0xff01, 0
	objid = stat

	sendmsg objinfo(objid, 2), LVM_SETEXTENDEDLISTVIEWSTYLE, exStyles, exStyles

	return objid
/*
#deffunc createListviewByAPI int xPos, int yPos, int listWidth, int listHeight, int styles, int exStyles, local lHnd
;CreateWindowExを呼び出してリストビューを作成する。
;createListView p1, p2, p3, p4(, p5)
;p1 = xPos……x位置
;p2 = yPos……y位置
;p3 = listWidth……リストビューの幅
;p4 = listHeight……リストビューの高さ
;p5 = lHnd……ハンドル
;返り値：作成したリストビューのハンドル

;	CreateWindowEx 0, "SysListView32", "", WS_CHILD|WS_VISIBLE|LVS_REPORT|LVS_SINGLESEL|LVS_SHOWSELALWAYS|LVS_NOSORTHEADER, xPos, yPos, listWidth, listHeight, hWnd, 0xFF01, hInstance, 0
	CreateWindowEx 0, "SysListView32", "", styles, xPos, yPos, listWidth, listHeight, hWnd, 0xFF01, hInstance, 0
	lHnd = stat

	sendmsg lHnd, LVM_SETEXTENDEDLISTVIEWSTYLE, exStyles, exStyles

	return lHnd
*/
#deffunc addListColumn str header, int hList, int align, int columnWidth, int index, local headerTemp
;リストビューにカラム（列）を追加する。
;addListColumn "string", p1, p2, p3, p4(, p5)
;"string" = header……ヘッダー文字列
;p1 = hList……対象のリストビューのハンドル
;p2 = align……カラム内の文字配置（0=左 1=右 2=中央）
;p3 = columnWidth……カラムの幅
;p4 = index……カラムのインデックス
;p5 = headerTemp……ポインタを渡すための一時変数
;返り値：なし

	dim lvcolumn, 8

	headerTemp = header

	lvcolumn(0) = LVCF_FMT|LVCF_WIDTH|LVCF_TEXT|LVCF_SUBITEM
	lvcolumn(1) = align
	lvcolumn(2) = columnWidth
	lvcolumn(3) = varptr(headerTemp)
	lvcolumn(4) = 0
	lvcolumn(5) = index
	lvcolumn(6) = NULL, NULL

	sendmsg hList, LVM_INSERTCOLUMN, index, varptr(lvcolumn)

	return

#deffunc addListItem str text, int hList, int index, local textTemp
;リストビューにアイテムを追加する。
;addListItem "string", p1, p2(, p3)
;"string" = text……アイテム文字列
;p1 = hList……対象のリストビューのハンドル
;p2 = index……アイテムのインデックス
;p3 = textTemp……ポインタを渡すための一時変数
;返り値：なし

	dim lvitem, 13

	textTemp = text

	lvitem(0) = LVIF_TEXT
	lvitem(1) = index
	lvitem(2) = 0
	lvitem(5) = varptr(textTemp)

	sendmsg hList, LVM_INSERTITEM, 0, varptr(lvitem)

	return


#deffunc setListItem str text, int hList, int index, int subIndex, local textTemp
;アイテム・サブアイテムの設定、及び属性の変更を行う。
;setListItem "string", p1, p2, p3(, p4)
;"string" = text……（サブ）アイテム文字列
;p1 = hList……対象のリストビューのハンドル
;p2 = index……インデックス
;p3 = subIndex……サブアイテムのインデックス
;p4 = textTemp……ポインタを渡すための一時変数
;返り値：なし

	dim lvitem, 13

	textTemp = text

	lvitem(0) = LVIF_TEXT
	lvitem(1) = index
	lvitem(2) = subIndex
	lvitem(5) = varptr(textTemp)

	sendmsg hList, LVM_SETITEM, 0, varptr(lvitem)

	return


#deffunc getListItem var resultBuf, int hList, int index, int subIndex, int bufsize
;指定されたアイテムの情報を取得する。
;getListItem v1, p1, p2, p3, p4
;v1 = resultBuf……取得した情報を格納するバッファ
;p1 = hList……対象のリストビューのハンドル
;p2 = index……取得するアイテムのインデックス
;p3 = subIndex……取得する文字列のカラムのインデックス
;p4 = bufsize……resultBufのサイズ
;返り値：0以外。失敗時は0。
	dim lvitem, 13

	lvitem(0) = LVIF_TEXT
	lvitem(1) = index
	lvitem(2) = subIndex
	lvitem(5) = varptr(resultBuf)
	lvitem(6) = bufsize

	sendmsg hList, LVM_GETITEM, 0, varptr(lvitem)

	return stat

#deffunc findSelectedItem int hList, int index
;選択されたアイテムを検索する。
;findSelectedItem p1, p2
;p1 = hList……対象のリストビューのハンドル
;p2 = index……検索開始インデックス
;返り値：該当アイテムのインデックス（無い場合は-1）
	sendmsg hList, LVM_GETNEXTITEM, index, LVNI_ALL|LVNI_SELECTED

	return stat


#deffunc findItem str string, int hList, int index, int matchingMode, local stringTemp
;指定された文字列を含むアイテムを検索する。
;findItem "string", p1, p2, p3(, p4)
;"string" = string……検索する文字列
;p1 = hList……対象のリストビューのハンドル
;p2 = index……検索開始インデックス（-1で最初から）
;p3 = matchingMode……マッチングモード（0=完全一致 1=前方一致）
;p4 = stringTemp……ポインタを渡すための一時変数
;返り値：該当アイテムのインデックス（無い場合は-1）
	dim lvfindinfo, 6

	stringTemp = string
	if matchingMode {
		lvfindinfo(0) = LVFI_PARTIAL
	} else {
		lvfindinfo(0) = LVFI_STRING
	}
	lvfindinfo(1) = varptr(stringTemp)

	sendmsg hList, LVM_FINDITEM, index, varptr(lvfindinfo)

	return stat


#deffunc deleteItem int hList, int index
;指定されたアイテムを削除する。
;deleteItem p1, p2
;p1 = hList……対象のリストビューのハンドル
;p2 = index……削除するアイテムのインデックス
;返り値：0以外の値。失敗時は0。
	sendmsg hList, LVM_DELETEITEM, index

	return stat


#deffunc selectItem int hList, int index
;指定されたアイテムを選択状態にする。
;selectItem p1, p2
;p1 = hList……対象のリストビューのハンドル
;p2 = index……選択するアイテムのインデックス
;返り値：0以外の値。失敗時は0。
	dim lvitem, 13

	lvitem(0) = LVIF_STATE
	lvitem(1) = index
	lvitem(2) = 0
	itemstate = LVIS_SELECTED : iOverlay = 0 : iState = 0
	lvitem(3) = itemstate | ( iOverlay << 8 ) | ( iState << 12 )
	lvitem(4) = LVIS_SELECTED

	sendmsg hList, LVM_SETITEM, 0, varptr(lvitem)

	return stat


#deffunc EnsureVisible int hList, int index, int partialFlag
;指定されたアイテムを表示できる位置までスクロールする。
;EnsureVisible p1, p2, p3
;p1 = hList……対象のリストビューのハンドル
;p2 = index……表示するアイテムのインデックス
;p3 = partialFlag……部分的な表示を許可しない（0で許可する）
;返り値：０以外の値。失敗時は0。
	fPartialOK = limit(partialFlag, 0, 1)
	sendmsg hList, LVM_ENSUREVISIBLE, index, partialFlag

	return stat

#defcfunc HitTest int hList, int xPos, int yPos
;指定された座標にあるアイテムのインデックスを返す。
;val = HitTest(p1, p2, p3)
;p1 = hList……対象のリストビューのハンドル
;p2 = xPos……テストする座標x（クライアント座標系）
;p3 = yPos……同上y
;返り値：テストした座標にあるアイテムのインデックス。無ければ-1。
	dim pt, 2
	pt = xPos, yPos
	dim hti, 4
	hti(0) = varptr(pt)
	sendmsg hList, LVM_HITTEST, 0, varptr(hti)
	if ( stat == -1 ) {
		logmes "@listmod: HitTest was failed."
		return -1
	}
	if ( hti(1) == LVHT_ONITEM ) {
		return stat
	}
	return -1

#global
