/***** �R���e�L�X�g���j���[���W���[�� *****/
;#module "contextMenuMod"
;MENUITEMINFO�\����
;fMask�̒l
#define global MIIM_STATE 0x00000001		;fState
#define global MIIM_ID 0x00000002			;wID
#define global MIIM_SUBMENU 0x00000004		;hSubMenu
#define global MIIM_CHECKMARKS 0x00000008	;hbmpChecked, hbmpUnchecked
#define global MIIM_DATA 0x00000020		;dwItemData
#define global MIIM_STRING 0x00000040		;dwTypeData
#define global MIIM_BITMAP 0x00000080		;hBmpItem
#define global MIIM_FTYPE 0x00000100		;fType
;fType
#define global MFT_STRING 0x00000000		;��������g�p���ĕ\������B
#define global MFT_MENUBARBREAK 0x00000010	;�V������ɔz�u����B�����������B�i���j���[�o�[�ȊO�̏ꍇ�j
#define global MFT_MENUBREAK 0x00000020	;�V������ɔz�u����B�i���j���[�o�[�ȊO�̏ꍇ�j
#define global MFT_RADIOCHECK 0x00000200	;hbmpChecked = NULL�̂Ƃ��A���W�I�{�^����\������B
#define global MFT_SEPARATOR 0x00000800	;�Z�p���[�^��\������B
#define global MFT_RIGHTORDER 0x00002000	;�E���獶�ɕ\������B
;fState
#define global MFS_ENABLED 0x00000000		;�ʏ�\��
#define global MFS_UNCHECKED 0x00000000	;�ʏ�\��
#define global MFS_UNHILITE 0x00000000		;�ʏ�\��
#define global MFS_GLAYED 0x00000003		;�D�F�\���E�I��s��
#define global MFS_DISABLED 0x00000003		;�D�F�\���E�I��s��
#define global MFS_CHECKED 0x00000008		;�`�F�b�N�}�[�N������
#define global MFS_HILITE 0x00000080		;�n�C���C�g����
#define global MFS_DEFAULT 0x00001000		;�f�t�H���g�A�C�e���ɂ���

;TrackPopupMenu - uFlags
#define global TPM_CENTERALIGN	0x00000004	;���S��x�ɍ��킹��
#define global TPM_LEFTALIGN	0x00000000	;���[
#define global TPM_RIGHTALIGN	0x00000008	;�E�[
#define global TPM_BOTTOMALIGN	0x00000020	;���[��y�ɍ��킹��
#define global TPM_TOPALIGN	0x00000000		;��[
#define global TPM_VCENTERALIGN	0x00000010	;���S
#define global TPM_NONOTIFY	0x00000080		;�I�����A���b�Z�[�W�ʒm���Ȃ�
#define global TPM_RETURNCMD	0x00000100	;�I�����ꂽ���ڂ̎��ʎq��ʒm
#define global TPM_LEFTBUTTON	0x00000000	;���N���b�N�ł̂ݑI���\
#define global TPM_RIGHTBUTTON	0x00000002	;�ǂ���̃{�^���N���b�N�ł��I���\
#define global TPM_HORNEGANIMATION	0x00000800	;������E�փA�j���[�V����	
#define global TPM_HORPOSANIMATION	0x00000400	;�E���獶�փA�j���[�V����
#define global TPM_NOANIMATION	0x00004000		;�A�j���[�V�����Ȃ�
#define global TPM_VERNEGANIMATION	0x00002000	;�������փA�j���[�V����
#define global TPM_VERPOSANIMATION	0x00001000	;�ォ�牺�փA�j���[�V����
#define global TPM_RECURSE	0x00000001		;�`�b�v�w���v�̕\����L���ɂ���
;�A�j���[�V�����\�����s���ɂ́ASystemParametersInfo��uiAction�p�����[�^�ɂāASPI_SETMENUANIMATION�t���O���w�肵�Ȃ���΂Ȃ�Ȃ��B
;Windows2000�ɂ����āASystemParametersInfo�Ńt�F�[�h�A�j���[�V������L���ɂ����ꍇ�ATPM_*ANIMATION��TPM_NOANIMETION���������������B

#cfunc global CreatePopupMenu "CreatePopupMenu"
;val = CreatePopupMenu()
;�Ԃ�l�F�쐬���ꂽ���j���[�̃n���h��

;#func AppendMenu "AppendMenuA" int, int, int, sptr
;AppendMenu(A) hMenu, uFlags, uIDItem, pItem
/*
hMenu = ���j���[�n���h��
uFlags = �I�v�V�����t���O
uIDItem = �A�C�e��ID�܂��̓T�u���j���[�n���h��
pItem = �\�����镶����
*/

#func global InsertMenuItem "InsertMenuItemA" int, int, int, int
;InsertMenuItem(A) hMenu, uItem, fByPosition, lpmii
/*
hMenu = ���j���[�n���h��
uItem = �}�����鍀�ڂ̒���̃��j���[���ʎq�܂��͈ʒu
fByPosition = uItem�p�����[�^�̈Ӗ�
lpmii = MENUITEMINFO�\���̂ւ̃|�C���^
*/
;uItem�́u����̍��ځv���w�肷��̂ŁA�t�Ɍ����΁A�V�������ڂ�uItem�̒��O�ɑ}�������B
;fByPosition��FALSE�ł���ꍇ�AuItem�͎��ʎq���Ӗ����ATRUE�ł���Έʒu���Ӗ�����B

#func global TrackPopupMenu "TrackPopupMenu" int, int, int, int, int, int
;TrackPopupMenu hMenu, uFlags, x, y, nReserved, hWnd(, prcRect)
/*
hMenu = ���j���[�n���h��
uFlags = �I�v�V����
x = �����ʒu
y = �����ʒu
nReserved = �\��ς݁B���0���w�肷��B
hWnd = ���L�E�B���h�E�̃n���h��
prcRect = ���������
*/
;uFlags�ɂ�TPM_RETURNCMD���w�肵���ꍇ�A�I�����ꂽ���j���[�̎��ʎq���Ԃ�B�������y�уG���[�̏ꍇ��0�B
;TPM_RETURNCMD���w�肳��Ă��Ȃ��ꍇ�A0�ȊO�̒l���Ԃ�B���s����0�B

#func global DestroyMenu "DestroyMenu" int
;DestroyMenu hMenu
/*
hMenu = ���j���[�n���h��
*/
;�E�B���h�E�Ɋ��蓖�Ă��Ă��Ȃ����j���[�́A�A�v���P�[�V�����I���O�ɕK���j�����Ȃ���΂Ȃ�Ȃ��B
;�E�B���h�E�Ɋ��蓖�Ă��Ă��郁�j���[�́A�����Ŕj�������B

;#global
