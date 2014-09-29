Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:49593 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaI2LYA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 07:24:00 -0400
Received: by mail-we0-f173.google.com with SMTP id p10so3291960wes.4
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 04:23:59 -0700 (PDT)
Date: Mon, 29 Sep 2014 13:23:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929112357.GB18804@omega>
References: <54258332.2010004@xsilon.com>
 <20140926153521.GA7643@omega>
 <542593AC.4060901@xsilon.com>
 <20140927014243.GA26666@omega>
 <54293279.5090103@xsilon.com>
 <20140929111325.GA18804@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140929111325.GA18804@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Mon, Sep 29, 2014 at 01:13:25PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Mon, Sep 29, 2014 at 11:20:41AM +0100, Simon Vincent wrote:
> > Currently there does not seem to be any filtering in the mac layer anyway.
> > In wpan.c mac802154_subif_frame we check the pan id and dest address but we
> > don't discard any packets. Should we be discarding packets at this point?
> > For example packets of type PACKET_OTHERHOST.
> > 
> > If I discard all PACKET_OTHERHOST in mac802154_subif_frame it solves my
> > problem. I just don't know if this will effect anything else.
> > 
> 
> Please see [0]. IPv6 will drop all PACKET_OTHERHOST. Maybe this
> information is gone by some new skb_alloc's. Simon can you check this?
> 
> Simple add some printk before deliver to IPv6 layer.
> 
> And no, we don't make this at mac802154 layer.
> 

Maybe we should do this in 6LoWPAN Layer. Means a:

if (skb->pkt_type == PACKET_OTHERHOST) {
	kfree_skb(skb);
	return NET_RX_DROP;
}

in lowpan_rcv [0] function. I am not 100% sure right now, but I think it's
better than we don't parse any OTHERHOST frames in 6LoWPAN packet layer.

But this is another issue...

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L456
