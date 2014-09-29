Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:56898 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaI2LNf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 07:13:35 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so2962632wiv.15
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 04:13:34 -0700 (PDT)
Date: Mon, 29 Sep 2014 13:13:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929111325.GA18804@omega>
References: <54258332.2010004@xsilon.com>
 <20140926153521.GA7643@omega>
 <542593AC.4060901@xsilon.com>
 <20140927014243.GA26666@omega>
 <54293279.5090103@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54293279.5090103@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Sep 29, 2014 at 11:20:41AM +0100, Simon Vincent wrote:
> Currently there does not seem to be any filtering in the mac layer anyway.
> In wpan.c mac802154_subif_frame we check the pan id and dest address but we
> don't discard any packets. Should we be discarding packets at this point?
> For example packets of type PACKET_OTHERHOST.
> 
> If I discard all PACKET_OTHERHOST in mac802154_subif_frame it solves my
> problem. I just don't know if this will effect anything else.
> 

Please see [0]. IPv6 will drop all PACKET_OTHERHOST. Maybe this
information is gone by some new skb_alloc's. Simon can you check this?

Simple add some printk before deliver to IPv6 layer.

And no, we don't make this at mac802154 layer.

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/ip6_input.c#L72
