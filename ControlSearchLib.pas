unit ControlSearchLib;

interface

uses
  System.Classes, Vcl.Controls, System.Generics.Collections, Vcl.ComCtrls,
  Vcl.Graphics;

type
  TFoundControlStyle = class;

  TInternalControl = class(TComponent)
  private
    FControl: TControl;
    fTags: TStringList;
    FTab: TTabSheet;
    FControlColor: TColor;
    FControlFont: TFont;
    function getParentTab: TTabSheet;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(control: TControl);reintroduce;
    destructor Destroy;override;
    function ContainsTag(searchTag: String): Boolean;
    procedure SetControlStyle(style: TFoundControlStyle);
    procedure ResetControlStyle;

    property Tags: TStringList read fTags;
    property Tab: TTabSheet read FTab;
  end;

  TFoundControlStyle = class(TObject)
  private
    FColor: TColor;
    FFont: TFont;
  public
    constructor Create;
    destructor Destroy;override;

    property Font: TFont read FFont;
    property Color: TColor read FColor;
  end;

  TControlSearch = class(TObject)
  private
    FInternalControlList: TObjectList<TInternalControl>;
    FPageControl: TPageControl;
    FMindedControls: TList<TWinControlClass>;
    FFoundControlStyle: TFoundControlStyle;
    procedure InitControl(control: TWinControl);
    function getInternalControlByControl(control:TControl): TInternalControl;
  public
    constructor Create;
    destructor Destroy;override;

    procedure Init(PageControl: TPageControl);
    procedure Search(searchText: String);
    procedure AddTag(control: TControl; tag: String);

    property FoundControlStyle: TFoundControlStyle read FFoundControlStyle;
    property MindedControls: TList<TWinControlClass> read FMindedControls;
  end;

implementation

uses
  Vcl.StdCtrls, System.SysUtils;

type
  TControlHack = class(TControl)
  public
    property Caption;
    property Color;
    property Font;
  end;

{ TInternalControl }

function TInternalControl.ContainsTag(searchTag: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to fTags.Count-1 do
  begin
    Result := fTags.Strings[i].ToLower.Contains(searchTag.ToLower);
    if Result then Break;
  end;
end;

constructor TInternalControl.Create(control: TControl);
begin
  inherited Create(nil);

  fTags := TStringList.Create;

  FControl := control;
  FControl.FreeNotification(Self);

  fTags.Add(TControlHack(control).Caption);
  FTab := getParentTab;
  FControlColor := TControlHack(control).Color;
  FControlFont := TFont.Create;
  FControlFont.Assign(TControlHack(FControl).Font);
end;

destructor TInternalControl.Destroy;
begin
  fTags.Free;
  FControlFont.Free;
  inherited;
end;

function TInternalControl.getParentTab: TTabSheet;
var
  parent: TWinControl;
begin
  Result := nil;
  parent := FControl.Parent;
  while parent <> nil do
  begin
    if parent is TTabSheet then
    begin
      Result := TTabSheet(parent);
      break;
    end;
    parent := parent.Parent;
  end;
end;

procedure TInternalControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then FControl := nil;
end;

procedure TInternalControl.ResetControlStyle;
begin
  TControlHack(FControl).Color := FControlColor;
  TControlHack(FControl).Font.Assign(FControlFont);
end;

procedure TInternalControl.SetControlStyle(style: TFoundControlStyle);
begin
  if style.Color <> clNone then TControlHack(FControl).Color := style.Color;
  TControlHack(FControl).Font.Assign(style.Font);
end;

{ TControlSearch }

procedure TControlSearch.AddTag(control: TControl; tag: String);
var
  internalControl: TInternalControl;
begin
  internalControl := getInternalControlByControl(control);
  if internalControl <> nil then
  begin
    internalControl.Tags.Add(tag);
  end;
end;

constructor TControlSearch.Create;
begin
  FInternalControlList := TObjectList<TInternalControl>.Create;
  FMindedControls := TList<TWinControlClass>.Create;
  FMindedControls.Add(TEdit);
  FMindedControls.Add(TCheckBox);
  FMindedControls.Add(TComboBox);

  FFoundControlStyle := TFoundControlStyle.Create;
end;

destructor TControlSearch.Destroy;
begin
  FInternalControlList.Free;
  FMindedControls.Free;
  FFoundControlStyle.Free;
  inherited;
end;

function TControlSearch.getInternalControlByControl(
  control: TControl): TInternalControl;
var
  internalControl: TInternalControl;
begin
  Result := nil;
  for internalControl in FInternalControlList do
  begin
    if internalControl.FControl = control then
    begin
      Result := internalControl;
      break;
    end;
  end;
end;

procedure TControlSearch.Init(PageControl: TPageControl);
var
  i: Integer;
  page: TTabSheet;
begin
  FPageControl := PageControl;
  FInternalControlList.Clear;

  for i := 0 to FPageControl.PageCount-1 do
  begin
    page := FPageControl.Pages[i];
    InitControl(page);
  end;
end;

procedure TControlSearch.InitControl(control: TWinControl);
var
  i: Integer;
  internalControl: TInternalControl;
  subControl: TControl;
begin
  for i := 0 to control.ControlCount-1 do
  begin
    subControl := control.Controls[i];

    if MindedControls.Contains(TWinControlClass(subControl.ClassType)) then
    begin
      internalControl := TInternalControl.Create(subControl);
      FInternalControlList.Add(internalControl);
    end;
    if subControl is TWinControl then InitControl(TWinControl(subControl));
  end;
end;

procedure TControlSearch.Search(searchText: String);
var
  i: Integer;
  page: TTabSheet;
  internalControl: TInternalControl;
begin
  for i := 0 to FPageControl.PageCount-1 do
  begin
    page := FPageControl.Pages[i];
    page.Visible := searchText.IsEmpty;
    page.TabVisible := searchText.IsEmpty;
  end;

  for internalControl in FInternalControlList do
  begin
    internalControl.ResetControlStyle;
    if (not searchText.IsEmpty) and internalControl.ContainsTag(searchText) then
    begin
      internalControl.Tab.Visible := true;
      internalControl.Tab.TabVisible := true;
      internalControl.SetControlStyle(FFoundControlStyle);
    end;
  end;
end;

{ TFoundControlStyle }

constructor TFoundControlStyle.Create;
begin
  FFont := TFont.Create;
  FColor := clNone;
end;

destructor TFoundControlStyle.Destroy;
begin
  FFont.Free;
  inherited;
end;

end.
