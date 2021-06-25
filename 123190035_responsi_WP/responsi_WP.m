function varargout = responsi_WP(varargin)
% RESPONSI_WP MATLAB code for responsi_WP.fig
%      RESPONSI_WP, by itself, creates a new RESPONSI_WP or raises the existing
%      singleton*.
%
%      H = RESPONSI_WP returns the handle to a new RESPONSI_WP or the handle to
%      the existing singleton*.
%
%      RESPONSI_WP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_WP.M with the given input arguments.
%
%      RESPONSI_WP('Property','Value',...) creates a new RESPONSI_WP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsi_WP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsi_WP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsi_WP

% Last Modified by GUIDE v2.5 25-Jun-2021 19:41:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsi_WP_OpeningFcn, ...
                   'gui_OutputFcn',  @responsi_WP_OutputFcn, ...
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


% --- Executes just before responsi_WP is made visible.
function responsi_WP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsi_WP (see VARARGIN)
set(handles.uipanel1,'visible','on');
set(handles.uipanel2,'visible','off');

% Choose default command line output for responsi_WP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes responsi_WP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsi_WP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]= uigetfile({'*.xlsx';},'openData'); %menggunakan fungsi uigetfile untuk mengambil file 
fullpathname = strcat(pathname, filename);              %dari direktori dengan file ber eksistensi '*.xlsx'
data = xlsread(fullpathname); %membaca file
set(handles.uitable1,'Data',data);%simpan/set data pada uitable1 - matriks data

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
close;

% --- Executes on button press in inputdata.
function inputdata_Callback(hObject, eventdata, handles)
% hObject    handle to inputdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1,'visible','on');
set(handles.uipanel2,'visible','off');

% --- Executes on button press in outputhasil.
function outputhasil_Callback(hObject, eventdata, handles)
% hObject    handle to outputhasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1,'visible','off');
set(handles.uipanel2,'visible','on');

%simpan ambil datarumah matriks pada uitable1 data
datarumah=get(handles.uitable1,'data');

k = [0,0,1,0];%atribut tiap kriteria, dimana nilai 1=benefit, dan 0=cost
w = [3,5,4,1];%Nilai bobot tiap kriteria 

[m n]=size (datarumah); %inisialisasi  matriks ukuran datarumah 

w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, proses perhitungan vektor(S) per baris 
for j=1:n, 
    if k(j)==0, w(j)=-1*w(j); 
    end; 
end; 
for i=1:m, 
    S(i)=prod(datarumah(i,:).^w); 
end;

%tahapan ketiga, proses perangkingan 
V= S/sum(S)
set(handles.uitable2,'Data',V);
[nilai,rank]=max(V); %perangkingan nilai terbesar
set(handles.besarnilai,'string',(nilai));%penentuan real estat terbaik by nama
if(rank == 1)
   set(handles.namaperumahan,'string',("Real Estat Nomor 1"));
elseif (rank == 2)
   set(handles.namaperumahan,'string',("Real Estat Nomor 2"));
elseif (rank == 3)
   set(handles.namaperumahan,'string',("Real Estat Nomor 3"));
elseif (rank == 4)
   set(handles.namaperumahan,'string',("Real Estat Nomor 4")); 
elseif (rank == 5)
   set(handles.namaperumahan,'string',("Real Estat Nomor 5"));
elseif (rank == 6)
   set(handles.namaperumahan,'string',("Real Estat Nomor 6")); 
elseif (rank == 7)
   set(handles.namaperumahan,'string',("Real Estat Nomor 7")); 
elseif (rank == 8)
   set(handles.namaperumahan,'string',("Real Estat Nomor 8")); 
elseif (rank == 9)
   set(handles.namaperumahan,'string',("Real Estat Nomor 9")); 
elseif (rank == 10)
   set(handles.namaperumahan,'string',("Real Estat Nomor 10")); 
elseif (rank == 11)
   set(handles.namaperumahan,'string',("Real Estat Nomor 11"));
elseif (rank == 12)
   set(handles.namaperumahan,'string',("Real Estat Nomor 12"));
elseif (rank == 13)
   set(handles.namaperumahan,'string',("Real Estat Nomor 13"));
elseif (rank == 14)
   set(handles.namaperumahan,'string',("Real Estat Nomor 14")); 
elseif (rank == 15)
   set(handles.namaperumahan,'string',("Real Estat Nomor 15"));
elseif (rank == 16)
   set(handles.namaperumahan,'string',("Real Estat Nomor 16")); 
elseif (rank == 17)
   set(handles.namaperumahan,'string',("Real Estat Nomor 17")); 
elseif (rank == 18)
   set(handles.namaperumahan,'string',("Real Estat Nomor 18")); 
elseif (rank == 19)
   set(handles.namaperumahan,'string',("Real Estat Nomor 19")); 
elseif (rank == 20)
   set(handles.namaperumahan,'string',("Real Estat Nomor 20")); 
elseif (rank == 21)
   set(handles.namaperumahan,'string',("Real Estat Nomor 21")); 
elseif (rank == 22)
   set(handles.namaperumahan,'string',("Real Estat Nomor 22"));
elseif (rank == 23)
   set(handles.namaperumahan,'string',("Real Estat Nomor 23"));
elseif (rank == 24)
   set(handles.namaperumahan,'string',("Real Estat Nomor 24")); 
elseif (rank == 25)
   set(handles.namaperumahan,'string',("Real Estat Nomor 25"));
elseif (rank == 26)
   set(handles.namaperumahan,'string',("Real Estat Nomor 26")); 
elseif (rank == 27)
   set(handles.namaperumahan,'string',("Real Estat Nomor 27")); 
elseif (rank == 28)
   set(handles.namaperumahan,'string',("Real Estat Nomor 28")); 
elseif (rank == 29)
   set(handles.namaperumahan,'string',("Real Estat Nomor 29")); 
elseif (rank == 30)
   set(handles.namaperumahan,'string',("Real Estat Nomor 30")); 
elseif (rank == 31)
   set(handles.namaperumahan,'string',("Real Estat Nomor 31")); 
elseif (rank == 32)
   set(handles.namaperumahan,'string',("Real Estat Nomor 32"));
elseif (rank == 33)
   set(handles.namaperumahan,'string',("Real Estat Nomor 33"));
elseif (rank == 34)
   set(handles.namaperumahan,'string',("Real Estat Nomor 34")); 
elseif (rank == 35)
   set(handles.namaperumahan,'string',("Real Estat Nomor 35"));
elseif (rank == 36)
   set(handles.namaperumahan,'string',("Real Estat Nomor 36")); 
elseif (rank == 37)
   set(handles.namaperumahan,'string',("Real Estat Nomor 37")); 
elseif (rank == 38)
   set(handles.namaperumahan,'string',("Real Estat Nomor 38")); 
elseif (rank == 39)
   set(handles.namaperumahan,'string',("Real Estat Nomor 39")); 
elseif (rank == 40)
   set(handles.namaperumahan,'string',("Real Estat Nomor 40"));
elseif (rank == 41)
   set(handles.namaperumahan,'string',("Real Estat Nomor 41")); 
elseif (rank == 42)
   set(handles.namaperumahan,'string',("Real Estat Nomor 42"));
elseif (rank == 43)
   set(handles.namaperumahan,'string',("Real Estat Nomor 43"));
elseif (rank == 44)
   set(handles.namaperumahan,'string',("Real Estat Nomor 44")); 
elseif (rank == 45)
   set(handles.namaperumahan,'string',("Real Estat Nomor 45"));
elseif (rank == 46)
   set(handles.namaperumahan,'string',("Real Estat Nomor 46")); 
elseif (rank == 47)
   set(handles.namaperumahan,'string',("Real Estat Nomor 47")); 
elseif (rank == 48)
   set(handles.namaperumahan,'string',("Real Estat Nomor 48")); 
elseif (rank == 49)
   set(handles.namaperumahan,'string',("Real Estat Nomor 49")); 
elseif (rank == 50)
   set(handles.namaperumahan,'string',("Real Estat Nomor 50")); 
 
end;

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1, 'Data', {}) %bersihkan data uitable 1
clc;
clear;
