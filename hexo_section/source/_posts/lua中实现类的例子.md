---
title: lua中实现类的例子
categories:
  - lua
toc: false
date: 2018-09-19 17:12:32
tags:
---
摘要暂略。
<!-- more -->

文章[Lua中实现类的原理](https://wuzhiwei.net/lua_make_class/)讲的非常好。我在此保存这个链接，同时写下了这篇文章的例子。
```lua
Person = {name="NO_NAME"}

Person.__index = Person  -- 请查看[如何查找表中的元素？]

function Person:talk(words)
    print(self.name .. " talk: " .. words)
end

function Person:create(name)
    local p = {}
    setmetatable(p, Person)
    p.name = name
    return p
end

Person.talk(Person, "test_1")
Person:talk(        "test_2")

local pa = Person:create("PA")
pa:talk("I'm personA")

local pb = Person:create("PB")
pb:talk("I'm personB")
```
