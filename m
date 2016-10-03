Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47130 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751041AbcJCMZ5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Oct 2016 08:25:57 -0400
Subject: ANNOUNCE: openthread af802154
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <a6fd880a-0ced-9076-d62e-9bf2412b8802@pengutronix.de>
Date: Mon, 3 Oct 2016 14:25:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: Martin Gergeleit <martin.gergeleit@hs-rm.de>


Hi,

I already talked in openthread-users [0] about af802154 feature in
openthread.

I use it in my case to create some virtual setup to let talk a linux
interface with openthread userspace instance.

Code can be found [1].

--- snip
#!/bin/sh
rmmod fakelb
modprobe fakelb numlbs=4

ip link add link wpan0 name lowpan0 type lowpan
iwpan dev wpan0 set pan_id 0x0000
ip link set wpan0 up
ip link set lowpan0 up

iwpan dev wpan1 del
iwpan phy1 interface add ot0 type monitor

iwpan dev wpan2 del
iwpan phy2 interface add ot1 type monitor

ip link set ot0 up
ip link set ot1 up

iwpan dev wpan3 del
iwpan phy3 interface add monitor0 type monitor

ip link set monitor0 up
--- snap

Will create ot0 and ot1 interface which is a monitor interface. It works
on the same stuff like my raw802154 driver for RIOT-OS [2].

You can run openthread on a monitor then with:

AF_PACKET_IFNAME="ot0" ./ot-cli 1

where AF_PACKET_IFNAME is your 802.15.4 monitor interface.

I use it only for fakelb driver and don't recommend it to run it on real
hardware. For my case, I do some MLE experiments. [3] ;-)

For what we can do it also is:

Implementing MLME-ops -> openthread support some! :-)

- Alex

[0] https://groups.google.com/forum/#!topic/openthread-users/BXOk9JfDsqY 
[1] https://github.com/linux-wpan/openthread/tree/af802154
[2] https://github.com/RIOT-OS/RIOT/pull/5582
[3] https://tools.ietf.org/html/draft-ietf-6lo-mesh-link-establishment-00
