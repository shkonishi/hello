Rのパッケージを作成する
================
S.Konishi
2019-03-03

Table of Contents
=================

   * [Rのパッケージを作成する](#rのパッケージを作成する)
      * [devtoolsのインストール](#devtoolsのインストール)
      * [Gitのインストール、GitHubのアカウント作成、リモートリポジトリの新規作成](#gitのインストールgithubのアカウント作成リモートリポジトリの新規作成)
      * [Rパッケージの雛形を作成しGitのローカルリポジトリとする](#rパッケージの雛形を作成しgitのローカルリポジトリとする)
         * [新規にRパッケージを作成する場合](#新規にrパッケージを作成する場合)
         * [リモートリポジトリをローカルに複製する場合](#リモートリポジトリをローカルに複製する場合)
         * [パッケージの中身を確認](#パッケージの中身を確認)
      * [ローカルリポジトリとリモートリポジトリを同期。](#ローカルリポジトリとリモートリポジトリを同期)
      * [パッケージをGitHubからダウンロードしてインストール](#パッケージをgithubからダウンロードしてインストール)
      * [ローカルリポジトリの編集](#ローカルリポジトリの編集)
         * [.gitignore](#gitignore)
         * [.Rbuildignore](#rbuildignore)
         * [DESCRIPTION](#description)
         * [NAMESPACE](#namespace)
         * [roxygen2を使ってドキュメント作成](#roxygen2を使ってドキュメント作成)
            * [roxygen形式のコメント書式](#roxygen形式のコメント書式)
            * [roxygen形式のコメント書式(NAMESPACE用)](#roxygen形式のコメント書式namespace用)
            * [examplesのコードをnot runにする。](#examplesのコードをnot-runにする)
         * [devtools::check()を実行](#devtoolscheckを実行)
         * [LICENSEを決める](#licenseを決める)
         * [README.mdの作成](#readmemdの作成)
         * [github のmdファイルに目次をつける. Table of Contents](#github-のmdファイルに目次をつける-table-of-contents)
      * [外部データをパッケージに含める](#外部データをパッケージに含める)
         * [バイナリデータをdataディレクトリ置く場合](#バイナリデータをdataディレクトリ置く場合)
         * [R/にバイナリデータのdocumentを作成する。](#rにバイナリデータのdocumentを作成する)
         * [データファイルをinst/extdataに置く場合](#データファイルをinstextdataに置く場合)
      * [コードスタイル整形](#コードスタイル整形)
      * [コミットメッセージについて](#コミットメッセージについて)
         * [直前のコミットにまとめるgit commit --amend -m "message"](#直前のコミットにまとめるgit-commit---amend--m-message)
         * [複数のコミットを 1 つにまとめるgit rebase -i](#複数のコミットを-1-つにまとめるgit-rebase--i)
      * [環境](#環境)



| ---------------------------------------- |
| Rのパッケージを作成してGitHubで管理する。 調べた内容を適宜追加していく。 |

## devtoolsのインストール

  - Rのパッケージ開発が容易にできる, `roxygen2`や`usethis`等も一緒にインストールされる。

<!-- end list -->

``` r
install.packages("devtools")
```

## Gitのインストール、GitHubのアカウント作成、リモートリポジトリの新規作成

  - Gitを(<https://git-scm.com/downloads>) からインストールする。ユーザー名,メールアドレス設定,
    etc.
  - GitHubアカウントを作成して(<https://github.com>)、リモートリポジトリを新規作成する。その際に **…or
    push an existing repository from the command
    line**のところにあるコマンドをコピーしておく。

<!-- end list -->

``` 

git remote add origin https://github.com/[アカウント名]/[リポジトリ名]
git push -u origin master
```

## Rパッケージの雛形を作成しGitのローカルリポジトリとする

### 新規にRパッケージを作成する場合

  - RStudioからパッケージの雛形を作成する場合、`File -> New Project -> New Directory -> R
    package`として、`Create a git repository`にcheckを入れて`Create
    Project`するとRパッケージの雛形が作られると同時にgitのローカルリポジトリが作られる。
  - RStudioからは見えないが、パッケージを作成した場所に`.git`というディレクトリができている。ターミナルから`git
    init`を実行してもできる。
  - Rのコンソールからパッケージの雛形を作成する場合は`devtools::create`を実行する。

<!-- end list -->

``` r
# ローカルリポジトリを作る場所
setwd("~/pub/rlib")

# 雛形を作成
devtools::create(pkgname,
  description=list(
      Package="hello", # パッケージ名
      Title="Exersice of R package development", # パッケージの説明
      Version = "0.1.0",
      Author = "Shogo Konishi <shkonishi@gmail.com>",
      Maintainer="The package maintainer <shkonishi@gmail.com>",
      Description="Exersice of R package development",
      License='MIT + file LICENSE',
      Encoding="UTF-8",
      LazyData="true"
)
```

### リモートリポジトリをローカルに複製する場合

RStudioから`File -> New Project -> Version Control -> Git`を選んで、`Repository
URL:`を入れて`Create Project`でローカルリポジトリーにクローンできる。

### パッケージの中身を確認

  - これらを適宜編集してリモートリポジトリと同期させる。
  - 後述の操作で作成するファイルも含まれているので、これが初期状態ではない。

<!-- end list -->

    ## .
    ## ├── DESCRIPTION
    ## ├── LICENSE
    ## ├── NAMESPACE
    ## ├── R
    ## │   ├── hello.R
    ## │   ├── pois_mat.R
    ## │   └── sysdata.rda
    ## ├── README.Rmd
    ## ├── README.md
    ## ├── data
    ## │   └── pois_mat.rda
    ## ├── hello.Rproj
    ## ├── inst
    ## │   └── extdata
    ## │       └── pois.txt
    ## └── man
    ##     ├── hello.Rd
    ##     └── pois_mat.Rd
    ## 
    ## 5 directories, 13 files

## ローカルリポジトリとリモートリポジトリを同期。

  - RStudioでNew Projectを作る際に`Create a git repository`にチェックを入れて`Create
    Project`すると、付属のGitクライアントツールを使えるようになる。
  - Gitペインからよく使うgitコマンド、commit(ファイルの変更等をローカルリポジトリへ反映させる)や、push(ローカルリポジトリの変更をリモートリポジトリへ反映)することができる。  
  - リモートリポジトリの登録`git remote add`はターミナルを起動して行う。  
  - ターミナルはRStudioのGitのペインの歯車マークから起動できる。
  - 登録した後で`Tools -> Project Options ->
    Git/SVN`を選択して`Origin`のところがリモートリポジトリのアドレスになっていることを確認する。

<!-- end list -->

    git remote add origin https://github.com/shkonishi/hello.git
    git commit -m "first commit" 
    git push -u origin master
    
    # ローカルリポジトリ名を変更した場合リモートの新しいアドレスと対応させる。
    git remote set-url origin https://github.com/shkonishi/test.git

## パッケージをGitHubからダウンロードしてインストール

ここまでで、RのパッケージがGitHubからダウンロード可能になっているので、インストールしてみる。
リモートリポジトリにローカルリポジトリの変更が反映されているか確認する。

``` r
# GitHubからソースパッケージをダウンロード->ビルド->インストールする　
devtools::install_github("shkonishi/hello", quiet = T)　

# 試しに関数を実行してみる。
library(hello)
hello(n = 3)
```

    ## [1] "Hello, world!" "Hello, world!" "Hello, world!"

## ローカルリポジトリの編集

パッケージに変更を加えたら、だいたい以下の流れを繰り返す。

1.  各種ファイルを編集`DESCRIPTION`、`.Rbuildignore`, `.gitignore`。
2.  Rスクリプトを書いて、`R/`ディレクトリに置く。
3.  ドキュメントの作成(スクリプトの中にroxygen形式のコメントを書く。)
4.  `devtools::document()`を実行する。`NAMESPACE`とドキュメント(`man/*.Rd`)が作られる。
5.  RStudioのBuildペインからCheckを実行する(もしくはコンソールから`devtools::check`)
6.  Install and Restartを実行する。
7.  必要に応じて`LICENCE`, `README.md`を作成する。
8.  リモートリポジトリと同期する。

### .gitignore

  - ここに記述されたファイルの変更はリモートリポジトリに反映されない

<!-- end list -->

    ## .Rproj.user
    ## .Rhistory
    ## .RData
    ## .Ruserdata

### .Rbuildignore

  - ソースパッケージ(開発バージョンのパッケージ)を`devtools::build`でビルドすると、ここにリストされているファイルはバンドルパッケージ(.tar.gz)に含まれない。
  - Perl互換の正規表現で書く。
  - `.DS_Store`とかも書いておく。正しく書くためには`devtools::use_build_ignore(".DS_Store")`とすれば書き込んでくれる。

<!-- end list -->

    ## ^.*\.Rproj$
    ## ^\.Rproj\.user$
    ## ^\.DS_Store$
    ## ^README\.Rmd$
    ## ^README\.md$

### DESCRIPTION

  - パッケージのメタデータ
  - **`Author@R`**:
    `devtools::create`でDESCRIPTIONファイルを作る場合`person`関数で埋め込む。少なくとも一人の著者(aut)、保守担当者(cre)を書く。雛形をRStudioで作成すると`Author`と、`Maintainer`に別れている。
  - **`Imports`**: パッケージの依存関係、自動的にインストールされる。
    `devtools::use_package("dplyr")`で自動的にDESCRIPTIONファイルに追記できる。
  - **`Suggests`**: パッケージでは使わないがテストで使う場合等、自動でインストールされない。
  - **`Depends`**: `devtools::check()`で警告が出る場合はここに依存バージョンを書く
  - **`License`**: MITライセンスの場合ファイルを置く必要がある。
  - **`LazyData`**: 外部データを遅延ロードするか否か`library(パッケージ名)`をしてもメモリ上に乗らない。

<!-- end list -->

``` r
# Importsの追記 
devtools::use_package("dplyr")

# Autho@R
person("Shogo", "Konishi", email = "アカウント名@gmail.com", role = c("aut", "cre")) 
```

    ## Package: hello
    ## Type: Package
    ## Title: Exersice of R package development
    ## Version: 0.1.0
    ## Author: Shogo Konishi <shkonishi@gmail.com> 
    ## Maintainer: Shogo Konishi <shkonishi@gmail.com>
    ## Imports: 
    ##     dplyr
    ## Description: Exersice of R package development
    ##     Use four spaces when indenting paragraphs within the Description.
    ## Depends: R (>= 2.10)
    ## License: MIT + file LICENSE
    ## Encoding: UTF-8
    ## LazyData: true
    ## RoxygenNote: 6.1.1

### NAMESPACE

  - 直接編集しない。
  - スクリプトにroxygen形式のコメントを書いておいて`devtools::document()`するとNAMESPACEファイルに追記してくれる。雛形の中に含まれているNAMESPACEファイルは削除しておく。書き方は後述。

<!-- end list -->

``` 

# 対象パッケージから全ての関数をインポート(非推奨)  
import(ggplot2) 
import(dplyr)

# 指定された関数をインポート
importFrom(ggplot2, ggplot)
importFrom(magrittr, %>%)
```

### roxygen2を使ってドキュメント作成

Rスクリプトの中にroxygen形式でコメントを書いてから. **`devtools::document()`**
を作業中のプロジェクトの中で実行すると、ドキュメントファイル`man/*.rd`および`NAMESPACE`ファイルが作られる。
**`roxygen2::roxygenise('.', ..., clean=FALSE)`** でもO.K.

#### roxygen形式のコメント書式

  - **`@description`** スクリプトの説明  
  - **`@usage`** 書式. ドキュメントとスクリプトで引数の順番が違っているとエラー
  - **`@param`** 引数. 一箇所で複数の引数の場合、**`@param x,y ...`**  
  - **`@return`** 関数の出力  
  - **`@examples`** `devtools::check()`で実行される。
  - **`@export`**

<!-- end list -->

``` r
#' Hello, World!　
#' @description Prints 'Hello, world!'. 　
#' @usage hello(n) 　
#' @param n Number of replication 
#' @return Character vector, length of n 　
#' @examples hello(3)　
```

#### roxygen形式のコメント書式(NAMESPACE用)

  - **`@export`** はコード本体の直前に書く
  - **`@import`** で非推奨、なるべく **`@importFrom`** で関数名を指定する。
  - **`@importFrom`** に何も記述しないまま **`devtools::document()`** を実行すると
    ~~`importFrom("",)`ができてしまう。手動で消す必要有。~~ エラーが出る。
  - できるだけスクリプトの中で **`::`** を明示して、依存パッケージの関数を利用するようにする。Checkの時間短縮にもなる.

<!-- end list -->

``` r
#' @import package    
#' @importFrom package function  
#' @importClassesFrom package class 
#' @export  
```

#### `examples`のコードをnot runにする。

  - checkのときに実行されない

<!-- end list -->

``` r
#'@examples
#' \dontrun{
#'  print(x)
#' }
```

``` r
#'@examples 
#' ## Not run:  
#' print(x) 
#' ## End(Not run)
```

### `devtools::check()`を実行

  - Buildペインの`Build & Reload`をクリック
  - オプションをつけて実行できる. RStudioで`Build` -\>
    `ConfigureBuildTools...`を選択してオプションを追加する。　`--as-cran`
    CRANチェックと同様のチェック。 `--no-manual`、PDFマニュアルを作成しない。`--no-vignettes`
    vignetをチェックしない
  - ERROR, WARNING, NOTEが出るので各項目を解消する。
  - いずれも0になったら`Install and Restart`を実行する。?function名を実行してドキュメントを確認
    リモートリポジトリと同期する.

<!-- end list -->

``` r
# documentファイルが作られる。NAMESPACEファイルに記述
devtools::document() 

# RStudioで [Check -> Install and Restart]  
library(hello) 

# ドキュメントを確認する。
?hello 
```

``` 
  ...
  ...　
  
  R CMD check results
  0 errors | 0 warnings | 0 notes
  
```

### LICENSEを決める

  - 自分のパッケージが依存しているパッケージのライセンスを調べる
  - `packageDescription("パッケージ名", fields
    ="タグ名")`でDESCRIPTIONファイルの特定のフィールドを抜き出せる。

<!-- end list -->

``` r
# 自分のパッケージが依存しているライブラリを取得する 
mylibs <- unlist(strsplit(packageDescription("rsko", fields = 'Imports'), ",\n"))

# それぞれのパッケージのDESCRIPTIONファイルのLicenseフィールドを抜き出す。
data.frame(license = sapply(mylibs, function(x)packageDescription(x, fields = 'License')))
```

    ##                                  license
    ## amap                                 GPL
    ## dendextend                 GPL-2 | GPL-3
    ## dplyr                 MIT + file LICENSE
    ## dynamicTreeCut                GPL (>= 2)
    ## ggrepel             GPL-3 | file LICENSE
    ## ggplot2             GPL-2 | file LICENSE
    ## gplots                             GPL-2
    ## grDevices                Part of R 3.5.2
    ## gridExtra                     GPL (>= 2)
    ## magrittr              MIT + file LICENSE
    ## pathview                     GPL (>=3.0)
    ## plyr                  MIT + file LICENSE
    ## readr          GPL (>= 2) | file LICENSE
    ## RColorBrewer          Apache License 2.0
    ## RISmed                        GPL (>= 2)
    ## rskodat               MIT + file LICENSE
    ## stringi                     file LICENSE
    ## tibble                MIT + file LICENSE
    ## tidyr                 MIT + file LICENSE
    ## zoo                        GPL-2 | GPL-3

### README.mdの作成

README.mdは必須ではないが、作ることが推奨されている。
このドキュメントはRStudioを用いてRmakdown形式で書いている。REAMDE.RmdをRStudioから作成する際に`From
Template`を選んで`GitHub
Document(Markdown)`を選択する。**Knit**ボタンを押せばRコードのchunkが実行されてGitHubへの公開に適したマークダウンファイル（.md）に変換してくれる。

``` 
   ---
   title: Rのパッケージを作成する　
   output: github_document　
   ---
```

### github のmdファイルに目次をつける. Table of Contents

``` bash
wget https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc
chmod a+x gh-md-toc
./gh-md-toc ./README.md 
```

## 外部データをパッケージに含める

1.  バイナリデータは、**`usethis::use_data(obj)`** で `data/`
    にエクスポートされる。その際、データのドキュメントを`R/`ディレクトリに置く。
2.  関数に必要なデータは、**`usethis::use_data(obj, internal=T)`** で`R/`にエクスポートされる。
3.  データファイルをパッケージに含めたい場合は `inst/extdata` を自分で作成してその中におく。

### バイナリデータをdataディレクトリ置く場合

  - ~`devtools::use_data(obj, pkg = ".")`で `data/obj.rda`ファイルができている。~
  - 上記のやり方は廃止されるらしい。`usethis::use_data(obj)`で実行する
  - 関数が利用するためのデータを置く場合`usethis::use_data(obj, internal = T)`とする。
    `R/sysdata.rda`ができる。ユーザーからは利用できない。
  - 関数の中で利用するためには`package名:::object名`で使用する
  - データセットのみのパッケージを作成する場合やデータセットをたくさん作る場合は`tools::add_datalist(getwd(),
    force =
    T)`　datalistファイルがdataディレクトリに作成される。巨大なデータセットを含める場合datalistを作っておかないとインストールが遅くなるらしい。

<!-- end list -->

``` r
# データを作成    
pois_mat <- matrix(rpois(10000, 10), nrow = 100)
norm_mat <- matrix(rnorm(10000, 10), nrow = 100)

# エクスポート  
# devtools::use_data(pois_mat, pkg = ".") 
usethis::use_data(pois_mat) # data/pois_mat.rda ができる。  
usethis::use_data(norm_mat, internal = T) # R/sysdata.rdaができる。  

# 関数の中で使う場合  
mat <- hello:::norm_mat
```

### `R/`にバイナリデータのdocumentを作成する。

  - data名に対してファイルを作る。例えば`pois_mat`というdataならば`pois_mat.R`を作成
  - roxygenコメントを以下のように書いて`devtools::document()`を実行。
  - `＠references`リンクの書き方は`\href{リンクアドレス}{リンク名}`のように書く。

<!-- end list -->

``` r
#' @docType data 
#' @usage data(pois_mat)　
#' @format An object of matrix with 100 rows and 100 colmns. 
#' @keywords datasets  
#' @references  
#' \href{https://github.com/shkonishi/hello/tree/master/man}{man}  
#' @examples  
#' data(pois_mat)  
"pois_mat"  
```

### データファイルを`inst/extdata`に置く場合

  - `system.file`を使って読み込む。パスを知らないと読み込めない。
  - パッケージについているサンプルデータを探す場合 `dir(paste0(.libPaths(),
    "/Biostrings/extdata"))`

<!-- end list -->

``` r
dir(paste0(.libPaths(), "/hello/extdata"))
fp <- system.file("extdata/pois.txt", package = "hello")
dat <- read.table(fp)
```

## コードスタイル整形

  - コードスタイルについて過度に拘るべきではない。  
  - RStudioのメニューバーからRStudio -\> Preferences -\> Code -\>
    Diagnosticsでいくつかにcheckを入れれば、リアルタイムでいくつかのコードの校正箇所を指摘してくれる。  
  - RStudioのメニューバーからCode -\> Show
    Diagnosticsを実行するとMarkersに修正箇所が示される。  
  - `lintr::lint_package()`でMarkersペインに、ファイルごとの修正すべき内容と行番号が表示される。修正箇所をダブルクリックでその行にカーソルが移動する。見ながらなおしていくと、行番号と修正箇所が合わなくなるので、末尾の行番号から修正していく。  
  - `formatR`を使う
      - `formatR::tidy_app()`shinyアプリが立ち上がって、そこにコードをコピーしてTidy My
        Codeを実行するとコードが修正される。ggplotの+や,
        magrittrのパイプ処理別の改行を繋げてしまう。
      - `formatR::tidy_file("./R/script.R")` ファイル自体が書き換えられる。
      - `formatR::tidy_source()` クリップボードの内容を書き換えて返す。

<!-- end list -->

``` r
# lintr::lint_package()
# devtools::spell_check()
# formatR::tidy_source()
# formatR::tidy_app()  
```

## コミットメッセージについて

  - いい加減に日付ですましてきたが、最低限変更内容がわかるようにする。
  - RStudio付属のGitクライアントを開いて、Commit
        messageのところに変更箇所がわかるように記述する。
  - 参考
      - [コミットログ/メッセージ例文集100](https://gist.github.com/mono0926/e6ffd032c384ee4c1cef5a2aa4f778d7)
      - [Gitのコミットメッセージの書き方](https://qiita.com/itosho/items/9565c6ad2ffc24c09364)

### 直前のコミットにまとめる`git commit --amend -m "message"`

  - 直前のコミットメッセージを変更するのはRStudioからでも可能。GitペインからCommittを選択して`Amend previous
    commit`

<!-- end list -->

``` bash
git log --oneline #コミットログを確認 
git commit --amend -m "add binary data" # 直前のコミットメッセージを変更する 
```

### 複数のコミットを 1 つにまとめる`git rebase -i`

  - RStudioからシェルを起動
  - コミットしてない変更がある場合rebaseができない
  - まとめるコミットの数を選択する。`HEAD~3`
  - コミットのハッシュ値を指定して、そのコミット以降のコミットをまとめる。
  - viが起動するのでviのコマンドで編集する。
      - `pick`を一括で`fixup`(コミットメッセージの破棄)に変更する場合 `:%s/pick/fixup/gc`
      - `:wq`セーブして終了. `:q`セーブせずに終了
  - RStudioのGitクライアントが起動している状態で`git rebase`するとエラーになる。

<!-- end list -->

``` bash
#コミットログを確認 コミットのハッシュ値とメッセージを確認 
git log --oneline 

# 現在のブランチの先頭から 3 つのコミットを編集 
git rebase -i HEAD~3 

# 指定のコミット以降のコミットを編集 
git rebase -i "ハッシュ値" 

# pickをfixupに置換する 
:%s/pick/fixup/gc
:wq

# 一連の処理を取り消す 
git rebase --abort
```

## 環境

``` r
sessionInfo()
```

    ## R version 3.5.2 (2018-12-20)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS High Sierra 10.13.1
    ## 
    ## Matrix products: default
    ## BLAS: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] ja_JP.UTF-8/ja_JP.UTF-8/ja_JP.UTF-8/C/ja_JP.UTF-8/ja_JP.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] hello_0.1.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.0        knitr_1.21        magrittr_1.5     
    ##  [4] usethis_1.4.0     devtools_2.0.1    pkgload_1.0.2    
    ##  [7] R6_2.4.0          rlang_0.3.1       stringr_1.4.0    
    ## [10] tools_3.5.2       pkgbuild_1.0.2    xfun_0.5         
    ## [13] sessioninfo_1.1.1 cli_1.0.1         withr_2.1.2      
    ## [16] remotes_2.0.2     htmltools_0.3.6   yaml_2.2.0       
    ## [19] assertthat_0.2.0  digest_0.6.18     rprojroot_1.3-2  
    ## [22] crayon_1.3.4      processx_3.2.1    callr_3.1.1      
    ## [25] fs_1.2.6          ps_1.3.0          curl_3.3         
    ## [28] testthat_2.0.1    glue_1.3.0        memoise_1.1.0    
    ## [31] evaluate_0.13     rmarkdown_1.11    stringi_1.3.1    
    ## [34] compiler_3.5.2    desc_1.2.0        backports_1.1.3  
    ## [37] prettyunits_1.0.2
