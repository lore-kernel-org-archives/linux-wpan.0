Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37121 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcIGIlp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Sep 2016 04:41:45 -0400
Received: by mail-it0-f43.google.com with SMTP id e124so9683595ith.0
        for <linux-wpan@vger.kernel.org>; Wed, 07 Sep 2016 01:41:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJoxMwXTdnCMbKMefMhO43xV8FioX3eteYHt48Uex+7WvHDMfQ@mail.gmail.com>
References: <CAJoxMwXTdnCMbKMefMhO43xV8FioX3eteYHt48Uex+7WvHDMfQ@mail.gmail.com>
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 7 Sep 2016 10:41:43 +0200
Message-ID: <CAB_54W4DP5+Dq9z52CqgXs5efJzvrYRAX1wSWVqnsD4uJYFQVw@mail.gmail.com>
Subject: Re: linux-wpan - 802.15.4
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Pablo Catalina <pablo.catalina@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2016-09-07 9:05 GMT+02:00 Pablo Catalina <pablo.catalina@gmail.com>:
> Hi,
>
> First: thanks for your contribution to opensource with your code!!!
>
> I'm going to perform an analysis of 802.15.4 stack (and ISA100.11a), and I
> want to know if the current support of the linux drivers and tools for the
> 802.15.4 implements the encryption supported (AES). Just to know if it is
> possible to join into a network that uses AES to encrypt the data.
>

the _data_, yes. See [0]. We have a software side solution for 802.15.4
security.

For more question subscribe linux-wpan. [1]

- Alex

[0] https://github.com/linux-wpan/wpan-tools/wiki/Guide:-Contiki-%E2%86%94-Linux,-with-llsec
[1] http://vger.kernel.org/vger-lists.html#linux-wpan
