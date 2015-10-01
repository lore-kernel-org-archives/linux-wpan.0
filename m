Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37130 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbbJAOZ0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Oct 2015 10:25:26 -0400
Received: by wicfx3 with SMTP id fx3so31155627wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 01 Oct 2015 07:25:25 -0700 (PDT)
Date: Thu, 1 Oct 2015 16:25:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Linux-Bluetoothnext: Ping6 execution for virtual Phy : System
 freezes
Message-ID: <20151001142513.GA19393@omega>
References: <51C7DE700DAED543997957503C74C84501074D1F@POCITMSEXMB05.LntUniverse.com>
 <20151001102815.GA2034@omega>
 <51C7DE700DAED543997957503C74C84501074D8A@POCITMSEXMB05.LntUniverse.com>
 <20151001120802.GA25840@omega>
 <51C7DE700DAED543997957503C74C84501074DF2@POCITMSEXMB05.LntUniverse.com>
 <20151001124628.GA28241@omega>
 <51C7DE700DAED543997957503C74C84501074E42@POCITMSEXMB05.LntUniverse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7DE700DAED543997957503C74C84501074E42@POCITMSEXMB05.LntUniverse.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Cc: "kantanoop@yahoo.com" <kantanoop@yahoo.com>, linux-wpan@vger.kernel.org

On Thu, Oct 01, 2015 at 12:55:09PM +0000, Anoop Kant wrote:
> Dear Alex,
> 
> Here is the uname -a output. I have created this image yesterday.
> 
> HP-ProBook-4420s:~$ uname -a
> HP-ProBook-4420s 4.2.0Bluetooth_next+ #1 SMP Wed Sep 30 11:45:30 IST 2015 x86_64 x86_64 x86_64 GNU/Linux
> HP-ProBook-4420s:~$
> 

Then I would test current stable which is kernel version 4.2.2.

If this works, then you need to bisect the issue by using git bisect,
see [0].

- Alex

[0] http://webchick.net/node/99
