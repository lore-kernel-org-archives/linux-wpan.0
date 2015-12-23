Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34254 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965289AbbLWVdo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Dec 2015 16:33:44 -0500
Received: by mail-qk0-f170.google.com with SMTP id p187so164517117qkd.1
        for <linux-wpan@vger.kernel.org>; Wed, 23 Dec 2015 13:33:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151223092213.GA2075@omega>
References: <1450858678-59333-1-git-send-email-bradjc5@gmail.com> <20151223092213.GA2075@omega>
From: Brad Campbell <bradjc5@gmail.com>
Date: Wed, 23 Dec 2015 16:33:24 -0500
Message-ID: <CADEbMG3BjKaSyaj6wPdECg2pRs9=hh0JiAtFHANoEaJEZx0XCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] ieee802154: cc2520: Check CRC & add promiscuous
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Wed, Dec 23, 2015 at 4:22 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> On Wed, Dec 23, 2015 at 03:17:57AM -0500, Brad Campbell wrote:
>> I've updated the patch to provide monitors a method for determining if
>> the incoming packet had a valid CRC or not. This required adding promiscuous
>> mode, which is no longer the default.
>>
>> Also, am I correct in noting that configuring a node interface to be in
>> promiscuous mode with something like:
>>
>> ioctl(sockfd, SIOCGIFFLAGS, &ifopts);
>> ifopts.ifr_flags |= IFF_PROMISC;
>> ioctl(sockfd, SIOCSIFFLAGS, &ifopts);
>>
>> is not currently supported? That's how I was testing at first and it
>> didn't seem to work.... Also, if a user does set an interface to
>> promiscuous using an ioctl, it seems like they would still want CRC
>> checking, which is not what would currently happen.
>>
>
> These flags does nothing, like in wireless we need to create a special
> interface type for starting in promiscuous mode. Try [0].
>
> The receiving path and the reason that monitors has no addresses is why
> we handle it in that way.
>
> All "NODE" types need to be parsed again on 802.15.4 conform header and
> doing address filtering/etc stuff again. This is different on "MONITOR"
> types, we parse nothing and this goes directly into userspace, the PHR
> header (the len field) is the only thing which we should filter and
> mostly in-driver because after frame[len] there is much moslty some
> data (lqi/rssi/etc).
>
>
> When you sniff on normal "NODE" type, then you will sniff with transceiver
> filtering stuff enabled (address filtering/frame/etc.) what the
> transceiver does AND what mac802154 does.
>

Is it possible to create two interfaces on a phy, one node and one monitor?
Then the driver would be in promiscuous mode and not checking CRC, and
the node interface would get packets with failed CRC with no way to check
that they were wrong.

> - Alex
>
> [0] http://wpan.cakelab.org/#_sniffing

- Brad
