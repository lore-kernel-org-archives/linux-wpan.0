Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:50384 "EHLO
	ironport02.nordicsemi.no" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750732AbcHEHW4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 5 Aug 2016 03:22:56 -0400
From: "Bakke, Glenn Ruben" <Glenn.Ruben.Bakke@nordicsemi.no>
Subject: RE: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan
 implementation
Date: Fri, 5 Aug 2016 07:15:55 +0000
Message-ID: <2D2C7A7559A21B4EAB6B76FE23E27DFA0221FF4FB6@mbx04.nvlsi.no>
References: <20160711195044.25343-1-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "kaspar@schleiser.de" <kaspar@schleiser.de>, "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Patrik.Flykt@linux.intel.com" <Patrik.Flykt@linux.intel.com>

Hi Alex,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Alexander Aring
> Sent: 11. juli 2016 21:50
> To: linux-wpan@vger.kernel.org
> Cc: kernel@pengutronix.de; luiz.dentz@gmail.com; kaspar@schleiser.de;
> jukka.rissanen@linux.intel.com; linux-bluetooth@vger.kernel.org;
> Patrik.Flykt@linux.intel.com; Alexander Aring <aar@pengutronix.de>
> Subject: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan
> implementation
> 
> Hi,
> 
> I want to write a short summary here, to see what I changed to the old
> implementation, please see last RFC patch.
> 
> How to use it (I know some commands are deprecated and should not be
> used), I have two scripts to do that:
> 
> Node A (run at first):
> 
> ---
> 
> #!/bin/sh
> modprobe btusb
> modprobe bluetooth_6lowpan
> 
> hciconfig hci0 up
> echo "hci0 1" > /sys/kernel/debug/bluetooth/6lowpan_enable
> 
> hciconfig hci0 leadv
> 
> hciconfig
> 
> ---
> 
> hcicondif will printout the address of hci dev, remember that.
> 
> Node B (run after Node A stuff):
> 
> ---
> 
> #!/bin/sh
> 
> if [ "$#" -ne 1 ]; then
> 	echo "run $0 \$SLAVE_ADDRESS, where SLAVE_ADDRESS is the BTLE
> slave"
> 	exit 1
> fi
> 
> modprobe btusb
> modprobe bluetooth_6lowpan
> 
> hciconfig hci0 up
> echo "hci0 1" > /sys/kernel/debug/bluetooth/6lowpan_enable
> 
> hcitool lecc $1
> 
> echo "connect $1 1" > /sys/kernel/debug/bluetooth/6lo0
> 
> ---
> 
> Where $1 is the address of the Node A.
> 
> Well done. Your connection should be established. Except you have crap usb
> dongles like me (broadcom) where sometimes the reset functionality seems
> to be not working 100% correctly. btw: my workaround, replug usb dongles
> (but I always need to tell the new usb bus information my qemu vm :-()
> 
> KNOWN BUGS and how to reproduce that one:
> 
> First, thanks to Luiz Augusto von Dentz, which tried to help me there.
> But I gave up, the BUG still exists and it's because L2CAP implementation or I
> use xmit functionality wrong.
> 
> The issue is "tx credits in L2CAP (bluetooth experts know what I mean here)
> will be reach to zero at the same time on both nodes. This occurs a deadlock
> and nobody will transmit anything anymore".
> 
> So far I understand these tx credits are to avoid buffer-bloating. My
> workaround to fix that was to allow buffer bloating:
> 
> #define L2CAP_LE_MAX_CREDITS            10
> changed to (some high number which doesn't reach 2^16):
> #define L2CAP_LE_MAX_CREDITS            60000
> 
> This will introduce buffer-bloating which I happily see when doing high
> payload pings. (I think on high traffic you will reach that issue also with this
> workaround, it's just not likely.)
> 
> ---
> 
> HOW TO REPRODUCE:
> 
> It's simple, do some high payloads which makes lot tx/rcv traffic on both
> sides:
> 
> Node A:
> 
>  ping6 $IP_NODEB%6lo0 -s 60000
> 
> Node B:
> 
>  ping6 ff02::1%6lo0
> 
> that's one example, but you need to produce some transmit data on both
> nodes to see that the nodes stucks in -11 (EAGAIN) of l2cap_chan_send.
> 
> Doing that and activate "#define DEBUG" in "bluetooth/6lowpan.c". After
> some time Node A print outs (depends on ping6 implementation, iputils in
> my case):
> 
> .... icmp_seq=33 Destination unreachable: Address unreachable
> 
> also on Node B, there comes maybe never a responds from Node B
> anymore. Then it's likely that you hit the deadlock.
> 
> Now run dmesg on both nodes, you will see each transmit
> (l2cap_chan_send) ends in:
> 
> "transmit return value -11"
> 
> if this will be printed out via dmesg on both nodes, you hit the deadlock and
> nothing will be transmitted anymore. I need bluetooth experts to solve this
> issue. :-)
> 
> Otherwise I detected no issues yet, also I tried to remove my usb dongle
> while high tx/rcv bandwidth at runtime from the qemu vm without crashing
> the kernel (very important test for me).
> 
> - Alex
> 
> Alexander Aring (20):
>   6lowpan: ndisc: don't remove short address
>   nhc: add TODO for nhc work
>   ieee802154: 6lowpan: remove headroom check
>   ieee802154: 6lowpan: move skb cb BUILD_BUG_ON check
>   6lowpan: remove LOWPAN_IPHC_MAX_HEADER_LEN
>   6lowpan: hold netdev while unregister
>   6lowpan: introduce generic default naming
>   6lowpan: move rx defines to generic
>   bluetooth: introduce l2cap_hdev_chan_connect
>   bluetooth: add hci dev notifier
>   bluetooth: export functions and variables
>   6lowpan: bluetooth: remove implementation
>   ieee802154: 6lowpan: move header create to 6lowpan
>   6lowpan: move dev_init to generic
>   6lowpan: iphc: override l2 packet information
>   ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration
>   6lowpan: iphc: add handling for btle
>   6lowpan: move multicast flags to generic
>   6lowpan: delete addr_len handling to generic
>   6lowpan: bluetooth: add new implementation
> 
>  include/net/6lowpan.h              |   30 +-
>  include/net/bluetooth/hci_core.h   |   14 +
>  include/net/bluetooth/l2cap.h      |    3 +
>  net/6lowpan/core.c                 |   47 +-
>  net/6lowpan/iphc.c                 |  111 +++
>  net/6lowpan/ndisc.c                |    2 -
>  net/6lowpan/nhc.c                  |   15 +
>  net/bluetooth/6lowpan.c            | 1788 ++++++++++++++----------------------
>  net/bluetooth/hci_core.c           |   26 +
>  net/bluetooth/hci_sock.c           |    2 +
>  net/bluetooth/l2cap_core.c         |   29 +-
>  net/ieee802154/6lowpan/6lowpan_i.h |    9 -
>  net/ieee802154/6lowpan/core.c      |   23 +-
>  net/ieee802154/6lowpan/tx.c        |   94 +-
>  net/ipv6/addrconf.c                |   19 +-
>  15 files changed, 1008 insertions(+), 1204 deletions(-)
> 
> --
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

I have tested the patch series with all 20 patches and verified that I can connect to devices and communicate between them over IPv6. Multicast and unicast where tested.
The neighbors where manually added with the command "ip -6 neigh". However I did not do a long run or thoroughly test, but did the basic verification.
I really liked the way the HCI device was manually selected for the interface, giving me flexibility to choose what connections I wanted on a given HCI device.

Thanks a lot for the effort you have put into this! 

Cheers,
Glenn Ruben Bakke
