Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37338 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964803AbbLOLIt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 15 Dec 2015 06:08:49 -0500
Date: Tue, 15 Dec 2015 12:08:41 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv4 bluetooth-next 1/2] 6lowpan: iphc: add support for
 stateful compression
Message-ID: <20151215110835.GA3774@omega>
References: <1450101654-22633-1-git-send-email-alex.aring@gmail.com>
 <1450101654-22633-2-git-send-email-alex.aring@gmail.com>
 <AB80DA35A7B64E4E98291794926897D9011B97546F@MBX03.nvlsi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AB80DA35A7B64E4E98291794926897D9011B97546F@MBX03.nvlsi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Duda, Lukasz" <Lukasz.Duda@nordicsemi.no>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "mcr@sandelman.ca" <mcr@sandelman.ca>, "martin.gergeleit@hs-rm.de" <martin.gergeleit@hs-rm.de>

On Tue, Dec 15, 2015 at 10:29:51AM +0000, Duda, Lukasz wrote:
> First of all great work for your series of patches on 6lowpan improvements and
> stateful compression! 
> 
> I have just done some testing of this patch (without RADVD modifications), and
> I can share my experiments using 6LoWPAN over BT-LE by sending simple ICMPv6
> messages. Contexts for BTLE device has been added manually.
> 

did you test that with linux <-> linux? Or linux <->
$SOME_OTHER_6LOWPAN_BTLE_STACK.

I tested it on my side with RIOT, it has 802.15.4 6LoWPAN support and
also manipulate manually the context table.

> Experiment 1:
> 
> Router: 2001:db8::1/64 BTLE: 2001:db8::211:22FF:FE33:4455/64
> CID 1: 2001:db8::/64
> 
> Works fine, I see that CID 1 is used for both addresses. Router has 64 bits of
> IID inline and BTLE node has 0.
> 
> Experiment 2:
> 
> Router: 2001:db8::1/64 BTLE: 2001:db8::211:22FF:FE33:4455/64
> CID 3: 2001:db8::/64 CID 5: 2001:db8::1/128
> 
> Works also fine, I see that both CID 3 and 5 are used, as well as both sides
> compress its IID in the best possible way. So the patch appears to work fine on
> 6LoWPAN over BT-LE.
> 

ok.

> 
> However, I notice that the folder created in the sys/kernel/debug/6lowpan/ for
> my bluetooth network interface is called "bt%d". And I would imagine this
> should be "bt0", "bt1", ... and not the template?
> 

urgh, this should not happen. I use "dev->name" for that and dev is the
netdevice structure. This should be an _unique_ interface name,
otherwise you will getting trouble if you have two btle 6lowpan
interfaces.

I didn't realized it because I create my interface with:

ip link add link wpan0 name lowpan0 type lowpan

but should change it into:

ip link add link wpan0 name lowpan%d type lowpan

I realized that the dev->name will be changed from template into "real"
name after registering. This should do the job:

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index c7f06f5..faf65ba 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -29,13 +29,13 @@ int lowpan_register_netdevice(struct net_device *dev,
 
        lowpan_priv(dev)->lltype = lltype;
 
-       ret = lowpan_dev_debugfs_init(dev);
+       ret = register_netdevice(dev);
        if (ret < 0)
                return ret;
 
-       ret = register_netdevice(dev);
+       ret = lowpan_dev_debugfs_init(dev);
        if (ret < 0)
-               lowpan_dev_debugfs_exit(dev);
+               unregister_netdevice(dev);
 
        return ret;
 }

I think it should be safe to do that after registering because we held the
RTNL lock. And the interface isn't up after registering.

> Also, I notice that the compression for Flow Control and Traffic Label in IPv6
> header has been modified, these fields are no longer compressed in any packets
> (0b11 value) that comes from Linux Kernel (e.g. ICMP Echo Request,
> Router Advertisement), instead I get three extra bytes (0b01 value).
> I would like to understand reason for this modification a little better.

0b11 means that traffic class and flow label are zero. Are you sure that
these fields are zero inside the IPv6 header when you transmit
"e.g. ICMP Echo Request, RA"?

Can you verify this by running tcpdump/wireshark? Or instruments some
printk's at [0] for hdr->flow_lbl array and hdr->priority?

- Alex

[0] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L428
