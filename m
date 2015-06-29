Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35623 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbF2JNu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 05:13:50 -0400
Received: by pdbci14 with SMTP id ci14so113510439pdb.2
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 02:13:49 -0700 (PDT)
Message-ID: <55910C2F.3070601@gmail.com>
Date: Mon, 29 Jun 2015 14:43:19 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: ping6 doesn't use at86rf230 driver
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com> <20150625171557.GB3653@omega> <20150625173032.GC3653@omega> <CAPpUg6PSO41hy8BkAkzZFJRsQWOkjA2wXv5gjF1NdC0F0hBLsQ@mail.gmail.com> <CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com> <20150626080338.GB959@omega> <CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com> <CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com> <20150629080937.GA1674@omega>
In-Reply-To: <20150629080937.GA1674@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On 06/29/2015 01:39 PM, Alexander Aring wrote:
>> Alexander, which version of Linux bluetooth-next tree is based on?
> 4.1.0-rc4-01278-gfbb12f9-dirty
>
> this is currently in my development branch. Alternative you can check
> the Makefile of linux-kernel [0].
>
> VERSION = 4
> PATCHLEVEL = 1
> SUBLEVEL = 0
> EXTRAVERSION = -rc4
> NAME = Hurr durr I'ma sheep
>
>
>
> I really have no idea why you don't have a wpan interface by default.

May be the wpan interface is down  :-).

can you please check with: *ifconfig -a*

> You can delete interfaces from nl802154, but then openwrt need to speak
> to this netlink interface and I don't believe that it does that. :-)

Speaking to the netlink interface in OpenWRT is same as in case of bare
Linux kernel compiled for specific target. There is no difference.
So we can use the wpan-tools [1] to speak to the netlink interface.

[1]: http://git.openwrt.org/?p=openwrt.git;a=blob;f=package/network/utils/wpan-tools/Makefile;h=87a5fb1461121407f685e960b64315661aacc9bf;hb=HEAD

-- 
Varka Bhadram.

