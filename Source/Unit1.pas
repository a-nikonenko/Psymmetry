unit Unit1;
// Contours 2.1 (24.06.2014)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
  procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  d,OutD1,OutD2,OutD3,OutD4,OutD5,NameO: string[30];

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 i,j,Nn,Xcent,Ycent,sXco,sYco,symR,symP,Peri,imi,a,e,ii,aa: integer;
 Xsym,Ysym,dim: integer;
 x,y: array of integer;
 Xbo,Ybo: array[0..3000] of integer;
 Radius: array of real;
 ass,ass1,ShapeF,MinRadius,mi,Radi,Divider: real;
 BitMap: TBitMap;
 f: TextFile;

label
 L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12;
begin
 PaintBox1.Invalidate; PaintBox2.Invalidate; PaintBox3.Invalidate;
 Label1.Caption:=''; Label2.Caption:=''; Label3.Caption:='';
 Label4.Caption:=''; Label5.Caption:='';

 BitMap:=TBitMap.create;
 OpenPictureDialog1.Filter:='image files(*.bmp)|*.BMP';
 if OpenPictureDialog1.Execute and FileExists(OpenPictureDialog1.FileName) then
 BitMap.LoadFromFile(OpenPictureDialog1.FileName);
 if BitMap.PixelFormat <> pf1bit then goto L6;

 NameO:= ExtractFileName(OpenPictureDialog1.FileName);

 with PaintBox1 do Canvas.Draw(0,0,BitMap);
 with PaintBox2 do Canvas.Draw(0,0,BitMap);
 with PaintBox3 do Canvas.Draw(0,0,BitMap);   

// finding centroid and counting object pixels
// Nn - number of object pixels = Area

Nn:=0; sXco:=0; sYco:=0; Xcent:=0; Ycent:=0;
   for i:=0 to BitMap.Height-1 do begin
   for j:=0 to BitMap.Width-1 do begin
         if Canvas.Pixels[j,i]<>clBlack then goto L1 else
               begin Nn:=Nn+1; sXco:=sXco+j; sYco:=sYco+i end;
L1: end end;

if Nn<1 then goto L6;

//Xcent,Ycent - centroid coordinates
//x,y -object pixel coordinates

Xcent:=round(sXco/Nn); Ycent:=round(sYco/Nn);
SetLength(x,Nn+1); SetLength(y,Nn+1); SetLength(Radius,Nn+1); Nn:=0;

// remembering coordinates for object pixels

  for i:=0 to BitMap.Height-1 do begin
  for j:=0 to BitMap.Width-1 do begin
         if Canvas.Pixels[j,i]<>clBlack then goto L2 else
               begin Nn:=Nn+1; x[Nn]:=j; y[Nn]:=i end;
L2: end end;

// search for borderline pixels
// Xb0,Ybo - borderline pixel coordinates

Peri:=0;
for i:=0 to BitMap.Height-1 do begin
for j:=0 to BitMap.Width-1 do begin
 if Canvas.Pixels[j,i]<>clBlack then goto L4;
     if Canvas.Pixels[j,i-1]<>clBlack then goto L3;
     if Canvas.Pixels[j-1,i]<>clBlack then goto L3;
     if Canvas.Pixels[j+1,i]<>clBlack then goto L3;
     if Canvas.Pixels[j,i+1]<>clBlack then goto L3;
     goto L4;
L3: Peri:=Peri+1; Xbo[Peri]:=j; Ybo[Peri]:=i;
    Radius[Peri]:=sqrt(sqr(j-Xcent)+sqr(i-Ycent));
L4: end end;

with PaintBox1 do begin
for aa:=1 to Peri do begin Canvas.Pixels[Xbo[aa],Ybo[aa]]:=clRed end;
Canvas.Pixels[Xcent,Ycent]:=clRed end;

// search for radial symmetric pixels
// finding minimal radius

 MinRadius:=0;
for a:=1 to Peri do begin
mi:=Radius[a]; imi:=a;
for e:=1+a to Peri do if mi>Radius[e] then
    begin mi:=Radius[e]; imi:=e end;
    Radius[imi]:=Radius[a]; Radius[a]:=mi end; MinRadius:=Radius[1];
    Radi:=0; symR:=0;

with PaintBox2 do begin
for ii:=1 to Nn do begin
Radi:= sqrt(sqr(x[ii]-Xcent)+sqr(y[ii]-Ycent));
if Radi>(MinRadius+1) then goto L5;
symR:=symR+1; Canvas.Pixels[x[ii],y[ii]]:=clWhite;
L5: end end;

// search for pairwise symmetric pixels

with PaintBox3 do begin
symP:=0;
for i:=1 to Nn do begin
      if x[i]<Xcent then goto L8 else
      if y[i]>Ycent then goto L9 else
      {0-15' sector, x[i]>Xcent, y[i]<Ycent}
      Xsym:= Xcent-(x[i]-Xcent);
      Ysym:= Ycent+(Ycent-y[i]);
      goto L11;
L8: if y[i]>Ycent then goto L10 else
      {45-60' sector, x[i]<Xcent, y[i]<Ycent}
      Xsym:= Xcent+(Xcent-x[i]);
      Ysym:= Ycent+(Ycent-y[i]);
      goto L11;
L9: {15-30' sector, x[i]>Xcent, y[i]>Ycent}
      Xsym:= Xcent-(x[i]-Xcent);
      Ysym:= Ycent-(y[i]-Ycent);
      goto L11;
L10: {30-45' sector, x[i]<Xcent, y[i]>Ycent}
      Xsym:= Xcent+(Xcent-x[i]);
      Ysym:= Ycent-(y[i]-Ycent);
L11: if Canvas.Pixels[Xsym,Ysym]<>clBlack then goto L12;
     symP:=symP+1; Canvas.Pixels[Xsym,Ysym]:=clWhite;
L12: end end;

Str(Nn:8,d); Label1.Caption:='Area ='+ d;

Peri:=round(1.115*Peri);
Str(Peri:5,d); Label2.Caption:='Perimeter = '+ d;

ass:=0; ass:=100*((Nn-symR)/Nn); ass:=(round(10*ass)/10);
Str(ass:2:1,d); Label3.Caption:='RA metric ='+ d +'%';

ass1:=0; ass1:=100*((Nn-symP)/Nn); ass1:=(round(10*ass1)/10);
Str(ass1:2:1,d); Label4.Caption:='PA metric ='+ d +'%';

ShapeF:=(Peri*Peri)/(4*3.14*Nn);  ShapeF:=(round(100*ShapeF)/100);
Str(ShapeF:1:3,d); Label5.Caption:='Shape Factor = '+ d;

AssignFile(f,'data.txt');
 if FileExists('data.txt') then Append(f) else ReWrite(f);

 Str(Nn:6,OutD1); Str(Peri:5,OutD2);  Str(ass:2:3,OutD3);
 Str(ass1:2:3,OutD4); Str(ShapeF:2:4,OutD5);
 Writeln(f,  NameO,'   ',OutD1,'   ',OutD2,'   ',OutD3,'   ',OutD4,'   ',OutD5);
Flush(f); CloseFile(f); 

goto L7;
L6: Label1.Caption:='No object pixels, check whether you use 1-bit image';
L7: end;

end.
