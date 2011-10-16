
# RubyGems – 管理你的紅寶石

[RubyGems][] 是 Ruby 社群最常使用的套件管理系統，如同 Perl 的 CPAN 或 
Python 的 EasyInstall 或 pip，使用者只要很簡單地執行 `gem install rake` 
就可以把名叫 rake 的一套 Ruby 套件，從網路上安裝到電腦裡面。

如同一般的套件管理系統，RubyGems 也有版本與相依性管理，要散佈自己所製作的
套件（以下將以 gems 稱呼）給其他人下載也是很容易，幾個指令就可以完成了。

RubyGems 大致可以分為兩個部份。一個是 gem 命令，另一個則是在 runtime 中
管理可用的 gems 與其版本。在這篇淺談中，將不會介紹所有的功能與選項，
所有的功能細節請自行參閱 `gem help`。

[RubyGems]: https://rubygems.org

## 安裝

在 Ruby 1.9 之前，RubyGems 需要額外安裝，因為它不是官方的套件。而在 
Ruby 1.9 之後，由於已經被收錄至 Ruby 標準發行版中，就不需額外安裝了。
差別在於版本可能比較舊。不過沒關係，因為 RubyGems 本身也可以由 RubyGems 
散佈，因此只要先取得一份可以執行的 RubyGems，接著要升級甚至降級都是很容易的。

在 Mac OS X 中，雖然 Ruby 的版本是 1.8.7，但是 RubyGems 也已經預先裝好了。
而在 Linux 上的話，使用該 Linux 發行版的套件管理系統即可。如果是 Ruby 1.9 
不需要特別安裝 RubyGems，而如果是 Ruby 1.8 的話，通常 Linux 上的套件
管理系統也有提供 RubyGems。真的沒有的話，可以下載 [tarball][download-rubygems]，
解開後跑 `ruby setup.rb` 就可以裝起來了。至於 Windows 則可直接使用 
[RubyInstaller][download-rubyinstaller]，不管是 1.9 或是 1.8，RubyGems 
都已經被包在裡面了。

[download-rubygems]: https://rubygems.org/pages/download
[download-rubyinstaller]: http://rubyinstaller.org/downloads

## 升級與降級

取得了可執行的 RubyGems 後，該如何升級，甚至降級呢？一般而言，只要執行：

    gem update --system

就可以自動升到最新的 RubyGems。不過不知道為什麼，有時候會有點問題，
沒辦法直接裝到好。這時候則需要再執行一次：

    update_rubygems

就可以裝好了。由於 RubyGems 本身也可由 RubyGems 來散佈，因此要降級也是
非常容易的。當然啦，通常我們並不需要降級，不過如果真的有點問題，像是某些
版本的 Rails 會用到 RubyGems 內部的東西，因此在某些版本下可能會有問題。
這種時候如果新版不適用，可能就必須降級。

降級的方法也很簡單，跟升級差不多。假設我們現在想要安裝 1.7.2，則先透過 
RubyGems 本身安裝 RubyGems 1.7.2：

    gem install -v 1.7.2 rubygems-update

然後用 1.7.2 的 rubygems-update 來執行：

    update_rubygems _1.7.2_

這邊的 `_1.7.2_` 是 RubyGems 的用來呼叫某個特定版本的 gem 的方式。例如假設
我們電腦裡同時有 Rails 3.1.1 和 Rails 2.3.14，我們該怎麼使用 2.3.14 版本的 
Rails？正是 `rails _2.3.14_` 接著後面接原本的引數。所有的 gem 都可以透過這種
方式選擇版本。其實我們在執行 `gem update --system` 時，他內部就是先執行 
`gem install rubygems-update` 安裝最新版，接著自動跑 
`update_rubygems`。因此也可以用這種方式升級 RubyGems。

## gem 命令

安裝 RubyGems 後可以使用 `gem` 命令。而 `gem` 本身也包含其他的命令，
例如最常用的 `gem install`，`gem update` 和 `gem list`。其中的 
install，update 和 list 就是 gem 本身的命令。每個 gem 命令也有各自
不同的用法。詳細用法，可以透過 `gem help` 這個命令去查詢，例如 
`gem help install` 或是 `gem help update`。它也可以拿來查詢自己的
用法： `gem help help`。也可以列出所有的命令： `gem help commands`。

每個不同的 gem 命令都可以接受各自不同的引數。例如平常我們使用 `gem list` 
時，他會顯示所有電腦上安裝過的 gems。但如果我們想要看遠端的 gems，則需要用 
`-r` 引數，表示我們只關心遠端（remote）的 gems，而非本地（local）的 gems。
例如 `gem list -r rake` 可以列出 [rubygems.org][RubyGems] 上所有 
rake 開頭的 gems。在新版本的 RubyGems 裡面，由於效率考量，只會印出最新的
版本。如果需要察看之前的版本，例如某個新版的 gem 有問題，想降級卻不知道應該
降到哪個版本時，就需要察看所有的版本。執行 `gem list -ra rake` 即可。
其中 `-r` 的意思就是前述的 remote，而 `-a` 則是 all 的意思。

如果覺得其實我們只關心 rake，並不關心其他 rake 開頭的 gem，那我們可以
用 regular expression。使用 `gem list -ra '^rake$'` 即可，這樣就
只會列出 rake 而非其他雜七雜八 rake 開頭的 gems。

但不是所有的 `gem` 命令都支援 regular expression。比方說如果我們升級了 
rails，然後想把舊版的 rails 刪掉。這不是只要跑 `gem cleanup rails` 
就可以解決的，因為實際上 rails 比較接近一個 metagem，意思就是這個 gem 
本身其實沒什麼東西，主要的東西反而是在這個 gem 的 dependency 上，
也就是 activerecord，activesupport，actionpack，actionmailer 等等。
假設我現在想刪除 rails 3.0.5，這時我會跑這個來把所有的 dependency 全部清除：

    gem list '^active|^action|^rails' | sed -E 's/\(.+\)//' | xargs gem uninstall -v 3.0.5

除此之外，所有的 `gem` 命令都不一定要把全名寫出來，可以只寫字首即可。例如 
`gem install rake` 的意思等同於 `gem i rake`，包括 help 裡也可以單用字首： 
`gem h i` 就可以查詢 install 的用法。但如果是 `gem update rake` 的話，
則不能縮寫成 `gem u rake`，因為 u 開頭的命令不只一個。但如果是 `gem up rake` 
的話就沒問題了。

## 版本管理

除了指定特定的版本，如前文提到的 `gem install -v 1.7.2 rubygems-update` 和 
`gem uninstall -v 3.0.5 rails` 外，也可以指定一個範圍的版本。比方說如果需要
安裝「最新的」 Rails 2 的話，可以執行：

    gem install -v '<3' rails

這裡 `<3` 的意思是任何版本小於 3 的版本。當然有小於運算子，也就會有大於運算子，
也同樣有小於等於運算子： `<=` 和大於等於運算子： `<=`。除此之外，還有一個比較
不尋常，可能只有 RubyGems 在用的 `~>` 運算子。目前這運算子沒有一個正式的名稱，
應該用什麼名字還在[討論當中][appr-op]。此運算子的意思是不在乎最小位數的數字。
例如寫作 `~>3.0` 表示任何 3.x 都可以接受。因此實際上也等價於 `~>3.5`。用大於
小於來表示的話，則是 *3 <= the version < 4*。

使用這樣的運算子有兩個理由。一個是比起寫一個範圍要來得簡單，另一個是明確表示
自己想要的版本究竟是什麼，但是差一點點無所謂！也因此有人提議這個運算子應該叫 
approximate operator, 也就是近似運算子。

另一方面，除了用 `gem` 命令管理 gems 以外，另一點很重要的是如何在 ruby runtime 
裡選擇各種 gems 的版本了。這裡同樣可以使用各種版本的運算子。像是：

    gem 'rake', '~>0.8.7'
    require 'rake'

在第二行的 `require 'rake'`，會根據上次指定的版本限制，也就是第一行來選擇應該
讀入的 rake 版本。另外也可以用等於或是完全不寫運算子：

    gem 'rake', '=0.9.2' # 等價於下行：
    gem 'rake',  '0.9.2'

不過由於 Rails 的版本控制有點混亂且複雜，單這樣寫往往還會有其他版本問題。
也因此他們特地開發了 [Bundler][] 來協助 Rails 3 管理這一團混亂。由於這
超出本篇範圍，這裡就不多討論。

[appr-op]: https://github.com/rubygems/rubygems/pull/124
[Bundler]: https://github.com/carlhuda/bundler

## ~/.gemrc

就像 vim 有 ~/.vimrc，RubyGems 也有 ~/.gemrc，可以調整一些執行 gem 命令時的
預設行為。一個常見的用法是在裡面加一行關閉 rdoc 和 ri：

    gem: --no-rdoc --no-ri

因為安裝 gems，如果還要產生 rdoc 和 ri，其實是很花時間的一件事。而大部份的人，
恐怕不會在自己的電腦上面看 rdoc 甚至 ri，而是打開瀏覽器直接搜尋網路。有人建議
乾脆把這兩個選項設成預設的，不過被拒絕了。原因是，還是讓新手可以在自己電腦上
查詢文件吧！真的不想要的人再關掉就好了。

而我個人的 ~/.gemrc 還多設了兩個選項。裡面是這一行：

    gem: --user --env-shebang --no-rdoc --no-ri

其中第一個 `--user` 的意思是優先使用屬於使用者個人的 gems，而非系統的。
也因此，我在執行 `gem install` 時是不需要 `sudo`，因為 gems 是安裝至 
~/.gem 底下，而非系統的路徑。我個人比較喜歡用這種方式管理我安裝的 gems，
這樣就不會受到系統的影響，自己要修改 gems 來除錯時，也不會影響到其他人。

第二個 `--env-shebang` 的意思則是，比方說 rake 這個 gem 有個 `rake` 的
命令，這個程式本身是一個 Ruby 程式，因此也會有個 shebang。預設的行為下，
這 shebang 會指向當時所使用的 Ruby 的完整路徑。這個問題是，Mac 的 
[Homebrew][] 在每次更新 Ruby 時，完整路徑都會改變，因為路徑本身是含有
版本資訊的。我不希望每次更新 Ruby，我就要重新更新 shebang，不如就直接用 
`#!/usr/bin/env ruby` 吧！

除此之外，還可以設非常多的設定。一些比較針對特定命令的，可以看特定命令的 
help。比較無關某個命令的，則可以看 `gem help environment`。

[Homebrew]: https://github.com/mxcl/homebrew

<!--
## 架設自己的 RubyGems 儲藏室

原本所有的 RubyGems 套件，也就是 gems 都是放在 [RubyForge][]。不過 RubyForge 
後來的運作狀況不是很好，使用者太多，速度變得很慢。再加上使用上不是很方便，
步驟很多也不容易記得。後來 [qrush][] 因此用 Rails 開發了 GemCutter，目的是
取代 RubyForge 許許多多功能中的其中一個，也就是放置儲存 gems 的功能。同時，
它也是放置在 Github 的開源專案。

後來 GemCutter 非常成功，不只把所有原本放在 RubyForge 的 gems 都複製到 
GemCutter，原開發者也可以輕易取得自己的 gems 散佈權。最終所有的東西就全部
合併進 RubyGems，同時正式把預設的伺服器從 RubyForge.org 改到 RubyGems.org。
整個轉換過程非常地順利，沒有在開發自己的 gems 的人，可能甚至不會注意到
改變，也不知道曾經存在過 GemCutter，只知道速度變快了。

也因為整個計畫都是開源的，RubyGems 本身也一直都支援 `gem source` 來管理所有的
伺服器位置。因此任何人都可以架設自己的 RubyGems.org，在上面放私有不公開的
gems，只允許自己的機器去存取。或許也可以用這種方式來佈署自己的私有軟體吧。

詳細的架設方式，請參考 [RubyGems.org 的源碼][rubygems-source]。

[RubyForge]: http://rubyforge.org/
[qrush]: https://github.com/qrush
[rubygems-source]: https://github.com/rubygems/rubygems.org
-->

## 簡單易用下的複雜性

雖然個人沒用過太多套件管理系統，但 RubyGems 相較於其他個人用過同性質的軟體，
可以說是最方便簡單，且功能強大的之一。不過世界上當然沒有可以滿足一切的軟體。 
RubyGems 付出的代價是極為複雜的內部運作，使得執行效率變得不甚理想。

如果在執行每個 Ruby 程式之前，先讀入 RubyGems，例如在程式的最前面寫上 
`require 'rubygems'`，則程式的啟動效能會讓很多人無法接受。因此很多人發明了
其他各種取代 RubyGems 的軟體。例如 [rip][] 和 [coral][] 等等。他們做的事情
很簡單，就是僅僅調整 `$LOAD_PATH` 而非像 RubyGems 還會處理版本相依的問體。

Ruby 1.9 在把 RubyGems 納入核心時，甚至寫了一個叫 *gem_prelude* 的東西。
可以把這東西想像成一種輕便的 RubyGems。這樣做的理由是，很多 Ruby 核心的
開發者，並不願意付出啟動 RubyGems 所需要付出的運算成本。

不幸的是，正因為 *gem_prelude* 不是完整的 RubyGems 實作，他並不會計算複雜的
版本相依問題，因此在某些特定的情況下，會錯誤讀到非指定版本的 gems。如果我們
只用最新的 gems，或是電腦裡只安裝需要用到的 gems，則不會有這個問題。但如果同時
安裝了許多版本，又指定了某些特定版本，*gem_prelude* 就有可能忽略到一些細節。

這個問題對於 Rails 又特別嚴重，因為 Rails 常常會使用到各種套件的底層，
使得 Rails 對於套件的版本相當地敏感，常常版本只差一點點就會有問題了。
在 ruby-core mailing list 裡討論了非常久，一方認為正確性比較重要，而另一方
則認為啟動速度比較重要。後來 RubyGems 經過幾次瘦身和最佳化，總算啟動得
夠快了，核心開發者才同意拿掉 *gem_prelude*。因此現在已經不會有這個問題了。

[rip]: https://github.com/defunkt/rip
[coral]: https://github.com/mislav/coral

<!--
## 鑄造你的紅寶石
-->

## 展望

 std gem
