Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36013 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbJLVA6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 12 Oct 2015 17:00:58 -0400
Received: by wicgb1 with SMTP id gb1so163741799wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 12 Oct 2015 14:00:57 -0700 (PDT)
Date: Mon, 12 Oct 2015 23:00:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Linux-Bluetoothnext: Ping6 execution for virtual Phy : System
 freezes
Message-ID: <20151012210044.GA2962@omega>
References: <20151001102815.GA2034@omega>
 <51C7DE700DAED543997957503C74C84501074D8A@POCITMSEXMB05.LntUniverse.com>
 <20151001120802.GA25840@omega>
 <51C7DE700DAED543997957503C74C84501074DF2@POCITMSEXMB05.LntUniverse.com>
 <20151001124628.GA28241@omega>
 <51C7DE700DAED543997957503C74C84501074E42@POCITMSEXMB05.LntUniverse.com>
 <20151001142513.GA19393@omega>
 <51C7DE700DAED543997957503C74C84501074FF8@POCITMSEXMB05.LntUniverse.com>
 <20151002072453.GB565@omega>
 <51C7DE700DAED543997957503C74C84501077E08@POCITMSEXMB05.LntUniverse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7DE700DAED543997957503C74C84501077E08@POCITMSEXMB05.LntUniverse.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Mon, Oct 12, 2015 at 10:47:32AM +0000, Anoop Kant wrote:
> Thanks Alex.
> With stable version, I did not face any issue in configuration of 6lowpan interfaces for fake devices when used linux-stable .
>  Ping6 also worked fine between virtual devices.
> 
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/
> 

Okay, then I think there is some issue with belongs to your architecture
(x86?) which is currently in bluetooth-next (or update again
bluetooth-next and test it again, there was some rebases to net-next
the last days).

Or you checkout some earlier commit inside bluetooth-next and look if you
have issues, if it seems to work -> then run git bisect [0].

Running git bisect would be great to report some commit which breaks
something.
I suppose it's architecture related because I don't have this issue on
my setup.

Maybe it's fine for you that you use the stable-tree for your virtual
phy testing, but for the greatest features and sending patch you will
need run/test/base patches on bluetooth-next.

- Alex

[0] http://webchick.net/node/99
