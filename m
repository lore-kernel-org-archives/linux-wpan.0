Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:50821 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966241AbeFNOUm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Jun 2018 10:20:42 -0400
Received: by mail-it0-f67.google.com with SMTP id u4-v6so8583334itg.0
        for <linux-wpan@vger.kernel.org>; Thu, 14 Jun 2018 07:20:41 -0700 (PDT)
Date: Thu, 14 Jun 2018 10:20:36 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Problem using AF_PACKET with SOCK_RAW on ieee802514 devices
Message-ID: <20180614142036.alazx4ia2buus7cc@x220t>
References: <2998722.BvyPDujJB3@saab-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2998722.BvyPDujJB3@saab-desktop>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Josef Filzmaier <j.filzmaier@gmx.at>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 14, 2018 at 12:35:40AM +0200, Josef Filzmaier wrote:
> Hello everyone (again)!
> 
> I am using the linux-wpan stack with the atusb and at86rf230 drivers (rf212).
> Moreover i am using raw sockets to test some userspace implemenation of a 
> custom protocol. In userspace i am using (attention, golang ahead)
> 
> > protocol = htons(syscall.ETH_P_IEEE802154)
> > syscall.Socket(syscall.AF_PACKET, syscall.SOCK_RAW, int(protocol))
> 
> to create a raw socket. This has been working as desired up until commit 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
> id=b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba
> 
> After this commit the kernel mistakenly attaches two uninitialized bytes at 
> the end of my raw data. I am currently using a patched kernel which uses the 
> following code in af_packet.c (Modified the else if over Willem de Brujin's 
> patch)
> 
> > } else if (sock->type != SOCK_RAW && reserve {
> > 	skb_push(skb, reserve);
> > }
> 

Check commit 9aad13b087ab ("packet: fix reserve calculation").

Push is definitely wrong here and breaks things. dev_hard_header_len is
the minimum size what we allow to the driver level.

This should be 3 (can you please check that if it's 2 or 3 I think there
was some off-by one fix lately and I had it on the list).

It's because drivers parse FC and SEQ, this is what I have in the
architecture yet. There exists drivers which doing more but this is a
whole other big issue.

- Alex
