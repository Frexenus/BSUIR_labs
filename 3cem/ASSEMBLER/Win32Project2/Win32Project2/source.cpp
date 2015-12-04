#include <windows.h> // ������������ ����, ���������� ������� API
#include <stdlib.h>
#include <string.h>
#include <tchar.h>

TCHAR mainMessage[] = "text";

LRESULT CALLBACK WndProc(HWND hwnd, UINT iMsg, WPARAM wParam, LPARAM lParam){
	HDC hDC; // ������ ���������� ���������� ������ �� ������
	PAINTSTRUCT ps; // ���������, ���-��� ���������� � ���������� ������� (�������, ���� � ��)
	RECT rect; // ���-��, ������������ ������ ���������� �������
	COLORREF colorText = RGB(0, 0, 255); // ����� ���� ������
	switch (iMsg){
	case WM_PAINT: // ���� ����� ����������, ��:
		hDC = BeginPaint(hwnd, &ps); // �������������� �������� ����������
		GetClientRect(hwnd, &rect); // �������� ������ � ������ ������� ��� ���������
		SetTextColor(hDC, colorText); // ������������� ���� ������������ ����������
		DrawText(hDC, mainMessage, -1, &rect, DT_SINGLELINE | DT_CENTER | DT_VCENTER); // ������ �����
		EndPaint(hwnd, &ps); // ����������� ��������
		break;
	case WM_DESTROY: // ���� ������ ���������, ��:
		PostQuitMessage(NULL); // ���������� WinMain() ��������� WM_QUIT
		break;
	default:
		return DefWindowProc(hwnd, iMsg, wParam, lParam); // ���� ������� ������
	}


	return DefWindowProc(hwnd, iMsg, wParam, lParam); }

// �������� ������� - ������ int main() � ���������� ����������:
int WINAPI WinMain(HINSTANCE hInstance, //���������� ���������� ����������
	HINSTANCE hPrevInstance,// ���������� ����������� ���������� ����������
	LPSTR lpCmdLine,//��������� �� ������ ��������� ������, ��������� ��� ������� ���������.
	int nCmdShow) // ����� ����������� ����
{
	HWND hwnd;
	MSG msg;

	static TCHAR szWindowClass[] = _T("win32app");


	WNDCLASSEX wcex;

	wcex.cbSize = sizeof(WNDCLASSEX);
	wcex.style = CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc = WndProc;
	wcex.cbClsExtra = 0;
	wcex.cbWndExtra = 0;
	wcex.hInstance = hInstance;
	wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_APPLICATION));
	wcex.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
	wcex.lpszMenuName = NULL;
	wcex.lpszClassName = szWindowClass;
	wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_APPLICATION));

	if (!RegisterClassEx(&wcex))
	{
		MessageBox(NULL,
			_T("Call to RegisterClassEx failed!"),
			_T("Win32 Guided Tour"),
			NULL);

		return 1;
	}


	// ������� ������ ���� � ������� "��" �� ����� (� ���������� �����)
	//
	//MessageBox(NULL, "hi!!!", "hi", MB_OK);
	hwnd = CreateWindow(szWindowClass, "proc",
		WS_OVERLAPPEDWINDOW | WS_VISIBLE, // ������ ����������� ������
		200, // ��������� ���� �� ��� � (�� ���������)
		200, // ������� ���� �� ��� � (��� ������ � �, �� ������ �� �����)
		300, // ������ ������ (�� ���������)
		100, // ������ ���� (��� ������ � ������, �� ������ �� �����)
		NULL,
		NULL,
		hInstance,
		NULL);

	ShowWindow(hwnd,nCmdShow);
	UpdateWindow(hwnd);


	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return msg.wParam;


}
