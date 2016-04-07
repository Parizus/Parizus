function varargout = BESO(varargin)
% BESO MATLAB code for BESO.fig
%      BESO, by itself, creates a new BESO or raises the existing
%      singleton*.
%
%      H = BESO returns the handle to a new BESO or the handle to
%      the existing singleton*.
%
%      BESO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BESO.M with the given input arguments.
%
%      BESO('Property','Value',...) creates a new BESO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BESO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BESO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BESO

% Last Modified by GUIDE v2.5 06-Apr-2016 15:49:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BESO_OpeningFcn, ...
                   'gui_OutputFcn',  @BESO_OutputFcn, ...
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


% --- Executes just before BESO is made visible.
function BESO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BESO (see VARARGIN)

% Choose default command line output for BESO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BESO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BESO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





function E_Callback(hObject, eventdata, handles)
% hObject    handle to E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E as text
%        str2double(get(hObject,'String')) returns contents of E as a double
E = str2double(get(hObject, 'String'));
if isnan(E)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.E = E;
guidata(hObject,handles)
% --- Executes during object creation, after setting all properties.
function E_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NU_Callback(hObject, eventdata, handles)
% hObject    handle to NU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NU as text
%        str2double(get(hObject,'String')) returns contents of NU as a double
NU = str2double(get(hObject, 'String'));
if isnan(NU)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.NU = NU;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function NU_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_Callback(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h as text
%        str2double(get(hObject,'String')) returns contents of h as a double
h = str2double(get(hObject, 'String'));
if isnan(h)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.h = h;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rho_Callback(hObject, eventdata, handles)
% hObject    handle to rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rho as text
%        str2double(get(hObject,'String')) returns contents of rho as a double
rho = str2double(get(hObject, 'String'));
if isnan(rho)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.rho = rho;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lx_Callback(hObject, eventdata, handles)
% hObject    handle to lx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lx as text
%        str2double(get(hObject,'String')) returns contents of lx as a double
lx = str2double(get(hObject, 'String'));
if isnan(lx)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.lx = lx;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function lx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ly_Callback(hObject, eventdata, handles)
% hObject    handle to ly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ly as text
%        str2double(get(hObject,'String')) returns contents of ly as a double
ly = str2double(get(hObject, 'String'));
if isnan(ly)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.ly = ly;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function ly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jdx_Callback(hObject, eventdata, handles)
% hObject    handle to jdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jdx as text
%        str2double(get(hObject,'String')) returns contents of jdx as a double
jdx = str2double(get(hObject, 'String'));
if isnan(jdx)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.jdx = jdx;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function jdx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jdy_Callback(hObject, eventdata, handles)
% hObject    handle to jdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jdy as text
%        str2double(get(hObject,'String')) returns contents of jdy as a double
jdy = str2double(get(hObject, 'String'));
if isnan(jdy)
    set(hObject, 'String', '');
    errordlg('Input must be a number','Error');
end
handles.jdy = jdy;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function jdy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main(handles.E,handles.NU,handles.h,handles.rho,handles.lx,handles.ly,handles.jdx,handles.jdy);
