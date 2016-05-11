Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45557 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbcEKXeZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 19:34:25 -0400
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: allow netns create of
 lowpan interface
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
 <1462959859-6669-3-git-send-email-aar@pengutronix.de>
 <16670.1462986892@obiwan.sandelman.ca>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <ac0713b7-c28c-4edc-c35a-b5afeaf1cbcd@pengutronix.de>
Date: Thu, 12 May 2016 01:34:21 +0200
MIME-Version: 1.0
In-Reply-To: <16670.1462986892@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>


Hi,

On 05/11/2016 07:14 PM, Michael Richardson wrote:
> Alexander Aring <aar@pengutronix.de> wrote:
>     > This patch reverts commit f9d1ce8f81eb ("ieee802154: fix netns settings").
>     > The lowpan interface need to be created inside the net namespace where
>     > the wpan interface is available. The wpan namespace can be changed only
>     > by nl802154 before. Without this patch it's not possible to create a
>     > lowpan interface for a wpan interface which isn't inside init_net
>     > namespace.
> 
> I know that we can't support multiple lowpan interfaces on a single wpan
> at this time.  If one could, via a macvlan like way, would we want to
> put different lowpan interfaces in different netns on top of the same
> physical radio.
> 

mhh, this patch currently sets the whole phy into a namespace and all
related interfaces wpan/lowpan can only exists according the namespace
which the phy belongs to.

Running wpan interface in netns A and running the corresponding lowpan
interface in an another namespace sounds wrong for me, because they should
known each other.

btw: I tried to use "ip link set $WPAN/$LOWPAN netns $NETNS" doesn't work,
it returns -EINVAL.
I think this works only if we set some flags/callbacks, don't know but
was one of my test cases.

If running iwpan $PHY set netns name $NETNS, the wpan interface will
unregister(deleting lowpan) and will be registered again (inside
different namespace).

---

(Creating multiple lowpans for one wpan)

This can be done when creating two wpan interfaces according one phy.
The bad news is, you can't change the mac address stuff and I think this
isn't what you want. The reason is simple, most hardwares has one
address filtering setting only. You could have two wpan interfaces with
different address settings, but then one interface can be in up state only.

To avoid such behaviour, I had in my mind to simple go into promiscuous
mode if two wpan interfaces are up with different address settings, then
let do linux do all filtering stuff. I had to avoid that because the
hardware will not filtering anything anymore and linux need to do more
"work".

Maybe just go into promiscuous when it's necessary and print some
WARNING that the device going into promiscuous mode in such setup.

> I'm also ignorant here: can one create macvlan against a physical interface
> into a netns?
> 

What I googled is, yes that's possible. But they use "ip link set
$INTERFACE netns $NETNS" for that, I think we need to implement such
feature for wpan/lowpan stuff.

But I don't know how it works when the $PHY isn't visible inside the
namespace where the interface should be changed to. But wireless should
have the same behaviour then, that the macvlan/veth/etc. the corresponding
wireless phy isn't visible in the namespace. Seems there exists some
"parent" device inside one namespace and macvlan/veth can be moved to
other namespaces, but I am not an expert into that. :-)

- Alex
