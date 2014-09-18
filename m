Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:47711 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbaIROTU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 10:19:20 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so986761wes.30
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 07:19:19 -0700 (PDT)
Date: Thu, 18 Sep 2014 16:19:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918141911.GA9262@omega>
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de>
 <20140918083259.GA3774@omega>
 <541A99D4.8080509@xsilon.com>
 <20140918084515.GB3774@omega>
 <20140918085433.GC3774@omega>
 <541A9FD3.2030104@xsilon.com>
 <20140918094401.GB4350@omega>
 <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541AE5E9.3000407@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Thu, Sep 18, 2014 at 03:02:17PM +0100, Simon Vincent wrote:
> I have created a small test program that shows this problem. It looks like a
> race condition as sometimes the addresses are not corrupt.
> 

Mhh maybe some used after freed and then we copy somewhere garbage sometimes.
Don't know right now.

> It looks like if the RAW socket gets the packet before the packet hits the
> 6lowpan layer the addresses are fine. If the packet hits the 6lowpan layer
> before the RAW socket gets the packet then the addresses are corrupt.
> 
> The test program can be found here.
> https://github.com/xsilon/sockdebug
> 
> I will continue debugging!
> 
ok, good luck.

- Alex
