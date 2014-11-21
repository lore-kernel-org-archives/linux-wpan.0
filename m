Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:65535 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbaKUQfR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Nov 2014 11:35:17 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so6958249wgh.40
        for <linux-wpan@vger.kernel.org>; Fri, 21 Nov 2014 08:35:11 -0800 (PST)
Date: Fri, 21 Nov 2014 17:35:05 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Unused function mac802154_header_parse()
Message-ID: <20141121163502.GC20364@omega>
References: <546F62C1.6010500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <546F62C1.6010500@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Fri, Nov 21, 2014 at 09:35:21PM +0530, Varka Bhadram wrote:
> Hi,
> 
> There are two header_ops operations defined for mac802154 at [1]. One is for creating header another for parsing.
> 
> Creation of mac802154_header_create() happening at [2] by using dev_hard_header(), but i did not find dev_parse_header()
> for header parse by mac802154_header_parse().
> 
> Am i missing anything.?
> 

Parsing frames are completely done at [0]. With call of
"netif_receive_skb(skb);" the frame is deliverd into packet layer.

Currently there exist several issues with parsing frames which I don't
will explain now.



Now the header_ops structure:

These callbacks are many used by arp or ndisc. For me there exist no
reason why a wpan interface implements such functionallity. The lowpan
interface needs these callbacks. For the rework I removed dev_hard_header
calls for 802154 upper layers. Not for the lowpan interface.

What we now doing inside the 802154 layer is to use dev_hard_header and pass
additional parameters over skb->cb, but we don't need that for the wpan interface.

At lowpan interface the ndisc IPv6 cache will tell us the destination
address, that's why need this there.

For af802154: this is currently a complete weird implementation.


For more documentation about that the header_ops callback structure
does, read the implementation for ethernet. [1]


Sorry I am busy right now and it's also not easy to doing some new
mechanism into the frame parsing/mac header generation because it's used
everywhere.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/rx.c?id=24ccb9f4f7a3a5a867bbc880019cdb4b41176b63#n196
[1] http://lxr.free-electrons.com/source/net/ethernet/eth.c#L345
