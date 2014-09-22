Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45593 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaIVKBp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Sep 2014 06:01:45 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so2606816wiv.17
        for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 03:01:44 -0700 (PDT)
Date: Mon, 22 Sep 2014 12:01:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v3] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140922100141.GC21350@omega>
References: <1411378727-10461-1-git-send-email-simon.vincent@xsilon.com>
 <20140922095817.GB21350@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140922095817.GB21350@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

On Mon, Sep 22, 2014 at 11:58:17AM +0200, Alexander Aring wrote:
> Hi Simon,
> 
> So last but not least, I run checkpatch on it, you should always run
> checkpatch before sending patches. And also pass the argument "--strict"
> on checkpatch.
> 
> Example:
> ./scripts/checkpatch.pl --strict 0001-ieee802154-6lowpan-ensure-header-compression-does-no.patch
> 
> ERROR: trailing whitespace
> #119: FILE: net/ieee802154/6lowpan_rtnl.c:135:
> +^Imemcpy(&info->daddr.u.extended_addr, daddr, $
> 
> CHECK: Alignment should match open parenthesis
> #120: FILE: net/ieee802154/6lowpan_rtnl.c:136:
> +	memcpy(&info->daddr.u.extended_addr, daddr, 
> +		sizeof(info->daddr.u.extended_addr));
> 
> ERROR: trailing whitespace
> #122: FILE: net/ieee802154/6lowpan_rtnl.c:138:
> +^Imemcpy(&info->saddr.u.extended_addr, saddr, $
> 
> CHECK: Alignment should match open parenthesis
> #123: FILE: net/ieee802154/6lowpan_rtnl.c:139:
> +	memcpy(&info->saddr.u.extended_addr, saddr, 
> +		sizeof(info->daddr.u.extended_addr));
> 

and again sorry. Maybe I have this in my local rework branch but I do
hacking there and doesn't care about whitespace. Only at end of the
rework for creating "real mainline patches", I will care about that.

I hope you understand that. Sorry! :-)

- Alex
