Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33207 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbF2IJs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 04:09:48 -0400
Received: by wiwl6 with SMTP id l6so91662534wiw.0
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 01:09:47 -0700 (PDT)
Date: Mon, 29 Jun 2015 10:09:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150629080937.GA1674@omega>
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
 <20150625171557.GB3653@omega>
 <20150625173032.GC3653@omega>
 <CAPpUg6PSO41hy8BkAkzZFJRsQWOkjA2wXv5gjF1NdC0F0hBLsQ@mail.gmail.com>
 <CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com>
 <20150626080338.GB959@omega>
 <CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
 <CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

> 
> Alexander, which version of Linux bluetooth-next tree is based on?

4.1.0-rc4-01278-gfbb12f9-dirty

this is currently in my development branch. Alternative you can check
the Makefile of linux-kernel [0].

VERSION = 4
PATCHLEVEL = 1
SUBLEVEL = 0
EXTRAVERSION = -rc4
NAME = Hurr durr I'ma sheep



I really have no idea why you don't have a wpan interface by default.
You can delete interfaces from nl802154, but then openwrt need to speak
to this netlink interface and I don't believe that it does that. :-)

Also I know users which use 3.9.x 4.0.x successfully, but it's not
recommended.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/Makefile#n1
