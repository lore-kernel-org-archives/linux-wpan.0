Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61702 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaKFILQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 03:11:16 -0500
Message-ID: <545B2D20.2060809@xsilon.com>
Date: Thu, 06 Nov 2014 08:11:12 +0000
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] 6lowpan: move skb_free from error paths
 in decompression.
References: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com> <20141105210143.GA20379@omega>
In-Reply-To: <20141105210143.GA20379@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Alex,

It should be based on bluetooth-next.  I'll check when I get home tonight.

- Martin.

On 05/11/14 21:01, Alexander Aring wrote:
> Hi Martin,
>
> On Tue, Nov 04, 2014 at 09:36:21PM +0000, Martin Townsend wrote:
>> Currently we ensure that the skb is freed on every error path in IPHC
>> decompression which makes it easy to introduce skb leaks.  By centralising
>> the skb_free into the receive function it makes future decompression routines
>> easier to maintain.  It does come at the expense of ensuring that the skb
>> passed into the decompression routine must not be copied.
>>
> I just want to give it a try and want to test it but I got a:
>
> error: patch failed: net/ieee802154/6lowpan_rtnl.c:200
> error: net/ieee802154/6lowpan_rtnl.c: patch does not apply ...
>
> while applying.
>
> Is the patch really based on bluetooth-next [0]? Please respin this one if
> it doesn't break anything I will ack this one.
>
> - Alex
>
> [0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

