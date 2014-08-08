Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:63320 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbaHHKrW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 06:47:22 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so5444680wev.13
        for <linux-wpan@vger.kernel.org>; Fri, 08 Aug 2014 03:47:21 -0700 (PDT)
Date: Fri, 8 Aug 2014 12:47:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140808104712.GA16641@omega>
References: <53E48D10.3090606@gmail.com>
 <20140808093353.GC20055@omega>
 <53E49E62.3010908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53E49E62.3010908@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: Regarding dev->addr_len
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Fri, Aug 08, 2014 at 03:24:42PM +0530, Varka Bhadram wrote:
> 
> Entire Network layer may be working with 48-bit or 64-bit MAC address only.
> 

That's not correct. The network layer can handle xx bit mac addresses
depends on addr_len. Our mac layer have something special which isn't in
any other mac layers. We have two kinds of mac addresses which can be
used mixed in destination and source address in the mac header.

The problem is 6LoWPAN is an adaption layer and the whole
net/ipv6/ndisc.c implementation can handle only one kind of mac address
with one addr_len.

According we have two kinds with different length we need also other
ICMPv6 nd messages. The neighbor discovery cache need to hold a
information if it's a short or extended and send the right nd messages.

> May be we need to change this behavior to work with 16-bit also ...?
> 

Okay, create patches to change the core netdev api to handle two kinds
of dev_addr's. I am prerry sure this will not accept at mainline. We
need another idea and if you read my other mail on netdev you will get a
imagine about that what I try to do. Sorry, this is hard but we can't
change the whole network API only for 802.15.4.

One reply talked about a private data isnide a neighbor entry which is
set by L2, that's another option and I like it.

> Also for a interface we are going to have one netdevice structure ...?
> 

I don't know what you mean here. But another idea of mine was to have a
second interface for short addresses only, but this can't work because
short and extended addresses can be used at the same time. If you mean
that.

> If yes, dynamically updating dev_addr and addr_len creates problems..?
> 
Look at net/ipv6/ndisc.c in about one minute you will see that this will
create problems of course.

- Alex
