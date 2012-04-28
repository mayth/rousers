/***** EXE作成オプション *****/
#packopt name "rousers"
#packopt runtime "hsp3c.hrt"
#packopt hide 1

/***** ヘッダファイル *****/
#include "general.as"	;共通モジュール
#include "listview-module.as"		;リストビューモジュール
#include "progressbar-module.as"	;プログレスバーモジュール
#include "contextMenu-module.as"	;コンテキストメニューモジュール

/***** 定義 *****/
#enum MainWindow = 0
#enum CardInfoWindow
#enum DeckWindow
#enum FilteringSettingWindow
#enum SearchSettingWindow
#enum ProgressWindow

;コンテキストメニューのID
#define AddToDeck 0x0100
#define SearchBy 0x0101
