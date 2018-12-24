Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:55346 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbeLXPcJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Dec 2018 10:32:09 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so16168799ith.5
        for <linux-wpan@vger.kernel.org>; Mon, 24 Dec 2018 07:32:09 -0800 (PST)
Date: Mon, 24 Dec 2018 10:32:05 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Message-ID: <20181224153205.ycr2zdrjbyklulfh@x220t>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Jian-Hong Pan <starnight@g.ncu.edu.tw>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Tue, Dec 18, 2018 at 02:50:58PM +0100, Xue Liu wrote:
> Hello Andreas,
> 
> On Mon, 17 Dec 2018 at 15:19, Andreas Färber <afaerber@suse.de> wrote:
> >
> > Hello Xue Liu,
> >
> > Am 17.12.18 um 09:50 schrieb Xue Liu:
> > > I have a question about the architecture of your module. AFAIK LoRaWAN
> > > is already the MAC Layer above the LoRa technology. Why do you want to
> > > make a new layer called "maclorawan" ?
> >
> > I had asked Jian-Hong to separate between his soft-MAC implementation
> > and the common bits needed to drive hard-MAC implementations found on
> > several of the hardware modules made available to me.
> >
> As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
> We may also use the name “cfglora” for hard-MAC implementation.
> 

There exists also a cfg802154. :-)

Note that cfg80211 is also for providing a backwardscompatibility to the
wireless ioctl() interface.

In theory it's simple:

netlink API -> SoftMAC (macFOOBAR layer) -> cfgFOOBAR implementation -> driver layer
            \-> HardMAC (driver layer) -> cfgFOOBAR implementation

The "difficult" part is providing one userspace interface for both
either SoftMAC layer and all HardMAC drivers.

There both maintainers need to be synchronized.

As a side note I want to mention that the 802.15.4 subsystem supports
currently a HardMAC transceiver in the SoftMAC layer. We don't have
quite HardMAC support yet but are somehow prepared according the
wireless architecture above.

The people who did that didn't wanted to investigate time to implement a
whole HardMAC layer, as I told them when we support more in the SoftMAC
layer it will break their transceiver... so they was fine with that as
warning it seems. :-)

- Alex
