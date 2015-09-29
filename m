Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35799 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964879AbbI2L22 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Sep 2015 07:28:28 -0400
Received: by wicge5 with SMTP id ge5so145805709wic.0
        for <linux-wpan@vger.kernel.org>; Tue, 29 Sep 2015 04:28:27 -0700 (PDT)
Date: Tue, 29 Sep 2015 13:28:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Linux-Wpan-Next: Regarding usage of fakelb driver
Message-ID: <20150929112815.GA25792@omega>
References: <51C7DE700DAED543997957503C74C84501073F5A@POCITMSEXMB05.LntUniverse.com>
 <20150929104158.GA1672@omega>
 <51C7DE700DAED543997957503C74C84501074016@POCITMSEXMB05.LntUniverse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7DE700DAED543997957503C74C84501074016@POCITMSEXMB05.LntUniverse.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Cc: Vikas Warad <Vikas.Warad@LNTTECHSERVICES.COM>, Madhu Chinthakindi <Madhu.Chinthakindi@LNTTECHSERVICES.COM>, "kantanoop@yahoo.com" <kantanoop@yahoo.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Tue, Sep 29, 2015 at 10:59:52AM +0000, Anoop Kant wrote:
> Dear Alex,
> 
> Thanks for quick response!!
> 
> I will build image using bluetooth-next git and try.
> 
> I believe iwpan and wpan-ping (wpan tools) will already be present in the bluetooth-next-kernel built. Is that correct understanding ?

No, this is part of userspace you need to build it by yourself.

Newest release is 0.5 [0].

It's using autotools as buildsystem so a normal:

./confgure
make
(as root) make install

See [1].

should be enough, we have one dependency to libnl3. See [2], this should
be provided from your distribution which you install. (It's a common
library for networking utilities).

- Alex

[0] http://wpan.cakelab.org/releases/
[1] http://www.gnu.org/software/automake/manual/html_node/Basic-Installation.html#Basic-Installation
[2] http://www.infradead.org/~tgr/libnl (currently the site is down)
