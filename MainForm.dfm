object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'File Explorer'
  ClientHeight = 600
  ClientWidth = 800
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
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 300
    Height = 581
    Align = alLeft
    Indent = 19
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    OnChange = TreeView1Change
  end
  object Splitter1: TSplitter
    Left = 300
    Top = 0
    Height = 581
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 303
    Top = 0
    Width = 497
    Height = 581
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 497
      Height = 400
      Align = alClient
      Center = True
      Proportional = True
      Stretch = True
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 481
      ExplicitHeight = 392
    end
    object Memo1: TMemo
      Left = 0
      Top = 400
      Width = 497
      Height = 181
      Align = alBottom
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 581
    Width = 800
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end