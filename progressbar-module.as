/***** プログレスバーモジュール *****/
#module "progressMod"
#define PBM_SETPOS 0x00000402		;位置指定
;wParam = nNewPos, lParam = 0
;nNewPos = 新しい位置
;戻り値：以前の位置

#define PBM_SETSTEP 0x00000404		;増加量設定
;wParam = nStepInc, lParam = 0
;nStepInc = 新しい増加量(default = 10)
;戻り値：以前の増加量

#define PBM_STEPIT 0x00000405		;プログレスバー増加
;wParam = 0, lParam = 0
;戻り値：以前の位置

#define PBM_SETRANGE32 0x00000406	;プログレスバー範囲設定
;wParam = iLowLim, lParam = iHigLim
;iLowLim = 下限値(default = 0)
;iHigLim = 上限値(default = 100)
;戻り値：以前の範囲のDWORD値？

#deffunc createProgressBar int xPos, int yPos, int barWidth, int barHeight
;プログレスバーを作成する。
;createProgressBar p1, p2, p3, p4
;p1 = xPos……x位置
;p2 = yPos……y位置
;p3 = barWidth……バーの幅
;p4 = barHeight……バーの高さ
	CreateWindowEx 0, "msctls_progress32", "", WS_CHILD|WS_VISIBLE, xPos, yPos, barWidth, barHeight, hWnd, 0xff01, hInstance, 0

	return stat

#deffunc setProgressRange int hProgress, int min, int max
;プログレスバーの範囲を設定する。
;setProgressRange p1, p2, p3
;p1 = hProgress……対象のプログレスバーのハンドル
;p2 = min……下限値
;p3 = max……上限値
	sendmsg hProgress, PBM_SETRANGE32, min, max

	return


#deffunc setProgressStep int hProgress, int step
;プログレスバーの増加量（ステップ）を設定する。
;setProgressStep p1, p2
;p1 = hProgress……対象のプログレスバーのハンドル
;p2 = step……新しいステップ
	sendmsg hProgress, PBM_SETSTEP, step

	return

#deffunc setProgressPosition int hProgress, int position
;プログレスバーの位置を設定する。
;setProgressPosition p1, p2
;p1 = hProgress……対象のプログレスバーのハンドル
;p2 = position……新しい位置
	sendmsg hProgress, PBM_SETPOS, position

	return


#deffunc increaseProgress int hProgress
;プログレスバーを増加量（ステップ）だけ増加させる。
;increaseProgress p1
;p1 = hProgress……対象のプログレスバーのハンドル
	sendmsg hProgress, PBM_STEPIT

	return

#global
