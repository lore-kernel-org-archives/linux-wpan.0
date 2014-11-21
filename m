Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63441 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbaKURLH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Nov 2014 12:11:07 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so9580273wiw.9
        for <linux-wpan@vger.kernel.org>; Fri, 21 Nov 2014 09:11:05 -0800 (PST)
Date: Fri, 21 Nov 2014 18:10:58 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Unused function mac802154_header_parse()
Message-ID: <20141121171055.GE20364@omega>
References: <546F62C1.6010500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <546F62C1.6010500@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

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

For the dev_parse_header usage:

`grep -r -n "dev_parse_header" net`:

net/packet/af_packet.c:1823:	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
net/packet/af_packet.c:2030:	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);

This is used by the packet layer at several places.



I need to dig more into this. It seems that these callback structure are
optional because dev_hard_header and dev_parse_header header return 0 if
they are not implemented.

Also it seems that when af_packet uses dev_hard_header header it could
be that the control block information is overwritten by packet_skb_cb.
So it's _maybe_ a bug to add additional parameters over control block
information for the header_create callback.

- Alex
