function varargout = ecualizador(varargin)
% ECUALIZADOR MATLAB code for ecualizador.fig
%      ECUALIZADOR, by itself, creates a new ECUALIZADOR or raises the existing
%      singleton*.
%
%      H = ECUALIZADOR returns the handle to a new ECUALIZADOR or the handle to
%      the existing singleton*.
%
%      ECUALIZADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECUALIZADOR.M with the given input arguments.
%
%      ECUALIZADOR('Property','Value',...) creates a new ECUALIZADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ecualizador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ecualizador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ecualizador

% Last Modified by GUIDE v2.5 11-May-2015 14:59:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ecualizador_OpeningFcn, ...
                   'gui_OutputFcn',  @ecualizador_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

% --- Executes just before ecualizador is made visible.
function ecualizador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ecualizador (see VARARGIN)

% Choose default command line output for ecualizador
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%UIWAIT makes ecualizador wait for user response (see UIRESUME)
%uiwait(handles.figure1);
global t
global y
global Yifft
set(handles.text5, 'String', get(handles.FilterPasaBajos,'Max'));
set(handles.text6, 'String', get(handles.FilterPasaBajos,'Min'));

plot(handles.axes1,t,y)


plot(handles.axes2,t,Yifft)



% --- Outputs from this function are returned to the command line.
function varargout = ecualizador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PlayPre.
function PlayPre_Callback(hObject, eventdata, handles)
% hObject    handle to PlayPre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reproductor

play(reproductor);


% --- Executes on button press in PlayPost.
function PlayPost_Callback(hObject, eventdata, handles)
% hObject    handle to PlayPost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reproductorPost1

play(reproductorPost1);

% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reproductor
global reproductorPost1
stop(reproductor);
stop(reproductorPost1);

% --- Executes on slider movement.
function FilterPasaBajos_Callback(hObject, eventdata, handles)
% hObject    handle to FilterPasaBajos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text7, 'String', get(handles.FilterPasaBajos,'Value'));

global t
global y
global F
global fs
global reproductor
global reproductorPost1
global Yfftmenos
global prueba

prueba=100+get(handles.FilterPasaBajos,'Value');
reproductor = audioplayer(y,fs)
y=audioread('Rock1.wav');

y=y(:,1);
dt=1/fs;
t=0:dt:(length(y)*dt)-dt;

%Inicio Filtro pasa bajos
Yfft=fft(y,length(y));
F=((0:1/length(y):1-1/length(y))*fs).';
Yfftmenos=Yfft;

Yfftmenos(F>=get(handles.FilterPasaBajos,'Value') & F<=fs-get(handles.FilterPasaBajos,'Value')) = 0;

Yifft=ifft(Yfftmenos,'symmetric');


reproductorPost1 = audioplayer(Yifft,fs)

plot(handles.axes1,t,y)


plot(handles.axes2,t,Yifft)

% --- Executes during object creation, after setting all properties.
function FilterPasaBajos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilterPasaBajos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function FilterPasaAltos_Callback(hObject, eventdata, handles)
% hObject    handle to FilterPasaAltos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function FilterPasaAltos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilterPasaAltos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
