# これは何？

Linux で jp106 キーボードを（キーの多さを活かしつつ）US 配列化するための、 XKB 定義の差分と、それを有効にするための設定書き換えスクリプトです。

* 現状では Fedora Linux でしか試していません。
* 設定書き換えスクリプトは拙作の [TclTaskRunner.tcl](https://github.com/hkoba/wip-TclTaskRunner0) を利用しています。予め PATH を通しておいてください。
* ↑ Tcl8.6 と tcllib が必要です
* 書き換えスクリプトの中で [xpath コマンド](https://metacpan.org/pod/XML::XPath)を呼びます。これも別途インストールが必要です

## 設定書き換えスクリプト [`main.tcltask`](./main.tcltask) について

インストール

```sh
./main.tcltask
```

dry-run

```sh
./main.tcltask -n
```
