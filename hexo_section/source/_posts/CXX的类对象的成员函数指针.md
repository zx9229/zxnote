---
title: CXX的类对象的成员函数指针
categories:
  - C/CXX
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-12-04 15:47:44
---
omit
<!--more-->

```C++
class Q_WIDGETS_EXPORT QComboBox : public QWidget
{
    Q_OBJECT
    //...(略)...
Q_SIGNALS:
    //...(略)...
    void activated(int index);
    void activated(const QString &);
    //...(略)...
};

void test()
{
    if (false)
    {
        using FunType = void(QComboBox::*)(int index);
        FunType pFunc = &QComboBox::activated;
        QObject::connect(comboBox, pFunc, [](int index) { QString::number(index); });
    }
    else if (false)
    {
        void(QComboBox::*pFunc)(int index) = &QComboBox::activated;
        QObject::connect(comboBox, pFunc, [](int index) { QString::number(index); });
    }
    else if (false)
    {
        QObject::connect(comboBox, (void(QComboBox::*)(int))(&QComboBox::activated), [](int index) { QString::number(index); });
    }
}
```
