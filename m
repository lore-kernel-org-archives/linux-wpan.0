Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33343 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbbELIjV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 04:39:21 -0400
Received: by wgin8 with SMTP id n8so340202wgi.0
        for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 01:39:20 -0700 (PDT)
Date: Tue, 12 May 2015 10:39:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
Message-ID: <20150512083917.GC733@omega>
References: <554E1C92.7040306@sssup.it>
 <20150509164227.GA694@omega>
 <5550DC2D.5060909@sssup.it>
 <20150511175141.GA7965@omega>
 <5551BAB9.9000101@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5551BAB9.9000101@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

On Tue, May 12, 2015 at 10:32:57AM +0200, Matteo Petracca wrote:
> I've applied your patch properly.
> 
> By using your example this is what I have with kernel 4.0.2 for
> beagleboneblack
> 
> [   44.362497] NET: Registered protocol family 36
> [   44.369646] RTNL: assertion failed at net/mac802154/iface.c (65)

can't be. The patch removes the RTNL assertion. Please check if you
really rebuild and update your kernel/modules.

Maybe try `uname -a` and check kernels build date/git HEAD id/whatever.

- Alex
