unit ControlSearchFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  ControlSearchLib;

type
  TControlSearchDlg = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    controlSearch: TControlSearch;
  public
    { Public-Deklarationen }
  end;

var
  ControlSearchDlg: TControlSearchDlg;

implementation

{$R *.dfm}

procedure TControlSearchDlg.Button1Click(Sender: TObject);
begin
  controlSearch.Search(Edit1.Text);
end;

procedure TControlSearchDlg.FormCreate(Sender: TObject);
begin
  TabSheet2.TabVisible := false;
  controlSearch := TControlSearch.Create;
  controlSearch.Init(PageControl1);
  controlSearch.FoundControlStyle.Font.Style := [fsBold];
  controlSearch.FoundControlStyle.Font.Color := clGreen;
  controlSearch.FoundControlStyle.Color := clRed;

  controlSearch.AddTag(Edit2, 'Name');
  controlSearch.AddTag(CheckBox2, 'Benachrichtigungen');
end;

end.
