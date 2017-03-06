Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38534 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdCFORN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Mar 2017 09:17:13 -0500
Received: by mail-it0-f51.google.com with SMTP id m27so50624821iti.1
        for <linux-wpan@vger.kernel.org>; Mon, 06 Mar 2017 06:17:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <67c15ef5-02a3-ee03-1062-bd80467c6f2b@osg.samsung.com>
References: <CAJuUDwuHdbsfb5mFoUHTqQWRQPMtoVKjoLW_567D0WMpFk+yww@mail.gmail.com>
 <67c15ef5-02a3-ee03-1062-bd80467c6f2b@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Mon, 6 Mar 2017 15:17:11 +0100
Message-ID: <CAJuUDwu_Uxm=uE2kB+_frekH0FgVh23DerQHpCaO3fEej-dh_w@mail.gmail.com>
Subject: Re: iwpaninfo library for OpenWRT/LEDE
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hi,

2017-03-01 17:56 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
> Sorry for the late reply. I had it tagged here but kind of forgot about it.

No problem :)
>
> On 01/30/2017 01:45 PM, Xue Liu wrote:
>>
>> Hello,
>>
>> Recently I created a new project called iwpaninfo for OpenWRT/LEDE. It
>> is a "clone" project from iwinfo and copied some code from wpan-tools.
>
>
> From briefly looking over it this is basically a small library to access
> nl_ieee802154 netlink information without dealing with netlink. Exposing
> this interface as C and lua API. Correct so far? Anything I missed?
>

Yes. correct.

> The primary goal is to use this inside OpenWRT/LEDE with the LuCI web
> configuration interface?
>

Yes. It is my plan.

>> Like iwinfo, it provides C and Lua APIs. So later I hope this package
>> can be merged into OpenWRT/LEDE package repo.
>
>
> The package only or also the git repo hosted by them? I could also offer you
> putting it into the linux-wpan project on github if you plan to make this a
> bit more generic (usable outside of OpenWRT/LEDE). Or you keep it on your
> own space. Whatever you prefer. :)

The package is now hosted by my Github. I think keep it there is OK.

>
>> This project is still in developing. Issues and pull-requests are
>> appreciate.
>
>
> Great that you tackled this and hopefully this brings 802.15.4 and later
> 6lowpan support forward in OpenWRT/LEDE. Keep us posted on the progress it
> makes.
>
> I wanted to give it a go here locally but it seems to depend on OpenWRT
> specific things to even compile:
>
> stefan@work iwpaninfo (master) $ make
> rm -f *.o libiwpaninfo.so iwpaninfo.so iwpaninfo
> cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_utils.o
> iwpaninfo_utils.c
> cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_lib.o
> iwpaninfo_lib.c
> cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_lua.o
> iwpaninfo_lua.c
> cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_cli.o
> iwpaninfo_cli.c
> cc -luci -lubox  -shared -o libiwpaninfo.so iwpaninfo_utils.o
> iwpaninfo_lib.o
> /usr/bin/ld: cannot find -luci
> /usr/bin/ld: cannot find -lubox
> /usr/bin/ld: iwpaninfo_utils.o: relocation R_X86_64_32S against `.rodata'
> can not be used when making a shared object; recompile with -fPIC
> iwpaninfo_utils.o: error adding symbols: Bad value
> collect2: error: ld returned 1 exit status
> Makefile:28: recipe for target 'compile' failed
> make: *** [compile] Error 1
>
> Thanks for working on this!

This package needs uci and libubox package and should be compiled from
OpenWRT /LEDE. A easy way to test is using vm and fakelb from
OpenWRT/LEDE.

>
> regards
> Stefan Schmidt
