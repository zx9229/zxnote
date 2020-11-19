---
title: VisualStudioCode相关
categories:
  - 软件相关
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-01-13 09:28:06
---
omit
<!--more-->

`Alt+Z`: 切换自动换行。  

* 设置字体  
说明：搜索`fontFamily CSS HTML`可知，它的值是一个优先表，浏览器会使用它可识别的第一个值。  
旧：`"editor.fontFamily": "Consolas, 'Courier New', monospace"`，  
新：`"editor.fontFamily": "'Courier New', monospace"`，  
旧：`"editor.fontSize": 14`，  
新：`"editor.fontSize": 18`，  
旧：`"editor.renderWhitespace": "selection"`，  
新：`"editor.renderWhitespace": "all"`，  

* 等宽字体  
[解决VS code中英文不等宽无法对齐问题（不完全） - 知乎](https://zhuanlan.zhihu.com/p/110945562)  
[Monospacing broken by Chinese character · Issue #14589 · microsoft/vscode · GitHub](https://github.com/Microsoft/vscode/issues/14589)  
[VSCode 设置中英混合等宽字体 - 简书](https://www.jianshu.com/p/46fdb5d275a6)  
[VSCode 等宽字体之坑 - 神代綺凜の随波逐流](https://moe.best/gotagota/vscode-monospaced.html)  
[Releases · be5invis/Sarasa-Gothic · GitHub](https://github.com/be5invis/Sarasa-Gothic/releases)  
有一个VSCode可用的等宽字体是`Sarasa Mono SC`(`等距更纱黑体 SC`)，可能不太美观。  
如果要`配置要为[markdown]语言替代的设置`，可以按如下方式配置：  
```json
{
    "editor.fontSize": 18,
    "editor.renderWhitespace": "all",
    "[markdown]": {
        "editor.fontFamily": "'Sarasa Mono SC', Consolas, 'Courier New', monospace",
        "editor.wordWrap": "on",
        "editor.quickSuggestions": false,
    },
}
```

* 一些插件  
[Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)  
[REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)  
