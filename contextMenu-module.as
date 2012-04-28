/***** コンテキストメニューモジュール *****/
;#module "contextMenuMod"
;MENUITEMINFO構造体
;fMaskの値
#define global MIIM_STATE 0x00000001		;fState
#define global MIIM_ID 0x00000002			;wID
#define global MIIM_SUBMENU 0x00000004		;hSubMenu
#define global MIIM_CHECKMARKS 0x00000008	;hbmpChecked, hbmpUnchecked
#define global MIIM_DATA 0x00000020		;dwItemData
#define global MIIM_STRING 0x00000040		;dwTypeData
#define global MIIM_BITMAP 0x00000080		;hBmpItem
#define global MIIM_FTYPE 0x00000100		;fType
;fType
#define global MFT_STRING 0x00000000		;文字列を使用して表示する。
#define global MFT_MENUBARBREAK 0x00000010	;新しい列に配置する。線が引かれる。（メニューバー以外の場合）
#define global MFT_MENUBREAK 0x00000020	;新しい列に配置する。（メニューバー以外の場合）
#define global MFT_RADIOCHECK 0x00000200	;hbmpChecked = NULLのとき、ラジオボタンを表示する。
#define global MFT_SEPARATOR 0x00000800	;セパレータを表示する。
#define global MFT_RIGHTORDER 0x00002000	;右から左に表示する。
;fState
#define global MFS_ENABLED 0x00000000		;通常表示
#define global MFS_UNCHECKED 0x00000000	;通常表示
#define global MFS_UNHILITE 0x00000000		;通常表示
#define global MFS_GLAYED 0x00000003		;灰色表示・選択不可
#define global MFS_DISABLED 0x00000003		;灰色表示・選択不可
#define global MFS_CHECKED 0x00000008		;チェックマークをつける
#define global MFS_HILITE 0x00000080		;ハイライトする
#define global MFS_DEFAULT 0x00001000		;デフォルトアイテムにする

;TrackPopupMenu - uFlags
#define global TPM_CENTERALIGN	0x00000004	;中心をxに合わせる
#define global TPM_LEFTALIGN	0x00000000	;左端
#define global TPM_RIGHTALIGN	0x00000008	;右端
#define global TPM_BOTTOMALIGN	0x00000020	;下端をyに合わせる
#define global TPM_TOPALIGN	0x00000000		;上端
#define global TPM_VCENTERALIGN	0x00000010	;中心
#define global TPM_NONOTIFY	0x00000080		;選択時、メッセージ通知しない
#define global TPM_RETURNCMD	0x00000100	;選択された項目の識別子を通知
#define global TPM_LEFTBUTTON	0x00000000	;左クリックでのみ選択可能
#define global TPM_RIGHTBUTTON	0x00000002	;どちらのボタンクリックでも選択可能
#define global TPM_HORNEGANIMATION	0x00000800	;左から右へアニメーション	
#define global TPM_HORPOSANIMATION	0x00000400	;右から左へアニメーション
#define global TPM_NOANIMATION	0x00004000		;アニメーションなし
#define global TPM_VERNEGANIMATION	0x00002000	;下から上へアニメーション
#define global TPM_VERPOSANIMATION	0x00001000	;上から下へアニメーション
#define global TPM_RECURSE	0x00000001		;チップヘルプの表示を有効にする
;アニメーション表示を行うには、SystemParametersInfoのuiActionパラメータにて、SPI_SETMENUANIMATIONフラグを指定しなければならない。
;Windows2000において、SystemParametersInfoでフェードアニメーションを有効にした場合、TPM_*ANIMATIONはTPM_NOANIMETIONを除き無視される。

#cfunc global CreatePopupMenu "CreatePopupMenu"
;val = CreatePopupMenu()
;返り値：作成されたメニューのハンドル

;#func AppendMenu "AppendMenuA" int, int, int, sptr
;AppendMenu(A) hMenu, uFlags, uIDItem, pItem
/*
hMenu = メニューハンドル
uFlags = オプションフラグ
uIDItem = アイテムIDまたはサブメニューハンドル
pItem = 表示する文字列
*/

#func global InsertMenuItem "InsertMenuItemA" int, int, int, int
;InsertMenuItem(A) hMenu, uItem, fByPosition, lpmii
/*
hMenu = メニューハンドル
uItem = 挿入する項目の直後のメニュー識別子または位置
fByPosition = uItemパラメータの意味
lpmii = MENUITEMINFO構造体へのポインタ
*/
;uItemは「直後の項目」を指定するので、逆に言えば、新しい項目はuItemの直前に挿入される。
;fByPositionがFALSEである場合、uItemは識別子を意味し、TRUEであれば位置を意味する。

#func global TrackPopupMenu "TrackPopupMenu" int, int, int, int, int, int
;TrackPopupMenu hMenu, uFlags, x, y, nReserved, hWnd(, prcRect)
/*
hMenu = メニューハンドル
uFlags = オプション
x = 水平位置
y = 垂直位置
nReserved = 予約済み。常に0を指定する。
hWnd = 所有ウィンドウのハンドル
prcRect = 無視される
*/
;uFlagsにてTPM_RETURNCMDを指定した場合、選択されたメニューの識別子が返る。取り消し及びエラーの場合は0。
;TPM_RETURNCMDが指定されていない場合、0以外の値が返る。失敗時は0。

#func global DestroyMenu "DestroyMenu" int
;DestroyMenu hMenu
/*
hMenu = メニューハンドル
*/
;ウィンドウに割り当てられていないメニューは、アプリケーション終了前に必ず破棄しなければならない。
;ウィンドウに割り当てられているメニューは、自動で破棄される。

;#global
