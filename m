Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38896 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbcELH2h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 12 May 2016 03:28:37 -0400
Received: by mail-wm0-f49.google.com with SMTP id g17so119796647wme.1
        for <linux-wpan@vger.kernel.org>; Thu, 12 May 2016 00:28:36 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: allow netns create of
 lowpan interface
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
 <1462959859-6669-3-git-send-email-aar@pengutronix.de>
 <16670.1462986892@obiwan.sandelman.ca>
 <ac0713b7-c28c-4edc-c35a-b5afeaf1cbcd@pengutronix.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <5734309F.4040805@6wind.com>
Date: Thu, 12 May 2016 09:28:31 +0200
MIME-Version: 1.0
In-Reply-To: <ac0713b7-c28c-4edc-c35a-b5afeaf1cbcd@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Le 12/05/2016 01:34, Alexander Aring a écrit :
[snip]
> But I don't know how it works when the $PHY isn't visible inside the
> namespace where the interface should be changed to. But wireless should
> have the same behaviour then, that the macvlan/veth/etc. the corresponding
> wireless phy isn't visible in the namespace. Seems there exists some
> "parent" device inside one namespace and macvlan/veth can be moved to
> other namespaces, but I am not an expert into that. :-)
Yes, the virtual interface (macvlan/veth,ip tunnels, vxlan, etc.) is created in
the namespace of the physical netns. After, the virtual interface is moved to
another netns (with 'ip link set foo netns bar'). This is called x-netns: the
upper par of the interface and the link part are not in the same netns.
With 'ip -d link' it's possible to show the link netns. There is an nsid which
identified the link netns. The nsid is valid only in the current netns (ie the
same netns can have another nsid in another netns).
Usually, there are explicit boundary in the code when crossing netns (see
skb_scrub_packet for example).

Example with a gre interface:

# create a gre interface in netns1
ip netns exec netns1 ip link add dev tun1 type gre local 10.0.0.1 \
     remote 10.0.0.2
# move it in netns2: the link netns is still in netns1
ip netns exec netns1 ip link set tun1 netns netns2

or (completely equivalent):

# assign a nsid to netns1 in netns2
ip exec netns2 ip netns set netns1 1234
# create a gre interface in netns2 with its link netns in netns1
ip exec netns2 ip link add tun1 link-netnsid 1234 type gre local 10.0.0.1 \
     remote 10.0.0.2
