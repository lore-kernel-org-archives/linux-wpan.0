Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47012 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418AbcGYOfm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 10:35:42 -0400
Subject: Re: Packets not reaching lowpan interface
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
 <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
 <25673.1469453292@obiwan.sandelman.ca>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <f36a7c18-b9c2-c3a7-ff68-337701e99726@pengutronix.de>
Date: Mon, 25 Jul 2016 16:35:38 +0200
MIME-Version: 1.0
In-Reply-To: <25673.1469453292@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Aaron Sowry <aeneby@gmail.com>, linux-wpan@vger.kernel.org


Hey Michael,

On 07/25/2016 03:28 PM, Michael Richardson wrote:
> 
> Aaron Sowry <aeneby@gmail.com> wrote:
>     > 2) Created a lowpan interface:
> 
>     > # ip link set wpan0 down
>     > # iwpan phy phy0 set channel 0 26
>     > # iwpan dev wpan0 set pan_id 0x0023
>     > # ip link set wpan0 up
>     > # ip link set lowpan0 up
> 
> I think you got everything plumbed up correctly, but I wanted to post for
> google benefit that by default the wpan0 and wpan1 that come up are virtual
> interfaces, and wpan2 is the first real radio.
> 

this is the case if your system loading fakelb for some reason, or you
have fakelb as built-in module. Then over linux kernel magic linker
scripts it will call all "module_init" declarations, if building as
built-in module.

- Alex
