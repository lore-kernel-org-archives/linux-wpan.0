Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35130 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbbD0GwE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Apr 2015 02:52:04 -0400
Received: by pabtp1 with SMTP id tp1so119422226pab.2
        for <linux-wpan@vger.kernel.org>; Sun, 26 Apr 2015 23:52:04 -0700 (PDT)
Message-ID: <553DDC7F.8020109@gmail.com>
Date: Mon, 27 Apr 2015 12:21:43 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next 00/15] ieee802154: add support for phy capabilities
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com> <5539BA9B.4090903@gmail.com> <5539D098.1000203@gmail.com> <20150425100633.GD3395@omega>
In-Reply-To: <20150425100633.GD3395@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de

Hi Alex,

On 04/25/2015 03:36 PM, Alexander Aring wrote:

> On Fri, Apr 24, 2015 at 10:41:52AM +0530, Varka Bhadram wrote:
> ...
>> May be this is not the right place to ask this question.
>>
> creating a new mail to linux-wpan next time? And of course you can ask
> this here.
>
>> Do you think that patch at [0] required to us..?
>>
> no.
>
>> That will be useful multi-queue environment. Even though
>> its better to have this feature.
>>
> Note about tx multi-queue environment:
>
> Wireless (802.11) != 802.15.4
>
> 802.11 follows different strategies like 802.15.4 follows [0]. "was
> chartered to investigate a low data rate solution...", of course
> low-power and such things. I would not say that performance isn't
> important for us. (I also like to remove several shift operation in the
> current frame parsing) What I am think is that a multiqueue environment
> gives us not a big benefit.
>
> Maybe I am wrong here, you can implement it and give some benchmark
> tests if you want.
>
>
> Another thing is that the multiqueue in wireless do implement a
> priority queue (that's what I understand). So we need to have somewhere
> option which sets this priority somewhere. [1]
>
> mac802154 do that for different types of content in the payload like
> video or audio streaming. They have some priority enums defined at [2].
> Every queue has then a own priority.
>
> You see that with multiqueue inside mac80211 they want to improve
> different payload content like video which is a use case of the 802.11
> standard. For example streaming videos with 802.15.4, you can forget that.
> But then we have other things like "low energy".
>
> This is why there is no general "IoT" wireless standard outside, each have
> their benefit depends on your use case. If you want to stream videos and call
> it "IoT - Application" then 802.15.4 is not what you want. I did a fast
> googling and found [3], you see different wireless standards compared with 
> Range and data rate.
>
>
> To detect a priority for _maybe_ implement such multiqueue handling in
> 802.15.4 then this could be dine by set it in some sockopt of 802.15.4 sockets
> or grab it from DCSP field of IPv6 header, like wireless it also does [1] - 
> "DSCP (RFC 2474):" for 6LoWPAN then. But general this would be a benefit if you
> have a lot of other _lower_ priority traffic.
>
>
>
> It also could be that a wireless driver/transceiver can support
> put frame in "transceiver queue" when current one is transmitted at the moment.
> I don't know if something exists at the moment, the at86rf2xx have only
> one frame buffer which cannot be overwritten while transmit (or can but
> then it need to handle real time, I think we can't never support that
> inside linux).
>
>
>
>
> Now note about patch ("mac80211: use per-CPU TX/RX statistics")
> 084d8536fc4f1581f975c1a5fcacd4384555bdcf:
>
> First I don't apply something like that if we doesn't have multiqueue tx queue
> (if it really increase perfomance), because this patch fix something
> which only happen in multiqueue tx queue handling.
>
> Second: This patch is because there is an issue about increment the tx
> stats on netdev while using multiqueue. So far I understand this is
> because the incrementation is not an atomic operation, so this patch to
> a per cpu operation to be sure that this operation "to increment the tx
> stats" can be run on one cpu. So before this patch mulitple queues was
> running and increment these values at the same time which result in some
> inconsistent behaviour.
>
>
>> If you agree include this, patch is on the way.. 
>>
> no. In short:
>
> 1. We don't have multple tx queues (and I don't think that we can get
>    much benefits from it).
>
> 2. The patch ("mac80211: use per-CPU TX/RX statistics")
>    084d8536fc4f1581f975c1a5fcacd4384555bdcf solved an issue when multiple
>    queues increments the counter on multicore architecture. We don't have
>    this issue because we have only one queue which we stop and wake before
>    transmit and while tx completion. The incrementation is protected by
>    this handling.
>
>
> You should provide patches for an useful case of multiple tx queues with
> benchmark results. Then we need to care about "locking", this is what
> your wireless patch fix does.
>
> - Alex
>
> [0] http://www.ieee802.org/15/pub/TG4.html
> [1] https://wireless.wiki.kernel.org/en/developers/documentation/mac80211/queues
> [2] http://lxr.free-electrons.com/source/include/net/mac80211.h#L102
> [3] http://blogs.freescale.com/wp-content/uploads/2014/11/post-10893-image-4-todays-wireless-landscape.jpg
> [4] 

Agree with you.

Thank you for your explanation.

-- 
Varka Bhadram

