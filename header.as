/***** EXE�쐬�I�v�V���� *****/
#packopt name "rousers"
#packopt runtime "hsp3c.hrt"
#packopt hide 1

/***** �w�b�_�t�@�C�� *****/
#include "general.as"	;���ʃ��W���[��
#include "listview-module.as"		;���X�g�r���[���W���[��
#include "progressbar-module.as"	;�v���O���X�o�[���W���[��
#include "contextMenu-module.as"	;�R���e�L�X�g���j���[���W���[��

/***** ��` *****/
#enum MainWindow = 0
#enum CardInfoWindow
#enum DeckWindow
#enum FilteringSettingWindow
#enum SearchSettingWindow
#enum ProgressWindow

;�R���e�L�X�g���j���[��ID
#define AddToDeck 0x0100
#define SearchBy 0x0101
