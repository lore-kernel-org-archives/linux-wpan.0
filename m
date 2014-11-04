Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44608 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaKDOTn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 09:19:43 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so9539461wib.5
        for <linux-wpan@vger.kernel.org>; Tue, 04 Nov 2014 06:19:41 -0800 (PST)
Date: Tue, 4 Nov 2014 15:19:39 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: skb free patches
Message-ID: <20141104141936.GC643@omega>
References: <54500E1B.20805@xsilon.com>
 <5458D90B.70206@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5458D90B.70206@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Martin,

sorry, I didn't notice this mail.

On Tue, Nov 04, 2014 at 01:47:55PM +0000, Martin Townsend wrote:
> Hi Alex,
> 
> Any thoughts on this?
> 

go ahead and just send patches. For the future I want to change the
802.15.4 6LoWPAN to a common solution. We should do it like 802.15.4
parsing. Not like current mainline, we should do it like frame parsing
in the rework branch [0]. I stole this kind of frame parsing mechanism
from mac80211. For adaptation in 6LoWPAN just replace the 802.15.4 frame
type to the 6LoWPAN dispatch value and you will get something like this
[1].

Nevertheless your solution to have a kfree_skb outside of
iphc_decompress is welcome here. Because the CALL_RXH function returns
on failure 'RX_DROP_UNUSABLE' and hits the handler result function [3]
which runs kfree_skb there.


For now to prepare this outside I will ack this patch. But we are not
alone anymore this needs also an ack from Jukka Rissanen. Check out:

./scripts/get_maintainer.pl -f net/6lowpan

This architecture change need to be acked from both L2 branches which
use 6LoWPAN. Please tag your patch with "6lowpan: $MY_GREAT_CHANGE" and
send it to linux-wpan and linux-bluetooth mailinglist, you can get all
cc members with:

./scripts/get_maintainer.pl -f net/6lowpan

or

./scripts/get_maintainer.pl $MY_GREAT_PACH_FILE

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c
[1] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c#L174
[3] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c#L27
