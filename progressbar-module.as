/***** �v���O���X�o�[���W���[�� *****/
#module "progressMod"
#define PBM_SETPOS 0x00000402		;�ʒu�w��
;wParam = nNewPos, lParam = 0
;nNewPos = �V�����ʒu
;�߂�l�F�ȑO�̈ʒu

#define PBM_SETSTEP 0x00000404		;�����ʐݒ�
;wParam = nStepInc, lParam = 0
;nStepInc = �V����������(default = 10)
;�߂�l�F�ȑO�̑�����

#define PBM_STEPIT 0x00000405		;�v���O���X�o�[����
;wParam = 0, lParam = 0
;�߂�l�F�ȑO�̈ʒu

#define PBM_SETRANGE32 0x00000406	;�v���O���X�o�[�͈͐ݒ�
;wParam = iLowLim, lParam = iHigLim
;iLowLim = �����l(default = 0)
;iHigLim = ����l(default = 100)
;�߂�l�F�ȑO�͈̔͂�DWORD�l�H

#deffunc createProgressBar int xPos, int yPos, int barWidth, int barHeight
;�v���O���X�o�[���쐬����B
;createProgressBar p1, p2, p3, p4
;p1 = xPos�c�cx�ʒu
;p2 = yPos�c�cy�ʒu
;p3 = barWidth�c�c�o�[�̕�
;p4 = barHeight�c�c�o�[�̍���
	CreateWindowEx 0, "msctls_progress32", "", WS_CHILD|WS_VISIBLE, xPos, yPos, barWidth, barHeight, hWnd, 0xff01, hInstance, 0

	return stat

#deffunc setProgressRange int hProgress, int min, int max
;�v���O���X�o�[�͈̔͂�ݒ肷��B
;setProgressRange p1, p2, p3
;p1 = hProgress�c�c�Ώۂ̃v���O���X�o�[�̃n���h��
;p2 = min�c�c�����l
;p3 = max�c�c����l
	sendmsg hProgress, PBM_SETRANGE32, min, max

	return


#deffunc setProgressStep int hProgress, int step
;�v���O���X�o�[�̑����ʁi�X�e�b�v�j��ݒ肷��B
;setProgressStep p1, p2
;p1 = hProgress�c�c�Ώۂ̃v���O���X�o�[�̃n���h��
;p2 = step�c�c�V�����X�e�b�v
	sendmsg hProgress, PBM_SETSTEP, step

	return

#deffunc setProgressPosition int hProgress, int position
;�v���O���X�o�[�̈ʒu��ݒ肷��B
;setProgressPosition p1, p2
;p1 = hProgress�c�c�Ώۂ̃v���O���X�o�[�̃n���h��
;p2 = position�c�c�V�����ʒu
	sendmsg hProgress, PBM_SETPOS, position

	return


#deffunc increaseProgress int hProgress
;�v���O���X�o�[�𑝉��ʁi�X�e�b�v�j��������������B
;increaseProgress p1
;p1 = hProgress�c�c�Ώۂ̃v���O���X�o�[�̃n���h��
	sendmsg hProgress, PBM_STEPIT

	return

#global
