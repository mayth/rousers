/***** ���X�g�r���[���W���[�� *****/
#module "listviewMod"

#define LVM_INSERTCOLUMN 0x101b	;�V������i�J�����j��}�����郁�b�Z�[�W
;wParam = iCol, lParam = pcol
;iCol = �J�����̑}���ʒu�̃C���f�b�N�X, pcol = LVCOLUMN�\���̂̃A�h���X
;�߂�l�F�V�����J�����̎��ۂ̃C���f�b�N�X�B���s����-1�B
#define LVM_INSERTITEM 0x1007	;�V�����A�C�e����}�����郁�b�Z�[�W
;wParam = 0, lParam = pitem
;pitem = LVITEM�\���̂̃A�h���X
;�߂�l�F�V�����A�C�e���̎��ۂ̃C���f�b�N�X�B���s����-1�B
#define LVM_GETITEM 0x1005	;�A�C�e���y�уT�u�A�C�e���̑������擾���郁�b�Z�[�W
;wParam = 0, lParam = pitem
;pitem = LVITEM�\���̂̃A�h���X
;�߂�l�F0�ȊO�̒l�B���s����0�B
#define LVM_SETITEM 0x1006	;�A�C�e���y�уT�u�A�C�e���̑�����ݒ�y�ѕύX���郁�b�Z�[�W
;wParam = 0, lParam = pitem
;pitem = LVITEM�\���̂̃A�h���X
;�߂�l�F0�ȊO�̒l�B���s����0�B
#define LVM_DELETEITEM 0x1008	;�A�C�e�����폜���郁�b�Z�[�W
;wParam = iItem, lParam = 0
;iItem = �폜����A�C�e���̃C���f�b�N�X
;�߂�l�F0�ȊO�̒l�B���s����0�B
#define LVM_GETNEXTITEM 0x100c
;wParam = iStart, lParam = flags
;iStart = �����J�n�C���f�b�N�X�i-1�Ő擪����j
;flags = ������������ƌ�������A�C�e���̏�Ԃ��w�肷��t���O
;�߂�l�F�Y���A�C�e���̃C���f�b�N�X�B���������ꍇ��-1�B
#define LVM_FINDITEM 0x100d
;wParam = iStart, lParam = plvfi
;iStart = �����J�n�C���f�b�N�X�i-1�Ő擪����j
;plvfi = LVFINDINFO�\���̂̃A�h���X
;�߂�l�F�Y���A�C�e���̃C���f�b�N�X�B���������ꍇ��-1�B
#define LVM_ENSUREVISIBLE 0x1013
;wParam = i, lParam = fPartialOK
;i = �\��������s�̃C���f�b�N�X
;fPartialOK = ���S�ɕ\��������K�v�����邩�B
;�߂�l�F0�ȊO�̒l�B���s����0�B
#define LVM_HITTEST	0x1012
;wParam = 0, lParam = pinfo
;pinfo = LVHITTESTINFO�\���̂ւ̃|�C���^
;�߂�l�F�w��ʒu�̃A�C�e���̃C���f�b�N�X�B�������-1�B

#define LVM_SETEXTENDEDLISTVIEWSTYLE 0x1036
;wParam = dwExMask, lParam = dwExStyle
;dwExMask = �ύX����g���X�^�C���̎w��
;dwExStyle = �g���X�^�C��
;�߂�l�F�ύX�O�̊g���X�^�C��

;���X�g�r���[�ŗL�̃X�^�C��
#define global LVS_REPORT 0x0001			;�u�ڍו\���v���s��
#define global LVS_SINGLESEL 0x0004		;��x�ɂP�̃A�C�e�������I���o���Ȃ��l�ɂ���B
#define global LVS_SHOWSELALWAYS 0x0008	;�R���g���[�����t�H�[�J�X�������Ă��Ȃ��Ă��I����Ԃ�\������
#define global LVS_SORTASCENDING 0x0010	;�e�L�X�g�����ɏ����\�[�g����
#define global LVS_SORTDESCENDING 0x0020	;�e�L�X�g�����ɍ~���\�[�g����
#define global LVS_NOSORTHEADER 0x8000	;�J�����̃w�b�_���{�^���̗l�ɓ��삳���Ȃ�
;���X�g�r���[�ŗL�̊g���X�^�C��
#define global LVS_EX_GRIDLINES 0x00000001		;�r����\������i�ڍו\���̂݁j
#define global LVS_EX_CHECKBOXES 0x00000004	;�`�F�b�N�{�b�N�X��\������
#define global LVS_EX_HEADERDRAGDROP 0x00000010;�J�������h���b�O�A���h�h���b�v�œ���ւ���i�ڍו\���̂݁j
#define global LVS_EX_FULLROWSELECT 0x00000020	;�A�C�e���I�����ɍs�S�̂������\������
#define global LVS_EX_ONECLICKACTIVATE 0x00000040	;�V���O���N���b�N����LVN_ITEMACTIVATE�𑗂�B�܂��A�J�[�\�����A�C�e���̏�ɗ����Ƃ��ɋ����\������
#define global LVS_EX_TWOCLICKACTIVATE 0x00000080	;�_�u���N���b�N��
#define global LVS_EX_FLATSB 0x00000100		;�t���b�g�X�N���[���o�[���g�p����
#define global LVS_EX_UNDERLINEHOT	0x00000800	;�J�[�\������ɗ����Ƃ��ɉ����������iLVS_EX_ONE(TWO)CLICKACTIVATE�L�����j
;LVCOLUMN�\����
#define LVCF_FMT 0x0001			;�L���ȃ����o���w�肷��}�X�N�i�\���ʒu�j
#define LVCF_WIDTH 0x0002		;��
#define LVCF_TEXT 0x0004		;�w�b�_�̃e�L�X�g
#define LVCF_SUBITEM 0x0008		;�T�u�A�C�e���̃C���f�b�N�X
#define LVCFMT_LEFT 0x0000		;�J�����̕����̕\���ʒu�i���j
#define LVCFMT_RIGHT 0x0001		;�E
#define LVCFMT_CENTER 0x0002	;����
;LVITEM�\����
#define LVIF_TEXT 0x0001		;�L���ȃ����o���w�肷��}�X�N�ipszText�j
#define LVIF_STATE 0x0008		;����istate�j
#define LVIS_FOCUSED 0x0001		;�A�C�e���̓t�H�[�J�X�����B�i�_���ň͂܂��j
#define LVIS_SELECTED 0x0002	;�A�C�e���͑I����ԂɂȂ�B�iWindows�̐ݒ肪�f�t�H���g�̂܂܂Ȃ�ŕ\���j
;LVFINDINFO�\����
#define LVFI_STRING 0x0002		;���S��v����
#define LVFI_PARTIAL 0x0008		;�O����v����
#define LVFI_NEARESTXY 0x0040	;pt�����o�Ŏw�肳�ꂽ�ʒu����vkDirection�̕����ɍł��߂��A�C�e��������
;GETNEXTIEM��lParam(flags)�̒萔
#define LVNI_ALL 0x0000			;�w�肳�ꂽ�A�C�e���iwParam�j�ȍ~����������B
#define LVNI_FOCUSED 0x0001		;�t�H�[�J�X�̂���A�C�e������������B
#define LVNI_SELECTED 0x0002	;�I������Ă���A�C�e������������B
;LVHITTESTINFO�\���̂�flags�����o
#define LVHT_ONITEM 0x000E		;�A�C�e����ɂ���
;LVFINDINFO�\���̂�vkDirection�����o�Ŏw�肳��鉼�z�L�[�R�[�h
#define global VK_PRIOR 0x21	;PageUp
#define global VK_NEXT 0x22		;PageDown
#define global VK_END 0x23		;End
#define global VK_HOME 0x24		;Home
#define global VK_LEFT 0x25		;��
#define global VK_UP 0x26		;��
#define global VK_RIGHT 0x27	;��
#define global VK_DOWN 0x28		;��

#deffunc createListview int listWidth, int listHeight, int styles, int exStyles, local objid
;winobj���g�p���ă��X�g�r���[���쐬����B
;createListView p1, p2, p3, p4(, p5)
;p1 = listWidth�c�c���X�g�r���[�̕�
;p2 = listHeight�c�c���X�g�r���[�̍���
;p3 = styles�c�c�X�^�C��
;p4 = exStyles�c�c�g���X�^�C��
;(p5) = objid�c�c�I�u�W�F�N�gID
;�Ԃ�l�F�쐬�������X�g�r���[�̃I�u�W�F�N�gID

	winobj "SysListView32", "", 0, styles, listWidth, listHeight, 0xff01, 0
	objid = stat

	sendmsg objinfo(objid, 2), LVM_SETEXTENDEDLISTVIEWSTYLE, exStyles, exStyles

	return objid
/*
#deffunc createListviewByAPI int xPos, int yPos, int listWidth, int listHeight, int styles, int exStyles, local lHnd
;CreateWindowEx���Ăяo���ă��X�g�r���[���쐬����B
;createListView p1, p2, p3, p4(, p5)
;p1 = xPos�c�cx�ʒu
;p2 = yPos�c�cy�ʒu
;p3 = listWidth�c�c���X�g�r���[�̕�
;p4 = listHeight�c�c���X�g�r���[�̍���
;p5 = lHnd�c�c�n���h��
;�Ԃ�l�F�쐬�������X�g�r���[�̃n���h��

;	CreateWindowEx 0, "SysListView32", "", WS_CHILD|WS_VISIBLE|LVS_REPORT|LVS_SINGLESEL|LVS_SHOWSELALWAYS|LVS_NOSORTHEADER, xPos, yPos, listWidth, listHeight, hWnd, 0xFF01, hInstance, 0
	CreateWindowEx 0, "SysListView32", "", styles, xPos, yPos, listWidth, listHeight, hWnd, 0xFF01, hInstance, 0
	lHnd = stat

	sendmsg lHnd, LVM_SETEXTENDEDLISTVIEWSTYLE, exStyles, exStyles

	return lHnd
*/
#deffunc addListColumn str header, int hList, int align, int columnWidth, int index, local headerTemp
;���X�g�r���[�ɃJ�����i��j��ǉ�����B
;addListColumn "string", p1, p2, p3, p4(, p5)
;"string" = header�c�c�w�b�_�[������
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = align�c�c�J�������̕����z�u�i0=�� 1=�E 2=�����j
;p3 = columnWidth�c�c�J�����̕�
;p4 = index�c�c�J�����̃C���f�b�N�X
;p5 = headerTemp�c�c�|�C���^��n�����߂̈ꎞ�ϐ�
;�Ԃ�l�F�Ȃ�

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
;���X�g�r���[�ɃA�C�e����ǉ�����B
;addListItem "string", p1, p2(, p3)
;"string" = text�c�c�A�C�e��������
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�A�C�e���̃C���f�b�N�X
;p3 = textTemp�c�c�|�C���^��n�����߂̈ꎞ�ϐ�
;�Ԃ�l�F�Ȃ�

	dim lvitem, 13

	textTemp = text

	lvitem(0) = LVIF_TEXT
	lvitem(1) = index
	lvitem(2) = 0
	lvitem(5) = varptr(textTemp)

	sendmsg hList, LVM_INSERTITEM, 0, varptr(lvitem)

	return


#deffunc setListItem str text, int hList, int index, int subIndex, local textTemp
;�A�C�e���E�T�u�A�C�e���̐ݒ�A�y�ё����̕ύX���s���B
;setListItem "string", p1, p2, p3(, p4)
;"string" = text�c�c�i�T�u�j�A�C�e��������
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�C���f�b�N�X
;p3 = subIndex�c�c�T�u�A�C�e���̃C���f�b�N�X
;p4 = textTemp�c�c�|�C���^��n�����߂̈ꎞ�ϐ�
;�Ԃ�l�F�Ȃ�

	dim lvitem, 13

	textTemp = text

	lvitem(0) = LVIF_TEXT
	lvitem(1) = index
	lvitem(2) = subIndex
	lvitem(5) = varptr(textTemp)

	sendmsg hList, LVM_SETITEM, 0, varptr(lvitem)

	return


#deffunc getListItem var resultBuf, int hList, int index, int subIndex, int bufsize
;�w�肳�ꂽ�A�C�e���̏����擾����B
;getListItem v1, p1, p2, p3, p4
;v1 = resultBuf�c�c�擾���������i�[����o�b�t�@
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�擾����A�C�e���̃C���f�b�N�X
;p3 = subIndex�c�c�擾���镶����̃J�����̃C���f�b�N�X
;p4 = bufsize�c�cresultBuf�̃T�C�Y
;�Ԃ�l�F0�ȊO�B���s����0�B
	dim lvitem, 13

	lvitem(0) = LVIF_TEXT
	lvitem(1) = index
	lvitem(2) = subIndex
	lvitem(5) = varptr(resultBuf)
	lvitem(6) = bufsize

	sendmsg hList, LVM_GETITEM, 0, varptr(lvitem)

	return stat

#deffunc findSelectedItem int hList, int index
;�I�����ꂽ�A�C�e������������B
;findSelectedItem p1, p2
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�����J�n�C���f�b�N�X
;�Ԃ�l�F�Y���A�C�e���̃C���f�b�N�X�i�����ꍇ��-1�j
	sendmsg hList, LVM_GETNEXTITEM, index, LVNI_ALL|LVNI_SELECTED

	return stat


#deffunc findItem str string, int hList, int index, int matchingMode, local stringTemp
;�w�肳�ꂽ��������܂ރA�C�e������������B
;findItem "string", p1, p2, p3(, p4)
;"string" = string�c�c�������镶����
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�����J�n�C���f�b�N�X�i-1�ōŏ�����j
;p3 = matchingMode�c�c�}�b�`���O���[�h�i0=���S��v 1=�O����v�j
;p4 = stringTemp�c�c�|�C���^��n�����߂̈ꎞ�ϐ�
;�Ԃ�l�F�Y���A�C�e���̃C���f�b�N�X�i�����ꍇ��-1�j
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
;�w�肳�ꂽ�A�C�e�����폜����B
;deleteItem p1, p2
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�폜����A�C�e���̃C���f�b�N�X
;�Ԃ�l�F0�ȊO�̒l�B���s����0�B
	sendmsg hList, LVM_DELETEITEM, index

	return stat


#deffunc selectItem int hList, int index
;�w�肳�ꂽ�A�C�e����I����Ԃɂ���B
;selectItem p1, p2
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�I������A�C�e���̃C���f�b�N�X
;�Ԃ�l�F0�ȊO�̒l�B���s����0�B
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
;�w�肳�ꂽ�A�C�e����\���ł���ʒu�܂ŃX�N���[������B
;EnsureVisible p1, p2, p3
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = index�c�c�\������A�C�e���̃C���f�b�N�X
;p3 = partialFlag�c�c�����I�ȕ\���������Ȃ��i0�ŋ�����j
;�Ԃ�l�F�O�ȊO�̒l�B���s����0�B
	fPartialOK = limit(partialFlag, 0, 1)
	sendmsg hList, LVM_ENSUREVISIBLE, index, partialFlag

	return stat

#defcfunc HitTest int hList, int xPos, int yPos
;�w�肳�ꂽ���W�ɂ���A�C�e���̃C���f�b�N�X��Ԃ��B
;val = HitTest(p1, p2, p3)
;p1 = hList�c�c�Ώۂ̃��X�g�r���[�̃n���h��
;p2 = xPos�c�c�e�X�g������Wx�i�N���C�A���g���W�n�j
;p3 = yPos�c�c����y
;�Ԃ�l�F�e�X�g�������W�ɂ���A�C�e���̃C���f�b�N�X�B�������-1�B
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
