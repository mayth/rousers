/***** ���ʃ��W���[�� *****/
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
#define global WS_CHILD 0x40000000		;�q�E�B���h�E
#define global WS_VISIBLE 0x10000000	;���E�B���h�E
#define ICC_LISTVIEW_CLASSES 0x00000001	;���X�g�r���[�A�w�b�_�[�R���g���[���̃N���X
#define ICC_PROGRESS_CLASS 0x00000020	;�v���O���X�o�[�̃N���X
#define GCL_STYLE -26	;�E�B���h�E�N���X��ύX
#define CS_DBLCLKS	0x00000008

#define global EM_SETREADONLY 0x000000cf	;�������݋֎~������t�^����
;wParam = flag, lParam = 0
;flag = �t���O�i-1�ŋ֎~�A0�ŉ����j
;�߂�l�F0�ȊO�̒l�B���s����0�B

#define global ctype GetLowerWord(%1) %1 & 0xFFFF
#define global ctype GetUpperWord(%1) (%1 >> 16) & 0xFFFF

#uselib "comctl32.dll"
#func global InitCommonControlsEx "InitCommonControlsEx" var
;InitCommonControlsEx dwSize, dwICC
;dwSize = INITCOMMONCONTROLSEX�\���̂̃T�C�Y�i8�j
;dwICC = ���[�h����R�����R���g���[���N���X
;icc(0) = 8
;icc(1) = dwICC

#uselib "user32.dll"
#func global CreateWindowEx "CreateWindowExA" int, sptr, sptr, int, int, int, int, int, int, int, int, int
;CreateWindowEx(A) dwExStyle, pszClassName, pszWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, pParam
/*
dwExStyle = �E�B���h�E�g���X�^�C��
pszClassName = �E�B���h�E�N���X��
pszWindowName = �E�B���h�E��
dwStyle = �E�B���h�E�X�^�C��
x = x���W
y = y���W
nWidth = ��
nHeight = ����
hWndParent = �e�E�B���h�E�̃n���h��
hMenu = ���j���[�n���h���A�܂��͎q�E�B���h�EID
hInstance = �C���X�^���X�n���h��
pParam = �E�B���h�E�쐬�f�[�^
*/

#func global GetClassLong "GetClassLongA" int, int
;GetClassLong(A) hWnd, nIndex
/*
hWnd = �E�B���h�E�n���h��
nIndex = �擾����l�̃I�t�Z�b�g
*/

#func global SetClassLong "SetClassLongA" int, int, int
;SetClassLong(A) hWnd, nIndex, dwNewLong
/*
hWnd = �E�B���h�E�n���h��
nIndex = �ύX����f�[�^�̃I�t�Z�b�g
dwNewLong = �V�����l
*/

#func global ScreenToClient "ScreenToClient" int, int
;ScreenToClient hWnd, ppt
/*
hWnd = �E�B���h�E�n���h��
ppt = �ϊ������W�y�ѕϊ����ʂ��i�[����POINT�\����
*/

#func global ClientToScreen "ClientToScreen" int, int
;ScreenToClient hWnd, ppt
/*
hWnd = �E�B���h�E�n���h��
ppt = �ϊ������W�y�ѕϊ����ʂ��i�[����POINT�\����
*/

#cfunc global ChildWindowFromPoint "ChildWindowFromPoint" int, int
;val = ChildWindowFromPoint(hWndParent, Point)
/*
hWndParent = �e�E�B���h�E�̃n���h��
Point = ��������_�̃N���C�A���g���W����ꂽPOINT�\����
*/
;Point���e�E�B���h�E�̊O���ɂ����NULL���Ԃ�BPoint�Ɏq�E�B���h�E���Ȃ���ΐe�E�B���h�E�̃n���h�����Ԃ�B

#deffunc initComctl
;�R�����R���g���[��������������B
;initComctl (NoParameters)
;�R�����R���g���[�����g�p����O�ɌĂԁB�ŏ��̂P�x�����ĂׂΗǂ��B
	dim icc, 2
	icc(0) = 8, ICC_LISTVIEW_CLASSES	;INITCOMMONCONTROLEX�\����
	InitCommonControlsEx icc			;�R�����R���g���[��������

	return

#global
