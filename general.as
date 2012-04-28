/***** 共通モジュール *****/
#module "generalMod"

#define global NULL 0
#define global TRUE 1
#define global FALSE 0
#define global WM_NOTIFY 0x004E
#define global WM_CONTEXTMENU 0x007B
#define global WM_LBUTTONDOWN 0x0201
#define global WM_LBUTTONUP 0x0202
#define global MK_LBUTTON 0x0001
#define global NM_DBLCLK -3
#define global WS_CHILD 0x40000000		;子ウィンドウ
#define global WS_VISIBLE 0x10000000	;可視ウィンドウ
#define ICC_LISTVIEW_CLASSES 0x00000001	;リストビュー、ヘッダーコントロールのクラス
#define ICC_PROGRESS_CLASS 0x00000020	;プログレスバーのクラス
#define GCL_STYLE -26	;ウィンドウクラスを変更
#define CS_DBLCLKS	0x00000008

#define global EM_SETREADONLY 0x000000cf	;書き込み禁止属性を付与する
;wParam = flag, lParam = 0
;flag = フラグ（-1で禁止、0で解除）
;戻り値：0以外の値。失敗時は0。

#define global ctype GetLowerWord(%1) %1 & 0xFFFF
#define global ctype GetUpperWord(%1) (%1 >> 16) & 0xFFFF

#uselib "comctl32.dll"
#func global InitCommonControlsEx "InitCommonControlsEx" var
;InitCommonControlsEx dwSize, dwICC
;dwSize = INITCOMMONCONTROLSEX構造体のサイズ（8）
;dwICC = ロードするコモンコントロールクラス
;icc(0) = 8
;icc(1) = dwICC

#uselib "user32.dll"
#func global CreateWindowEx "CreateWindowExA" int, sptr, sptr, int, int, int, int, int, int, int, int, int
;CreateWindowEx(A) dwExStyle, pszClassName, pszWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, pParam
/*
dwExStyle = ウィンドウ拡張スタイル
pszClassName = ウィンドウクラス名
pszWindowName = ウィンドウ名
dwStyle = ウィンドウスタイル
x = x座標
y = y座標
nWidth = 幅
nHeight = 高さ
hWndParent = 親ウィンドウのハンドル
hMenu = メニューハンドル、または子ウィンドウID
hInstance = インスタンスハンドル
pParam = ウィンドウ作成データ
*/

#func global GetClassLong "GetClassLongA" int, int
;GetClassLong(A) hWnd, nIndex
/*
hWnd = ウィンドウハンドル
nIndex = 取得する値のオフセット
*/

#func global SetClassLong "SetClassLongA" int, int, int
;SetClassLong(A) hWnd, nIndex, dwNewLong
/*
hWnd = ウィンドウハンドル
nIndex = 変更するデータのオフセット
dwNewLong = 新しい値
*/

#func global ScreenToClient "ScreenToClient" int, int
;ScreenToClient hWnd, ppt
/*
hWnd = ウィンドウハンドル
ppt = 変換元座標及び変換結果を格納するPOINT構造体
*/

#func global ClientToScreen "ClientToScreen" int, int
;ScreenToClient hWnd, ppt
/*
hWnd = ウィンドウハンドル
ppt = 変換元座標及び変換結果を格納するPOINT構造体
*/

#cfunc global ChildWindowFromPoint "ChildWindowFromPoint" int, int
;val = ChildWindowFromPoint(hWndParent, Point)
/*
hWndParent = 親ウィンドウのハンドル
Point = 調査する点のクライアント座標を入れたPOINT構造体
*/
;Pointが親ウィンドウの外側にあればNULLが返る。Pointに子ウィンドウがなければ親ウィンドウのハンドルが返る。

#deffunc initComctl
;コモンコントロールを初期化する。
;initComctl (NoParameters)
;コモンコントロールを使用する前に呼ぶ。最初の１度だけ呼べば良い。
	dim icc, 2
	icc(0) = 8, ICC_LISTVIEW_CLASSES	;INITCOMMONCONTROLEX構造体
	InitCommonControlsEx icc			;コモンコントロール初期化

	return

#global
