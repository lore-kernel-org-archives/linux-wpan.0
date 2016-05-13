Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35232 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752473AbcEMM1u (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 13 May 2016 08:27:50 -0400
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: allow netns create of
 lowpan interface
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
 <1462959859-6669-3-git-send-email-aar@pengutronix.de>
 <16670.1462986892@obiwan.sandelman.ca>
 <ac0713b7-c28c-4edc-c35a-b5afeaf1cbcd@pengutronix.de>
 <5734309F.4040805@6wind.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <2d0ed166-cdbf-abba-ef82-eb5625a6cb34@pengutronix.de>
Date: Fri, 13 May 2016 14:27:46 +0200
MIME-Version: 1.0
In-Reply-To: <5734309F.4040805@6wind.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: nicolas.dichtel@6wind.com, Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de


Hi,

On 05/12/2016 09:28 AM, Nicolas Dichtel wrote:
> Le 12/05/2016 01:34, Alexander Aring a écrit :
> [snip]
>> But I don't know how it works when the $PHY isn't visible inside the
>> namespace where the interface should be changed to. But wireless should
>> have the same behaviour then, that the macvlan/veth/etc. the corresponding
>> wireless phy isn't visible in the namespace. Seems there exists some
>> "parent" device inside one namespace and macvlan/veth can be moved to
>> other namespaces, but I am not an expert into that. :-)
> Yes, the virtual interface (macvlan/veth,ip tunnels, vxlan, etc.) is created in
> the namespace of the physical netns. After, the virtual interface is moved to
> another netns (with 'ip link set foo netns bar'). This is called x-netns: the
> upper par of the interface and the link part are not in the same netns.
> With 'ip -d link' it's possible to show the link netns. There is an nsid which
> identified the link netns. The nsid is valid only in the current netns (ie the
> same netns can have another nsid in another netns).
> Usually, there are explicit boundary in the code when crossing netns (see
> skb_scrub_packet for example).
> 
> Example with a gre interface:
> 
> # create a gre interface in netns1
> ip netns exec netns1 ip link add dev tun1 type gre local 10.0.0.1 \
>      remote 10.0.0.2
> # move it in netns2: the link netns is still in netns1
> ip netns exec netns1 ip link set tun1 netns netns2
> 
> or (completely equivalent):
> 
> # assign a nsid to netns1 in netns2
> ip exec netns2 ip netns set netns1 1234
> # create a gre interface in netns2 with its link netns in netns1
> ip exec netns2 ip link add tun1 link-netnsid 1234 type gre local 10.0.0.1 \
>      remote 10.0.0.2

Thanks for the explanation.

The current patch series put the whole phy and all the interfaces into
one net namespace (like in wireless). The lowpan interface can also be
created in non init_net then.

So far I know it's not possible to move wpan or lowpan interfaces after
creation e.g. running "ip link set #IF netns $NETNS_NAME" and we need to
support such behaviour in future.

The current use-case is just for the fakelb driver (like hwsim in
wireless) which doesn't do any optimization in IPv6 stack if two
interfaces belongs to the same net namespace.

- Alex
