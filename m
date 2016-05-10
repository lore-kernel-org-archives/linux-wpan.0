Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45272 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbcEJFoY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 10 May 2016 01:44:24 -0400
Subject: Re: How to move wpan interface to another interface?
References: <D8027A82-319B-4FB7-AB44-C72B827B827E@icloud.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <4c748603-4aa4-e498-bfa5-b1580eeb0a28@pengutronix.de>
Date: Tue, 10 May 2016 07:44:20 +0200
MIME-Version: 1.0
In-Reply-To: <D8027A82-319B-4FB7-AB44-C72B827B827E@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guangyu Pei <guangyu.pei@icloud.com>, linux-wpan@vger.kernel.org


Hi,

On 05/10/2016 12:57 AM, Guangyu Pei wrote:
> Hi,
> 
> Command “ip link set wpan0 netns pid” returns “RTNETLINK answers: Invalid argument”. For 802.11, we have “iw phy phy1 set netns pid”. But for iwpan, it seems that there is no such option. I need to run some experiments with fakelb driver and hope that I can move wpan devices to different network namespaces.
> 
> Would you please let me know whether there is a workaround or I miss anything?
> 

Netns support doesn't exist mainline now, but I have patches.

I created them where bluetooth-next was behind net-next for netlink u64
pad patches. I need to clean them up and send them mainline.

kernel:

https://github.com/linux-wpan/linux-wpan-next/commits/netns

wpan-tools:

https://github.com/linux-wpan/wpan-tools/commits/netns

the hwsim starting script from website (updated):

---

#!/bin/sh

# we need some Private Area Network ID
panid="0xbeef"
# number of nodes
numnodes=6

# include the kernel module for a fake node, tell it to create six
# nodes
modprobe fakelb numlbs=$numnodes

# initialize all the nodes
for i in $(seq 0 `expr $numnodes - 1`);
do
	ip netns delete wpan${i}
	ip netns add wpan${i}
	PHYNUM=`iwpan dev | grep -B 1 wpan${i} | sed -ne '1 s/phy#\([0-9]\)/\1/p'`
	iwpan phy${PHYNUM} set netns name wpan${i}

	ip netns exec wpan${i} iwpan dev wpan${i} set pan_id 0xbeef
	ip netns exec wpan${i} ip link add link wpan${i} name lowpan${i} type lowpan
	ip netns exec wpan${i} ip link set wpan${i} up
	ip netns exec wpan${i} ip link set lowpan${i} up
done

---

creates 6 phys and 6 wpan interfaces with a lowpan interface, each
of them in his own net namespace.

btw: I want to mark fakelb deprecated and add a new implementation of
fakelb with the name "mac802154_hwsim", I hate it when I told about the
"fakelb" driver and wireless people told me "do you know hwsim...". It's
simple the same stuff but somebody named the stuff completely different
which makes no sense.

I also don't know if we really should add the netns support flag for
wpan-phy's. This is for HardMAC transceivers only, there exists one
outside but we currently support SoftMAC transceivers currently only.
:-)

I hope I could help you and now I try to bring these patches mainline
since already people want to do experiment like me which is great!

- Alex
