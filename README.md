URL を指定しファイルを取得するバッチです。

## 概要

- `src/webfilegetter.bat` が `env\Scripts\python.exe` を使って `src/webfilegetter.py` を実行します。
- バッチの先頭でスクリプト配置ディレクトリ（`src`）へ移動してから実行します（タスクスケジューラ実行を想定）。
- ダウンロード後、`DEST_DIR` で指定したフォルダへファイルを移動します。
- 既定の URL は以下です。

```text
https://www.data.jma.go.jp/stats/data/mdrr/pre_rct/alltable/pre1h00_rct.csv
```

- ダウンロードしたファイル名は URL の末尾を使用します（例: `pre1h00_rct.csv`）。
- 実行ログは `src/webfilegetter.log` に出力されます。

## 前提条件

- Windows
- プロジェクト直下に仮想環境 `env` が存在すること
- `requests` がインストールされていること

仮想環境が未作成の場合:

```powershell
python -m venv env
env\Scripts\python.exe -m pip install requests
```

## 使い方

プロジェクトルートで実行:

```powershell
src\webfilegetter.bat
```

必要に応じて、Python スクリプトを直接実行することもできます。

```powershell
env\Scripts\python.exe src\webfilegetter.py https://example.com/file.csv
```

実行後、以下のメッセージが表示されます。

```text
Execution completed. Check ...\src\webfilegetter.log for details.
```

## 出力先

- ログ: `src\webfilegetter.log`
- ダウンロードファイル: `DEST_DIR` で指定したフォルダ

既定値は `set DEST_DIR=%~dp0` のため、`src` フォルダ配下に配置されます。

## URL を変更する方法

`src/webfilegetter.bat` の次の行を書き換えてください。

```bat
set URL=...
```

## 保存先フォルダを変更する方法

`src/webfilegetter.bat` の次の行を書き換えてください。

```bat
set DEST_DIR=C:\path\to\output
```

## トラブルシュート

- `env folder does not exist...` が出る
	- `env` がないため、前提条件の手順で仮想環境を作成してください。
- ダウンロードに失敗する
	- `src/webfilegetter.log` の内容を確認してください（HTTP エラーや接続エラーが記録されます）。
