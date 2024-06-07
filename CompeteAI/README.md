# CompeteAI

- Pythonのセットアップ

```shell
$ asdf local python 3.11.5
$ python -m venv .venv --prompt CompeteAI
$ source .venv/bin/activate
$ pip install --upgrade pip
$ pip install pip-tools
```

- 実行

```shell
$ make pin  # requirements.inとrequirements-dev.inからrequirements.txtとrequirements-dev.txtを生成
$ make install-dev  # 開発モードでインストール
$ make lint  # Linterを実行
$ make format  # フォーマッタを実行
$ make test  # テストを実行
$ streamlit run src/CompeteAI/app.py  # Streamlitアプリケーションを実行
```