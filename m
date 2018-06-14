Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:46527 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755204AbeFNRNH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Jun 2018 13:13:07 -0400
Received: by mail-io0-f195.google.com with SMTP id d22-v6so7863782iof.13
        for <linux-wpan@vger.kernel.org>; Thu, 14 Jun 2018 10:13:06 -0700 (PDT)
Date: Thu, 14 Jun 2018 13:13:01 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Problem using AF_PACKET with SOCK_RAW on ieee802514 devices
Message-ID: <20180614171301.23vjxsxyjnmnsh3c@x220t>
References: <2998722.BvyPDujJB3@saab-desktop>
 <20180614142036.alazx4ia2buus7cc@x220t>
 <1740660.EcI1Ua05jM@saab-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1740660.EcI1Ua05jM@saab-desktop>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Josef Filzmaier <j.filzmaier@gmx.at>
Cc: linux-wpan@vger.kernel.org, linux-wpan-owner@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 05:57:38PM +0200, Josef Filzmaier wrote:
> On Donnerstag, 14. Juni 2018 16:20:36 CEST you wrote:
> > On Thu, Jun 14, 2018 at 12:35:40AM +0200, Josef Filzmaier wrote:
> > > Hello everyone (again)!
> > > 
> > > I am using the linux-wpan stack with the atusb and at86rf230 drivers
> > > (rf212). Moreover i am using raw sockets to test some userspace
> > > implemenation of a custom protocol. In userspace i am using (attention,
> > > golang ahead)> 
> > > > protocol = htons(syscall.ETH_P_IEEE802154)
> > > > syscall.Socket(syscall.AF_PACKET, syscall.SOCK_RAW, int(protocol))
> > > 
> > > to create a raw socket. This has been working as desired up until commit
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> > > ?
> > > id=b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba
> > > 
> > > After this commit the kernel mistakenly attaches two uninitialized bytes
> > > at
> > > the end of my raw data. I am currently using a patched kernel which uses
> > > the following code in af_packet.c (Modified the else if over Willem de
> > > Brujin's patch)
> > > 
> > > > } else if (sock->type != SOCK_RAW && reserve {
> > > > 
> > > > 	skb_push(skb, reserve);
> > > > 
> > > > }
> > 
> > Check commit 9aad13b087ab ("packet: fix reserve calculation").
> > 
> > Push is definitely wrong here and breaks things. dev_hard_header_len is
> > the minimum size what we allow to the driver level.
> > 
> > This should be 3 (can you please check that if it's 2 or 3 I think there
> > was some off-by one fix lately and I had it on the list).
> > 
> > It's because drivers parse FC and SEQ, this is what I have in the
> > architecture yet. There exists drivers which doing more but this is a
> > whole other big issue.
> > 
> > - Alex
> 
> Yes, applying 9aad13b087ab also fixes my problem. 
> 
> > This should be 3 (can you please check that if it's 2 or 3 I think there
> > was some off-by one fix lately and I had it on the list).
> 
> I just tested, dev->hard_header_len = 2
> 

Good then we need to remove the -1 calculation since they changed it.

> When is this patch going to be applied to the mainline kernel? Is there any 
> way in which i can know that it will be applied to the 4.16.x series?
> 

It's already there [0]. When there is a new stable release everybody
need to switch to it. If your distribution is too slow you need to blame
them.

Also do you use RPi kernel? I got recently reported some issue with and
like to know if there is somebody outside who has problems as well.
Mostly report "again" about garbage data on the bus, it's not the first
time when things works on mainline but not on rpi kernel.

I don't give any support on rpi kernel and it's a mess that people
report problems when they tested it only on RPi kernel.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/net/packet/af_packet.c?h=v4.16.15
