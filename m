Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:53625 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaIVJ6X (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Sep 2014 05:58:23 -0400
Received: by mail-wi0-f177.google.com with SMTP id q5so2613096wiv.4
        for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 02:58:22 -0700 (PDT)
Date: Mon, 22 Sep 2014 11:58:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v3] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140922095817.GB21350@omega>
References: <1411378727-10461-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411378727-10461-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Simon,

So last but not least, I run checkpatch on it, you should always run
checkpatch before sending patches. And also pass the argument "--strict"
on checkpatch.

Example:
./scripts/checkpatch.pl --strict 0001-ieee802154-6lowpan-ensure-header-compression-does-no.patch

ERROR: trailing whitespace
#119: FILE: net/ieee802154/6lowpan_rtnl.c:135:
+^Imemcpy(&info->daddr.u.extended_addr, daddr, $

CHECK: Alignment should match open parenthesis
#120: FILE: net/ieee802154/6lowpan_rtnl.c:136:
+	memcpy(&info->daddr.u.extended_addr, daddr, 
+		sizeof(info->daddr.u.extended_addr));

ERROR: trailing whitespace
#122: FILE: net/ieee802154/6lowpan_rtnl.c:138:
+^Imemcpy(&info->saddr.u.extended_addr, saddr, $

CHECK: Alignment should match open parenthesis
#123: FILE: net/ieee802154/6lowpan_rtnl.c:139:
+	memcpy(&info->saddr.u.extended_addr, saddr, 
+		sizeof(info->daddr.u.extended_addr));


Nevertheless you need to fix this please, we can talk about warning but not
about errors.


When you are finish it looks okay for me, I wait a little bit and will apply
it tomorrow. Then I am sure that other people had some time for reviewing.

If somebody have other review issues then you need to work again over
it, sorry.

On Mon, Sep 22, 2014 at 10:38:47AM +0100, Simon Vincent wrote:
> The 6lowpan ipv6 header compression was causing problems for other interfaces
> that expected a ipv6 header to still be in place, as we were replacing the
> ipv6 header with a compressed version. This happened if you sent a packet to a
> multicast address as the packet would be output on 802.15.4, ethernet, and also
> be sent to the loopback interface. The skb data was shared between these
> interfaces so all interfaces ended up with a compressed ipv6 header.
> The solution is to ensure that before we do any header compression we are not
> sharing the skb or skb data with any other interface. If we are then we must
> take a copy of the skb and skb data before modifying the ipv6 header.
> The only place we can copy the skb is inside the xmit function so we don't
> leave dangling references to skb.
> This patch moves all the header compression to inside the xmit function. Very
> little code has been changed it has mostly been moved from lowpan_header_create
> to lowpan_xmit. At the top of the xmit function we now check if the skb is
> shared and if so copy it. In lowpan_header_create all we do now is store the
> source and destination addresses for use later when we compress the header.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---

Doesn't matter now but after these "---" normally we write what was the
changes since v1..v2 and v2..v3. This will be ignored by applying. Only
notes for reviewing. Sorry I forgot this at the last review step.

Thanks.



Also we are not sure that place things into skb_headroom works _always_.
We knowing now that the current behaviour makes trouble... so doesn't
matter currently if we are 100% sure that these buffer will never
overwritten. I mean "it's better than the current behaviour and I detected
no issues with that currently".

- Alex
