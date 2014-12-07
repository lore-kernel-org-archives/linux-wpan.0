Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:46848 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbaLGRNS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 12:13:18 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so4507372wgg.21
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 09:13:17 -0800 (PST)
Date: Sun, 7 Dec 2014 18:13:13 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141207171311.GB9532@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <548487CF.4060009@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael C Cambria <mcc@fid4.com>
Cc: linux-wpan@vger.kernel.org

Hi,

please use bluetooth-next [0] for the wpan-tools. For experiment things use
wpan_rework_rfc branch. I have still patches there which should be go
into mainline but isn't easy to touch the code without breaking.

Also for patches please base on bluetooth-next.

On Sun, Dec 07, 2014 at 12:01:03PM -0500, Michael C Cambria wrote:
> On 12/07/14 10:08, Alexander Aring wrote:
> >Hi, I'm happy to announce that I've just released wpan-tools 0.3. This is
> >our first "real" release, the new kernel 3.18 will contain the nl802154
> >interface. The old netlink interface will be removed soon and is
> >deprecated now. At the moment you can still use both userspace tools, but
> >I don't recommend the lowpan-tools. New release will be found now under:
> >http://wpan.cakelab.org/releases/
> 
> Should we using https://github.com/linux-wpan/linux-wpan-next or

mhh, better I update this branch now to bluetooth-next since nl802154
seems to be work.

> https://github.com/linux-wpan/linux-wpan-next/tree/wpan_rework_rfc
> 

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git
