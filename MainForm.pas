unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Image1: TImage;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    procedure LoadDirectory(Node: TTreeNode; const Directory: string);
    procedure DisplayFile(const FileName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Загружаем корневые диски в дерево
  TreeView1.Items.Clear;
  LoadDirectory(nil, '');
end;

procedure TForm1.LoadDirectory(Node: TTreeNode; const Directory: string);
var
  SearchRec: TSearchRec;
  TreeNode: TTreeNode;
begin
  if FindFirst(Directory + '*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = faDirectory then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          TreeNode := TreeView1.Items.AddChild(Node, SearchRec.Name);
          TreeNode.ImageIndex := 0; // Индекс изображения для папки
          TreeNode.SelectedIndex := 0;
          LoadDirectory(TreeNode, IncludeTrailingPathDelimiter(Directory + SearchRec.Name));
        end;
      end
      else
      begin
        TreeNode := TreeView1.Items.AddChild(Node, SearchRec.Name);
        TreeNode.ImageIndex := 1; // Индекс изображения для файла
        TreeNode.SelectedIndex := 1;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;
end;

procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  FilePath: string;
begin
  if Assigned(Node) and (Node.ImageIndex = 1) then
  begin
    FilePath := GetPathFromNode(Node);
    DisplayFile(FilePath);
    StatusBar1.SimpleText := FilePath;
  end
  else
  begin
    Image1.Picture := nil;
    Memo1.Lines.Clear;
    StatusBar1.SimpleText := '';
  end;
end;

procedure TForm1.DisplayFile(const FileName: string);
var
  Ext: string;
begin
  Ext := LowerCase(ExtractFileExt(FileName));
  if (Ext = '.bmp') or (Ext = '.jpg') then
  begin
    Image1.Picture.LoadFromFile(FileName);
    Memo1.Lines.Clear;
  end
  else if Ext = '.txt' then
  begin
    Memo1.Lines.LoadFromFile(FileName);
    Image1.Picture := nil;
  end
  else
  begin
    Image1.Picture := nil;
    Memo1.Lines.Clear;
  end;
end;

function TForm1.GetPathFromNode(Node: TTreeNode): string;
begin
  Result := '';
  while Assigned(Node) do
  begin
    Result := IncludeTrailingPathDelimiter(Node.Text) + Result;
    Node := Node.Parent;
  end;
  Result := ExcludeTrailingPathDelimiter(Result);
end;

end.