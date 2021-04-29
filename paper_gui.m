function varargout = paper_gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @paper_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @paper_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function paper_gui_OpeningFcn(hObject, eventdata, handles, varargin)
one = ones(50);
x = [one(1,:); (0.1:0.2:10); one(1,:)]; % ����� ������ ���߱� ���� 0.2��
y = x;    %����� ���

axis([-8 10 -5 10]);
hold on;
line(y(1,:),y(2,:));
pause(0.00001);

handles.output = hObject;
guidata(hObject, handles);

function varargout = paper_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
handles.wind = get(handles.slider1,'Value');
one = ones(50);
x = [one(1,:); (0.1:0.2:10); one(1,:)]; % ����� ������ ���߱� ���� 0.2��
y = x;    %����� ���

 for i= 0 : 0.1*pi : 10*pi   
    A = [1 handles.wind*exp(-1/10*i)*cos(i) 0; 0 1 0; 0 0 1;]; % ���� ������ �پ���
    B = A;   
    for k = 1:1:50 % �־����� �ϱ� ���� �� ������ ���� �ٸ� ���� ������
        I = k/50*A(1,2);
        B(1,2) = sin(I);
        B(2,2) = -cos(I);
        y(:,k) = B * x(:,k);
    end
    clf;
    axis([-8 10 -15 0]);
    hold on;
    line(y(1,:),y(2,:));
    pause(0.00001);
end

function slider1_Callback(hObject, eventdata, handles)
handles.wind=get(hObject,'Value');
guidata(hObject,handles);

function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
