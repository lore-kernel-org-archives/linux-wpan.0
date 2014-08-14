Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56226 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbaHNIKB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Aug 2014 04:10:01 -0400
Message-ID: <53EC6ED7.6020009@xsilon.com>
Date: Thu, 14 Aug 2014 09:09:59 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com> <53EC6734.6050503@xsilon.com> <20140814075900.GA19177@omega>
In-Reply-To: <20140814075900.GA19177@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next 00/11] ieee802154: mac802154: wireless transformation
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

It would be good to have a way of cleanly putting devices into promiscuous mode, currently we have to patch the mrf driver to do this.

I look forward to trying out the new monitor interface. :)

- Martin.

On 14/08/14 08:59, Alexander Aring wrote:
> Hi,
>
> On Thu, Aug 14, 2014 at 08:37:24AM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> Looks good to me.  The monitor devices work fine for us on both our wireless and plc interfaces using tcpdump.  Out of interest, in  what way are they broken?
>>
> Okay, in my setup I can't set any channels to the monitor interface. It's
> only working if I set some channel hardcoded and the remove of the
> monitor interface is also broken.
>
>
> I gave up to understand how it works. If you see [0] you will see:
>
> dev->ml_priv            = &mac802154_mlme_reduced;
>
> The mac802154_mlme_reduced struct is defined at [1]. It has only the 
>
> .get_phy = mac802154_get_phy,
>
> assign.
>
> But mac802154_get_phy has a assertion on:
>
> BUG_ON(dev->type != ARPHRD_IEEE802154);
>
> Back to [0] you will see:
>
> dev->type               = ARPHRD_IEEE802154_MONITOR;
>
> which doesn't fit together with a
>
> BUG_ON(dev->type != ARPHRD_IEEE802154);
>
> I never hit this BUG_ON and really doesn't know what's going on there,
> I want to implement a MONITOR interface like 80211. :-)
>
>
>
> Nevertheless I gave up to understand what going on there and I can't
> also set channels. Also removing the monitor interface with iz doesn't
> work (I think there was some deadlock).
>
> A monitor device should be going into the promiscous mode of a device.
> But we also don't support this. Okay if you device doesn't has a
> hardware filter, it's like to have a promiscous mode. But sometimes
> promiscous mode also doesn't care about CRC or something else. A monitor
> device should also be able to show broken packets.
>
> I drop this interface type because it really bypass only the mac802154
> stack and nothing else. I don't want to say "we don't need a MONITOR
> interface type", but this is for my opinion in an not useful state.
>
>
>
> And really I don't want to insert something mainline which breaks any
> existing support (monitor, fakelb, crypto, ...). I can't do a deletion of
> net/mac802154 (ieee802154) and simple add a new one, but deleting of
> subsubsystems like montior, fakelb and add a rework of this should not
> make any problems.
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/mac802154/monitor.c
> [1] http://lxr.free-electrons.com/source/net/mac802154/mac_cmd.c#L105
> [2] http://lxr.free-electrons.com/source/net/mac802154/mac_cmd.c#L80
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

