Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35421 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbEROMQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 10:12:16 -0400
Received: by wicmx19 with SMTP id mx19so81064284wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 18 May 2015 07:12:15 -0700 (PDT)
Date: Mon, 18 May 2015 16:12:12 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Unstrung-hackers] latest kernel
Message-ID: <20150518141209.GB749@omega>
References: <5551D495.7030106@xsilon.com>
 <20150512105934.GE733@omega>
 <5559ED12.4030209@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5559ED12.4030209@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: unstrung-hackers@lists.sandelman.ca, linux-wpan@vger.kernel.org

On Mon, May 18, 2015 at 02:45:54PM +0100, Simon Vincent wrote:
> I have noticed that ARPHRD_6LOWPAN is not defined in glibc yet. Has a patch
> been sent?
> http://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/net/if_arp.h;h=5300dcee0225d12d0bbd0c86d3630966ec19f936;hb=HEAD
> 

You need to update your kernel-headers. Usually you can install
kernelheaders with "make headers_install" in your kernel source tree.

When you doing cross compile then all things come more complicated,
because you need to define in the buildsystem where the kernel headers
location is. (Usually "/usr/include/linux" is used. This is where make
headers_install install all headers from kernel src tree "include/uapi").

Then the if_arp header at [0] is used (that's the header from linux kernel),
which is up-to-date then. Your link above in glibc linux if_arp is I suppose
a fallback handling when kernel headers are not found and yes they seems to
be old but I also don't think that you these headers have some 1:1 mapping,
because the comment of "Based on the 4.4BSD and Linux version of this file".
You can try to update it, but your real issue is an old version of your
kernel headers.

For now if you are sure you have a kernel running which supports this
ARPHRD_6LOWPAN, then you can add a:

#ifndef ARPHRD_6LOWPAN
#define ARPHRD_6LOWPAN	825
#endif

This should work, but is a little hack.

- Alex

[0] http://lxr.free-electrons.com/source/include/uapi/linux/if_arp.h#L97
