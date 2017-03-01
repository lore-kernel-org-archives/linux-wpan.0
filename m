Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:43506
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751774AbdCARVS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Mar 2017 12:21:18 -0500
Subject: Re: iwpaninfo library for OpenWRT/LEDE
References: <CAJuUDwuHdbsfb5mFoUHTqQWRQPMtoVKjoLW_567D0WMpFk+yww@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <67c15ef5-02a3-ee03-1062-bd80467c6f2b@osg.samsung.com>
Date: Wed, 1 Mar 2017 17:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwuHdbsfb5mFoUHTqQWRQPMtoVKjoLW_567D0WMpFk+yww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello.

Sorry for the late reply. I had it tagged here but kind of forgot about it.

On 01/30/2017 01:45 PM, Xue Liu wrote:
> Hello,
>
> Recently I created a new project called iwpaninfo for OpenWRT/LEDE. It
> is a "clone" project from iwinfo and copied some code from wpan-tools.

 From briefly looking over it this is basically a small library to 
access nl_ieee802154 netlink information without dealing with netlink. 
Exposing this interface as C and lua API. Correct so far? Anything I missed?

The primary goal is to use this inside OpenWRT/LEDE with the LuCI web 
configuration interface?

> Like iwinfo, it provides C and Lua APIs. So later I hope this package
> can be merged into OpenWRT/LEDE package repo.

The package only or also the git repo hosted by them? I could also offer 
you putting it into the linux-wpan project on github if you plan to make 
this a bit more generic (usable outside of OpenWRT/LEDE). Or you keep it 
on your own space. Whatever you prefer. :)

> This project is still in developing. Issues and pull-requests are appreciate.

Great that you tackled this and hopefully this brings 802.15.4 and later 
6lowpan support forward in OpenWRT/LEDE. Keep us posted on the progress 
it makes.

I wanted to give it a go here locally but it seems to depend on OpenWRT 
specific things to even compile:

stefan@work iwpaninfo (master) $ make
rm -f *.o libiwpaninfo.so iwpaninfo.so iwpaninfo
cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_utils.o 
iwpaninfo_utils.c
cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_lib.o 
iwpaninfo_lib.c
cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_lua.o 
iwpaninfo_lua.c
cc  -std=gnu99 -fstrict-aliasing -Iinclude  -c -o iwpaninfo_cli.o 
iwpaninfo_cli.c
cc -luci -lubox  -shared -o libiwpaninfo.so iwpaninfo_utils.o 
iwpaninfo_lib.o
/usr/bin/ld: cannot find -luci
/usr/bin/ld: cannot find -lubox
/usr/bin/ld: iwpaninfo_utils.o: relocation R_X86_64_32S against 
`.rodata' can not be used when making a shared object; recompile with -fPIC
iwpaninfo_utils.o: error adding symbols: Bad value
collect2: error: ld returned 1 exit status
Makefile:28: recipe for target 'compile' failed
make: *** [compile] Error 1

Thanks for working on this!

regards
Stefan Schmidt
