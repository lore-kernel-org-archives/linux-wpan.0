Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50312 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597AbbBEOfA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Feb 2015 09:35:00 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so39401778wiv.1
        for <linux-wpan@vger.kernel.org>; Thu, 05 Feb 2015 06:34:59 -0800 (PST)
Message-ID: <54D37F91.4010500@6wind.com>
Date: Thu, 05 Feb 2015 15:34:57 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <54CBE2EF.7050003@alten.se> <54CF9EA8.4080207@6wind.com> <54D28237.9060009@alten.se>
In-Reply-To: <54D28237.9060009@alten.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arvid Brodin <arvid.brodin@alten.se>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dmitry.tarnyagin@lockless.no, alex.aring@gmail.com, linux-wpan@vger.kernel.org

Le 04/02/2015 21:33, Arvid Brodin a écrit :
> On 2015-02-02 16:58, Nicolas Dichtel wrote:
>> Le 30/01/2015 21:00, Arvid Brodin a écrit :
>>> On 2015-01-26 22:28, Nicolas Dichtel wrote:
[snip]
> Ok, so x-netns simply means cross-netns?
Yes
>
[snip]
>> Now, the question is: does HSR really work across netns? Why is the flag
>> NETIF_F_NETNS_LOCAL set?
>> dev_forward_skb() may be used to forward an skbuff to another netns.
>
> Here is the code snippet that sets NETIF_F_NETNS_LOCAL:
> 	/* Not sure about this. Taken from bridge code. netdev_features.h says
> 	 * it means "Does not change network namespaces".
> 	 */
> 	dev->features |= NETIF_F_NETNS_LOCAL;
>
> HSR is a bit like a bridge since it forwards packets between interfaces on the
> same Ethernet network, and the bridge code sets NETIF_F_NETNS_LOCAL. And that's
> really all the reason for the inclusion of the flag - i.e. it should be removed
> if it doesn't make sense.
>
> So, does it make sense? I'm not sure exactly, but I don't think it makes sense
> to have slaves that are in different namespaces - they are supposed to be part
> of the same ethernet network after all. But maybe having the HSR interface in a
> different namespace than the two slaves could make sense - this way you could
> force an application to only communicate using the HSR protocol, and not use any
> of the slave interfaces directly.
>
> If you agree with the above, then I guess that means NETIF_F_NETNS_LOCAL should
> not be set?
It's ok for me. But I think some tests should be done. Usually,
dev_forward_skb() or skb_scrub_packet() are called to clean structures when a
skb crosses netns.
