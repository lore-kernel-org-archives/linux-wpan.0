Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35309 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbE1NRU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 09:17:20 -0400
Received: by wicmx19 with SMTP id mx19so146247009wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 06:17:19 -0700 (PDT)
Date: Thu, 28 May 2015 15:17:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150528131714.GD716@omega>
References: <20150528123832.GD11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150528123832.GD11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Thu, May 28, 2015 at 03:38:32PM +0300, Lennert Buytenhek wrote:
> Currently, ieee802154_random_extended_addr() has a 50% chance of
> generating a group (multicast) address, while this function is used
> for generating station addresses (which can't be group addresses)
> for interfaces that don't have a hardware-provided address.
> 
> Also, in case get_random_bytes() generates the EUI-64 address
> 00:00:00:00:00:00:00:00 (extremely unlikely), which is an invalid
> address, ieee802154_random_extended_addr() reacts by changing it
> to 01:00:00:00:00:00:00:00, which is an invalid station address as
> well, as it is a group address.
> 
> This patch changes the address generation procedure to grab eight
> random bytes, treat that as an EUI-64, and then clear the Group
> address bit and set the Locally Administered bit, which is in
> line with how eth_random_addr() generates random EUI-48s.
> 

This is one thing which I asked myself already. If the group address
comming from EUI-64 standard or not. What I can say is that the 802.15.4
MAC layer doesn't care about this bit and we don't have _any_ multicast
functionality.

What you try to do is to map ethernet MAC functionality to 802.15.4 MAC. The
802.15.4 have no special bits inside the EUI64 which indicates
something. Our multicast functionality is done by a broadcast (done by
short address, which is currently indicate by a 0xff..ff extended addr,
because IPv6 can't deal at the moment deal with two types of mac address
types.)

What I always find is this document [0]. Which describes that the
0x00..00 and 0xff...ff are invalid. (And a node should really not use
0xff..ff since we have the workaround with IPv6 for broadcast).


If we would have such bit, then we also need to implement [1], which
generates the multicast address according the IPv6 address. At the
moment we get the dev->broadcast address which is correct, because we
don't have multicast functionality.


I don't ack this patch, because I don't see at the moment that this is
wrong. Maybe I don't get it. If IPv6 checks on this bit and indicates a
multicast on L2 _then_ we should change it, but I don't think that IPv6
do that.

- Alex

[0] http://standards.ieee.org/develop/regauth/tut/eui64.pdf
[1] http://lxr.free-electrons.com/source/net/ipv6/ndisc.c#L264
