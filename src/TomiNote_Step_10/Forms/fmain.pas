unit fMain;

{$mode objfpc}{$H+}

// String constants and string literals require this option
// 字符串常量和字符串字面量需要此选项
{$codepage UTF8}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, Menus, ActnList, uTreeDB, uHistory, Clipbrd;

type

  PNodeData = ^TNodeData;

  TNodeData = record
    ID                       : Integer;
    Loaded                   : Boolean;
    History                  : TSteps;
  end;

  TNodeDragMode = (dmMove, dmCopy);

  { TformMain }

  TformMain = class(TForm)
    openDlg1                 : TOpenDialog;
    saveDlg1                 : TSaveDialog;
    imglMain                 : TImageList;

    panlTree                 : TPanel;
    trevTree                 : TTreeView;
    spltTree                 : TSplitter;
    trevRecy                 : TTreeView;
    spltMain                 : TSplitter;
    panlNote                 : TPanel;
    memoNote                 : TMemo;
    spltNote                 : TSplitter;
    lstbInfo                 : TListBox;

    statMain                 : TStatusBar;

    actlMain                 : TActionList;
    actnNew                  : TAction;
    actnOpen                 : TAction;
    actnSave                 : TAction;
    actnSaveAs               : TAction;
    actnClose                : TAction;
    actnExit                 : TAction;
    actnSearch               : TAction;
    actnPrevSearchResult     : TAction;
    actnNextSearchResult     : TAction;
    actnOptions              : TAction;
    actnRename               : TAction;
    actnAddToFront           : TAction;
    actnAddToBehind          : TAction;
    actnAddToChildFirst      : TAction;
    actnAddToChildLast       : TAction;
    actnDeleteNode           : TAction;
    actnRecycleNode          : TAction;
    actnRestoreNode          : TAction;
    actnEmptyRecycler        : TAction;
    actnMoveUp               : TAction;
    actnMoveDown             : TAction;
    actnMoveLeft             : TAction;
    actnMoveRight            : TAction;
    actnExpand               : TAction;
    actnCollapse             : TAction;
    actnImport               : TAction;
    actnExport               : TAction;
    actnCut                  : TAction;
    actnCopy                 : TAction;
    actnPaste                : TAction;
    actnSelectAll            : TAction;
    actnDeleteText           : TAction;
    actnUndo                 : TAction;
    actnRedo                 : TAction;
    actnToggleMenuBar        : TAction;
    actnToggleToolBar        : TAction;
    actnToggleStatBar        : TAction;
    actnToggleTreeBar        : TAction;
    actnToggleInfoBar        : TAction;
    actnToggleRecyBar        : TAction;
    actnFullScreen           : TAction;
    actnFullWindow           : TAction;
    actnToggleTheme          : TAction;
    actnPrevNode             : TAction;
    actnNextNode             : TAction;
    actnWordWrap             : TAction;
    actnHelp                 : TAction;
    actnAbout                : TAction;

    menuMain                 : TMainMenu;
    mmiFile                  : TMenuItem;
    mmiNew                   : TMenuItem;
    mmiOpen                  : TMenuItem;
    mmiRecentFiles           : TMenuItem;
    mmiClearRecentFiles      : TMenuItem;
    mmiSave                  : TMenuItem;
    mmiSaveAs                : TMenuItem;
    mmiClose                 : TMenuItem;
    mmiExit                  : TMenuItem;
    mmiSeparator11           : TMenuItem;
    mmiSeparator12           : TMenuItem;
    mmiEdit                  : TMenuItem;
    mmiSearch                : TMenuItem;
    mmiPrevSearchResult      : TMenuItem;
    mmiNextSearchResult      : TMenuItem;
    mmiOptions               : TMenuItem;
    mmiSeparator21           : TMenuItem;
    mmiNode                  : TMenuItem;
    mmiRename                : TMenuItem;
    mmiAddToFront            : TMenuItem;
    mmiAddToBehind           : TMenuItem;
    mmiAddToChildFirst       : TMenuItem;
    mmiAddToChildLast        : TMenuItem;
    mmiDeleteNode            : TMenuItem;
    mmiRecycleNode           : TMenuItem;
    mmiEmptyRecycler         : TMenuItem;
    mmiMoveUp                : TMenuItem;
    mmiMoveDown              : TMenuItem;
    mmiMoveLeft              : TMenuItem;
    mmiMoveRight             : TMenuItem;
    mmiExpand                : TMenuItem;
    mmiCollapse              : TMenuItem;
    mmiImport                : TMenuItem;
    mmiExport                : TMenuItem;
    mmiSeparator31           : TMenuItem;
    mmiSeparator32           : TMenuItem;
    mmiSeparator33           : TMenuItem;
    mmiSeparator34           : TMenuItem;
    mmiSeparator35           : TMenuItem;
    mmiNote                  : TMenuItem;
    mmiCut                   : TMenuItem;
    mmiCopy                  : TMenuItem;
    mmiPaste                 : TMenuItem;
    mmiSelectAll             : TMenuItem;
    mmiDelete                : TMenuItem;
    mmiUndo                  : TMenuItem;
    mmiRedo                  : TMenuItem;
    mmiSeparator41           : TMenuItem;
    mmiSeparator42           : TMenuItem;
    mmiView                  : TMenuItem;
    mmiLayout                : TMenuItem;
    mmiToggleMenuBar         : TMenuItem;
    mmiToggleToolBar         : TMenuItem;
    mmiToggleStatBar         : TMenuItem;
    mmiToggleTreeBar         : TMenuItem;
    mmiToggleInfoBar         : TMenuItem;
    mmiToggleRecyBar         : TMenuItem;
    mmiFullScreen            : TMenuItem;
    mmiFullWindow            : TMenuItem;
    mmiToggleTheme           : TMenuItem;
    mmiPrevNode              : TMenuItem;
    mmiNextNode              : TMenuItem;
    mmiWordWrap              : TMenuItem;
    mmiSeparator51           : TMenuItem;
    mmiSeparator52           : TMenuItem;
    mmiSeparator53           : TMenuItem;
    mmiHelp                  : TMenuItem;
    mmiHelpContent           : TMenuItem;
    mmiAbout                 : TMenuItem;

    menuTree                 : TPopupMenu;
    pmiRename                : TMenuItem;
    pmiAddToFront            : TMenuItem;
    pmiAddToBehind           : TMenuItem;
    pmiAddToChildFirst       : TMenuItem;
    pmiAddToChildLast        : TMenuItem;
    pmiDeleteNode            : TMenuItem;
    pmiRecycleNode           : TMenuItem;
    pmiMoveUp                : TMenuItem;
    pmiMoveDown              : TMenuItem;
    pmiMoveLeft              : TMenuItem;
    pmiMoveRight             : TMenuItem;
    pmiExpand                : TMenuItem;
    pmiCollapse              : TMenuItem;
    pmiImport                : TMenuItem;
    pmiExport                : TMenuItem;
    pmiSearch                : TMenuItem;
    pmiSeparatorA01          : TMenuItem;
    pmiSeparatorA02          : TMenuItem;
    pmiSeparatorA03          : TMenuItem;
    pmiSeparatorA04          : TMenuItem;
    pmiSeparatorA05          : TMenuItem;
    pmiSeparatorA06          : TMenuItem;

    menuRecy                 : TPopupMenu;
    pmiRenameRecy            : TMenuItem;
    pmiRestoreNode           : TMenuItem;
    pmiDeleteNodeRecy        : TMenuItem;
    pmiEmptyRecycler         : TMenuItem;
    pmiMoveUpRecy            : TMenuItem;
    pmiMoveDownRecy          : TMenuItem;
    pmiMoveLeftRecy          : TMenuItem;
    pmiMoveRightRecy         : TMenuItem;
    pmiExpandRecy            : TMenuItem;
    pmiCollapseRecy          : TMenuItem;
    pmiExportRecy            : TMenuItem;
    pmiSearchRecy            : TMenuItem;
    pmiSeparatorB01          : TMenuItem;
    pmiSeparatorB02          : TMenuItem;
    pmiSeparatorB03          : TMenuItem;
    pmiSeparatorB04          : TMenuItem;
    pmiSeparatorB05          : TMenuItem;

    menuNote                 : TPopupMenu;
    pmiCut                   : TMenuItem;
    pmiCopy                  : TMenuItem;
    pmiPaste                 : TMenuItem;
    pmiSelectAll             : TMenuItem;
    pmiDeleteText            : TMenuItem;
    pmiUndo                  : TMenuItem;
    pmiRedo                  : TMenuItem;
    pmiToggleMenuBar         : TMenuItem;
    pmiSeparatorC01          : TMenuItem;
    pmiSeparatorC02          : TMenuItem;
    pmiSeparatorC03          : TMenuItem;

    tbarMain                 : TToolBar;
    tbtnNew                  : TToolButton;
    tbtnOpen                 : TToolButton;
    tbtnSave                 : TToolButton;
    tbtnSearch               : TToolButton;
    tbtnPrevNode             : TToolButton;
    tbtnNextNode             : TToolButton;
    tbtnUndo                 : TToolButton;
    tbtnRedo                 : TToolButton;
    tbtnWordWrap             : TToolButton;
    tbtnToggleTheme          : TToolButton;
    tbtnToggleTreeBar        : TToolButton;
    tbtnToggleInfoBar        : TToolButton;
    tbtnToggleRecyBar        : TToolButton;

    { Form 窗体 }

    procedure FormCreate(Sender: TObject);

  private

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ProcessCommandLine;
    procedure InitializeControls;

    procedure actnExitExecute(Sender: TObject);

    { Layout 布局 }

    procedure actnToggleMenuBarExecute(Sender: TObject);
    procedure actnToggleToolBarExecute(Sender: TObject);
    procedure actnToggleStatBarExecute(Sender: TObject);
    procedure actnToggleTreeBarExecute(Sender: TObject);
    procedure actnToggleInfoBarExecute(Sender: TObject);
    procedure actnToggleRecyBarExecute(Sender: TObject);
    procedure actnFullScreenExecute(Sender: TObject);
    procedure actnFullWindowExecute(Sender: TObject);

    procedure ToggleMenuBar(AVisible: Boolean);
    procedure ToggleToolBar(AVisible: Boolean);
    procedure ToggleStatBar(AVisible: Boolean);
    procedure ToggleTreeBar(AVisible: Boolean);
    procedure ToggleInfoBar(AVisible: Boolean);
    procedure ToggleRecyBar(AVisible: Boolean);
    procedure FullScreen(Full: Boolean);
    procedure FullWindow(Full: Boolean);

    procedure SetTreeBarWidth(AWidth: Integer);
    procedure SetRecyBarHeight(AHeight: Integer);
    procedure SetInfoBarHeight(AHeight: Integer);

    procedure ControlBarAutoSize;
    procedure ControlBarAutoAdjust;

  private

    { Theme 主题 }

    FActiveTheme             : Integer;

    procedure actnToggleThemeExecute(Sender: TObject);
    procedure SetActiveTheme(AThemeID: Integer);

    procedure SetForeColor(AColor: TColor);
    procedure SetBackColor(AColor: TColor);

    procedure SetWindowFontName(AName: string);
    procedure SetTreeBarFontName(AName: string);
    procedure SetNoteBarFontName(AName: string);
    procedure SetInfoBarFontName(AName: string);

    procedure SetWindowFontSize(ASize: Integer); inline;
    procedure SetTreeBarFontSize(ASize: Integer);
    procedure SetNoteBarFontSize(ASize: Integer); inline;
    procedure SetInfoBarFontSize(ASize: Integer); inline;

    procedure MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure treeCustomDrawArrow(Sender: TCustomTreeView; const ARect: TRect; ACollapsed: Boolean);

    { Memo 文本框 }

    procedure actnWordWrapExecute(Sender: TObject);
    procedure ToggleWordWrap(AWordWrap: Boolean);

    procedure RemoveMenuBarItem(ARemove: Boolean);

  private

    { Config 配置文件 }

    FConfigDir               : String;

    procedure SaveConfig;

    { Options Dialog - 选项对话框 }

    procedure actnOptionsExecute(Sender: TObject);

  public

    procedure LoadControlState;

    { Control State 控件状态 }

    procedure actnRenameUpdate(Sender: TObject);
    procedure actnCutUpdate(Sender: TObject);
    // Undo and Redo icons are on the toolbar, need to be updated in time.
    // 撤销和重做图标位于工具栏上，需要及时更新
    procedure actnUndoUpdate(Sender: TObject);
    procedure UpdateRecyclerState;

  private

    { Database File 数据库文件 }

    FTreeDB                  : TTreeDB;
    FDBName                  : string;
    FDBActive                : Boolean;
    FDBChanged               : Boolean;

    procedure SetDBActive(AValue: Boolean);
    procedure SetDBChanged(AValue: Boolean);

  published

    property DBName: string read FDBName write FDBName;
    property DBActive: Boolean read FDBActive write SetDBActive;
    property DBChanged: Boolean read FDBChanged write SetDBChanged;

  private

    procedure actnNewExecute(Sender: TObject);
    procedure actnOpenExecute(Sender: TObject);
    procedure actnSaveExecute(Sender: TObject);
    procedure actnCloseExecute(Sender: TObject);

    function OpenDB(FileName: string): Boolean;
    function SaveDB: Boolean;
    function CloseDB(Save: Boolean): Boolean;

    { Load Node 加载节点 }

    procedure LoadTree(Tree: TTreeView; Depth: Integer = 2);
    function  LoadNode(Tree: TTreeView; ID: Integer; ToNode: TTreeNode;
      Mode: TNodeAttachMode; Depth: Integer = 2): TTreeNode;
    procedure LoadSubNodes(Tree: TTreeView; Node: TTreeNode; Depth: Integer = 1);

    { UnLoad Node 卸载节点 }

    procedure UnloadTree(Tree: TTreeView);
    procedure UnLoadNode(Tree: TTreeView; Node: TTreeNode);
    procedure UnLoadSubNodes(Tree: TTreeView; Node: TTreeNode);

    { Node Data 节点数据 }

    function  GetNodeID(Node: TTreeNode): Integer; inline;
    procedure SetNodeID(Node: TTreeNode; AID: Integer);

    function  GetNodeLoaded(Node: TTreeNode): Boolean; inline;
    procedure SetNodeLoaded(Node: TTreeNode; ALoaded: Boolean);

    function  GetNodeHistory(Node: TTreeNode): TSteps; inline;
    procedure SetNodeHistory(Node: TTreeNode; AHistory: TSteps);

    procedure SetNodeData(Node: TTreeNode; AID: Integer; ALoaded: Boolean = False;
      AHistory: TSteps = nil);
    procedure FreeNodeData(Node: TTreeNode);

    { Add Node 添加节点 }

    procedure actnAddNodeExecute(Sender: TObject);
    function  AddNode(Tree: TTreeView; NodeName, NodeNote: string;
      ToNode: TTreeNode; Mode: TNodeAttachMode): TTreeNode;

    { Delete Node 删除节点 }

    procedure actnDeleteNodeExecute(Sender: TObject);
    function  DeleteNode(Node: TTreeNode): TTreeNode;

    { Rename Node 重命名节点 }

    procedure actnRenameExecute(Sender: TObject);
    procedure treeEdited(Sender: TObject; Node: TTreeNode; var S: string);

  private

    { Activate Node 激活节点 }

    FActiveTree              : TTreeView;
    FActiveNode              : TTreeNode;
    FDefSelectionColor       : TColor;

    procedure SetActiveNode(AValue: TTreeNode);

  published

    property ActiveNode: TTreeNode read FActiveNode write SetActiveNode;

  private

    procedure treeSelectionChanged(Sender: TObject);
    procedure treeEnter(Sender: TObject);
    procedure treeCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);

    { Recycle And Restore Node 回收和恢复节点 }

    procedure actnRecycleNodeExecute(Sender: TObject);
    procedure actnRestoreNodeExecute(Sender: TObject);
    procedure actnEmptyRecyclerExecute(Sender: TObject);

    function  RecycleNode(Node: TTreeNode): TTreeNode;
    function  RestoreNode(Node, ToNode: TTreeNode): TTreeNode;
    procedure EmptyRecycler;

    { Move Node 移动节点 }

    procedure actnMoveUpExecute(Sender: TObject);
    procedure actnMoveDownExecute(Sender: TObject);
    procedure actnMoveLeftExecute(Sender: TObject);
    procedure actnMoveRightExecute(Sender: TObject);

    function  MoveNode(ToTree: TTreeView; Node, ToNode: TTreeNode;
      Mode: TNodeAttachMode): TTreeNode;

    procedure MoveNodeUp(Node: TTreeNode);
    procedure MoveNodeDown(Node: TTreeNode);
    procedure MoveNodeLeft(Node: TTreeNode);
    procedure MoveNodeRight(Node: TTreeNode);

  private

    { Drag And Drop Node 拖拽节点 }

    FDragMode                : TNodeDragMode;

    procedure treeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure treeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure treeDragDrop(Sender, Source: TObject; X, Y: Integer);

    { Copy Node 复制节点 }

    function CopyNode(ToTree: TTreeView; Node, ToNode: TTreeNode;
      Mode: TNodeAttachMode): TTreeNode;

  private

    { Dynamic Load Node 动态加载节点 }

    FInEdit                  : Boolean;

    procedure treeExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);

  private

    { Load And Save Note 加载和保存笔记 }

    FNoteChanged             : Boolean;

    procedure memoNoteChange(Sender: TObject);
    procedure SubmitNote;
    procedure LoadNote(Node: TTreeNode);

  private

    { History 历史记录 }

    FHistory                 : THistory;
    FHistorySize             : SizeInt;

    procedure actnTextExecute(Sender: TObject);
    procedure memoNoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DiscardHistory(KeepActiveNode: boolean);
    function  GetHistorySize: SizeInt;

  end;

var
  formMain                 : TformMain;

implementation

uses
  uResources, uConfig, fOptions, LCLType, uCommon;

{$R *.lfm}

{$I fMainInterface.inc}
{$I fMainTreeDB.inc}

procedure TformMain.FormCreate(Sender: TObject);
begin
  ProcessCommandLine;

  Config := TConfig.Create(ConcatPaths([FConfigDir, ChangeFileExt(AppName, '.ini')]));
  Config.Load;

  InitializeControls;

  FTreeDB                  := TTreeDB.Create;

  FDBName                  := '';
  FDBActive                := False;
  FDBChanged               := False;

  FActiveTree              := nil;
  FActiveNode              := nil;

  FNoteChanged             := False;
  FInEdit                  := False;

  FDefSelectionColor       := trevTree.SelectionColor;

  // Must after the "memoNote.OnChange := ..."
  // 必须在 memoNote.OnChange := ... 之后
  FHistory                 := THistory.Create(memoNote);
  FHistorySize             := 0;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  // Don't set WindowState:=wsMaximized in FormCreate event,
  // otherwise the Form cannot be restored to normal size.
  // 不要在 FormCreate 中设置 WindowState:=wsFullScreen，
  // 否则窗口无法恢复正常尺寸。
  if Config.Maximized and not Config.FullScreen then begin
    WindowState := wsMaximized;
    // Don't trigger wsMaximized on next FormShow event
    // 不要在下一个 FormShow 事件中触发 wsMaximized
    Config.Maximized := False;
  end;
end;

procedure TformMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  actnCloseExecute(Sender);
  if FDBActive then CloseAction := caNone;
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  SaveConfig;
  Config.Free;
  FHistory.Free;
  FTreeDB.Free;
end;

procedure TformMain.FormResize(Sender: TObject);
begin
  ControlBarAutoSize;
  ControlBarAutoAdjust;

  if (WindowState = wsNormal) and not Config.FullScreen then begin
    Config.MainFormRect.Left   := RestoredLeft;
    Config.MainFormRect.Top    := RestoredTop;
    Config.MainFormRect.Width  := RestoredWidth;
    Config.MainFormRect.Height := RestoredHeight;
  end;
end;

procedure TformMain.ProcessCommandLine;
begin
  // Process command line parameters (--c --config)
  // 处理命令行参数（--c --config）
  if Application.HasOption('c', 'config') then
    FConfigDir := ExpandFileName(Application.GetOptionValue('c', 'config'))
  else
    FConfigDir := ConcatPaths([AppDir, 'config']);
  ForceDirectories(FConfigDir);
end;

procedure TformMain.InitializeControls;
begin
  Caption := Format('%s v%s', [AppTitle, AppVersion]);

  formMain                 .OnShow                  := @FormShow;
  formMain                 .OnClose                 := @FormClose;
  formMain                 .OnDestroy               := @FormDestroy;
  formMain                 .OnResize                := @FormResize;
  actnExit                 .OnExecute               := @actnExitExecute;

  BoundsRect := Config.MainFormRect;
  if Config.FullScreen then FullScreen(True);

  actnToggleMenuBar        .OnExecute               := @actnToggleMenuBarExecute;
  actnToggleToolBar        .OnExecute               := @actnToggleToolBarExecute;
  actnToggleStatBar        .OnExecute               := @actnToggleStatBarExecute;
  actnToggleTreeBar        .OnExecute               := @actnToggleTreeBarExecute;
  actnToggleInfoBar        .OnExecute               := @actnToggleInfoBarExecute;
  actnToggleRecyBar        .OnExecute               := @actnToggleRecyBarExecute;
  actnFullScreen           .OnExecute               := @actnFullScreenExecute;
  actnFullWindow           .OnExecute               := @actnFullWindowExecute;

  ToggleMenuBar(Config.MenuBarVisible);
  ToggleToolBar(Config.ToolBarVisible);
  ToggleStatBar(Config.StatBarVisible);
  ToggleTreeBar(Config.TreeBarVisible);
  ToggleInfoBar(Config.InfoBarVisible);
  ToggleRecyBar(Config.RecyBarVisible);

  SetTreeBarWidth(Config.TreeBarWidth);
  SetInfoBarHeight(Config.InfoBarHeight);
  SetRecyBarHeight(Config.RecyBarHeight);

  // Remove the tvoThemedDraw option to modify TreeView's color
  // 去掉 tvoThemedDraw 选项以修改 TreeView 的颜色
  trevTree.Options := trevTree.Options - [tvoThemedDraw];
  trevRecy.Options := trevRecy.Options - [tvoThemedDraw];

  actnToggleTheme          .OnExecute               := @actnToggleThemeExecute;
  trevTree                 .OnCustomDrawArrow       := @treeCustomDrawArrow;
  trevRecy                 .OnCustomDrawArrow       := @treeCustomDrawArrow;
  trevTree                 .OnMouseWheel            := @MouseWheel;
  trevRecy                 .OnMouseWheel            := @MouseWheel;
  memoNote                 .OnMouseWheel            := @MouseWheel;
  lstbInfo                 .OnMouseWheel            := @MouseWheel;

  SetActiveTheme(0);
  actnToggleTheme.Checked := Config.ActiveTheme = DarkThemeID;

  actnSave                 .Enabled                 := False;
  actnClose                .Enabled                 := False;
  actnUndo                 .Enabled                 := False;
  actnRedo                 .Enabled                 := False;

  SetWindowFontName(Config.WindowFontName);
  SetTreeBarFontName(Config.TreeBarFontName);
  SetNoteBarFontName(Config.NoteBarFontName);
  SetInfoBarFontName(Config.InfoBarFontName);

  SetWindowFontSize(Config.WindowFontSize);
  SetTreeBarFontSize(Config.TreeBarFontSize);
  SetNoteBarFontSize(Config.NoteBarFontSize);
  SetInfoBarFontSize(Config.InfoBarFontSize);

  actnWordWrap             .OnExecute               := @actnWordWrapExecute;

  ToggleWordWrap(Config.WordWrap);
  RemoveMenuBarItem(Config.RemoveMenuBarItem);

  actnOptions              .OnExecute               := @actnOptionsExecute;

  openDlg1.InitialDir := ConcatPaths([AppDir, 'data']);
  saveDlg1.InitialDir := ConcatPaths([AppDir, 'data']);

  openDlg1.Filter := Res_DialogFilterTDB;
  saveDlg1.Filter := Res_DialogFilterTDB;

  actnNew                  .OnExecute               := @actnNewExecute;
  actnOpen                 .OnExecute               := @actnOpenExecute;
  actnSave                 .OnExecute               := @actnSaveExecute;
  actnClose                .OnExecute               := @actnCloseExecute;

  actnAddToFront           .OnExecute               := @actnAddNodeExecute;
  actnAddToBehind          .OnExecute               := @actnAddNodeExecute;
  actnAddToChildFirst      .OnExecute               := @actnAddNodeExecute;
  actnAddToChildLast       .OnExecute               := @actnAddNodeExecute;
  actnDeleteNode           .OnExecute               := @actnDeleteNodeExecute;
  actnRecycleNode          .OnExecute               := @actnRecycleNodeExecute;
  actnRestoreNode          .OnExecute               := @actnRestoreNodeExecute;
  actnEmptyRecycler        .OnExecute               := @actnEmptyRecyclerExecute;

  actnRename               .OnExecute               := @actnRenameExecute;
  trevTree                 .OnEdited                := @treeEdited;
  trevRecy                 .OnEdited                := @treeEdited;

  actnMoveUp               .OnExecute               := @actnMoveUpExecute;
  actnMoveDown             .OnExecute               := @actnMoveDownExecute;
  actnMoveLeft             .OnExecute               := @actnMoveLeftExecute;
  actnMoveRight            .OnExecute               := @actnMoveRightExecute;

  actnRename               .OnUpdate                := @actnRenameUpdate;
  actnCut                  .OnUpdate                := @actnCutUpdate;
  actnUndo                 .OnUpdate                := @actnUndoUpdate;

  trevTree.ReadOnly := True;
  trevTree.RightClickSelect := True;
  // Must be empty before database opened | 打开数据库前必须为空
  trevTree.Items.Clear;

  trevRecy.ReadOnly := True;
  trevRecy.RightClickSelect := True;
  // Must be empty before database opened | 打开数据库前必须为空
  trevRecy.Items.Clear;

  trevTree                 .OnSelectionChanged      := @treeSelectionChanged;
  trevRecy                 .OnSelectionChanged      := @treeSelectionChanged;
  trevTree                 .OnEnter                 := @treeEnter;
  trevRecy                 .OnEnter                 := @treeEnter;

  trevTree                 .OnMouseDown             := @treeMouseDown;
  trevTree                 .OnDragOver              := @treeDragOver;
  trevTree                 .OnDragDrop              := @treeDragDrop;

  trevRecy                 .OnMouseDown             := @treeMouseDown;
  trevRecy                 .OnDragOver              := @treeDragOver;
  trevRecy                 .OnDragDrop              := @treeDragDrop;

  trevTree.Enabled := False;
  trevRecy.Enabled := False;

  trevTree                 .OnExpanding             := @treeExpanding;
  trevRecy                 .OnExpanding             := @treeExpanding;

  memoNote.Clear;
  memoNote.ReadOnly := True;

  memoNote                 .OnChange                := @memoNoteChange;

  actnCut                  .OnExecute               := @actnTextExecute;
  actnCopy                 .OnExecute               := @actnTextExecute;
  actnPaste                .OnExecute               := @actnTextExecute;
  actnSelectAll            .OnExecute               := @actnTextExecute;
  actnDeleteText           .OnExecute               := @actnTextExecute;
  actnUndo                 .OnExecute               := @actnTextExecute;
  actnRedo                 .OnExecute               := @actnTextExecute;

{$ifdef MSWINDOWS}
  memoNote                 .OnKeyDown               := @memoNoteKeyDown;
{$endif}
end;

end.

