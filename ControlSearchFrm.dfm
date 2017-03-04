object ControlSearchDlg: TControlSearchDlg
  Left = 0
  Top = 0
  Caption = 'ControlSearchDlg'
  ClientHeight = 518
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 41
    Align = alTop
    TabOrder = 0
    object Edit1: TEdit
      Left = 7
      Top = 11
      Width = 266
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 279
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 652
    Height = 477
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object CheckBox2: TCheckBox
        Left = 3
        Top = 16
        Width = 97
        Height = 17
        Caption = 'CheckBox2'
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitLeft = 7
      object CheckBox1: TCheckBox
        Left = 3
        Top = 16
        Width = 97
        Height = 17
        Caption = 'CheckBox1'
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 3
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
      object GroupBox1: TGroupBox
        Left = 160
        Top = 16
        Width = 201
        Height = 121
        Caption = 'GroupBox1'
        TabOrder = 2
        object CheckBox3: TCheckBox
          Left = 24
          Top = 24
          Width = 97
          Height = 17
          Caption = 'CheckBox3'
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          Left = 16
          Top = 72
          Width = 145
          Height = 21
          TabOrder = 1
          Text = 'ComboBox1'
        end
      end
    end
  end
end
