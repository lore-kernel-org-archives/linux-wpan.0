Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:35956 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbaI0Bmy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 21:42:54 -0400
Received: by mail-we0-f171.google.com with SMTP id k48so10352828wev.30
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 18:42:52 -0700 (PDT)
Date: Sat, 27 Sep 2014 03:42:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140927014243.GA26666@omega>
References: <54258332.2010004@xsilon.com>
 <20140926153521.GA7643@omega>
 <542593AC.4060901@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542593AC.4060901@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Fri, Sep 26, 2014 at 05:26:20PM +0100, Simon Vincent wrote:
> I think we need to add some filtering so we don't process packets addressed
> to other nodes, just pass them to the promiscuous mode buffer. I will have a
> look next week at a fix.
> 

yes, but by handling of mac802154 you activate a filter -> no promiscuous mode.
In 802.15.4 promiscuous mode you don't have any stack handling involved.

The requirement to offer a promiscuous mode is no doing filtering at phy
level. After this no mac802154 handling is involved, if mac802154 is
invloded means you doing filtering.

802.15.4-2011 describes to promiscuous mode:

"When in promiscuous mode, the MAC sublayer shall process received frames according to 5.1.6.2 and
pass all frames correctly received to the next higher layer using the MCPS-DATA.indication primitive. The
source and destination addressing mode parameters shall each be set to 0x00, the MSDU parameter shall
contain the MHR concatenated with the MAC payload, as illustrated in Figure 35, and the msduLength
parameter shall contain the total number of octets in the MHR concatenated with the MAC payload. The
mpduLinkQuality parameter shall be valid."

Section 5.1.6.2 describes mainly the filtering when mac pib value
macPromiscuousMode is set to FALSE. Means when TRUE -> not doing any
filtering according section 5.1.6.2

There is no much text about promiscuous mode in 802.15.4 I also see that
the at86rf231 disable ACK handling there, this means that the
promiscuous mode will never send ack's if the phy get frames which
matching on hardware address filters. Also the address filters should be
set to short_addr -> 0xffff, pan_id -> 0xffff which are the mac pib default
parameters. These are all indicators that it's only in receiving mode
the packets should not handled by mac802154 layer.

Sending frames is another question, I think you probably can do that,
but only on some 802.15.4 RAW sockets, that you can build your own mac
header in userspace. You can't interact in the network, but sending
frames to make some chaos in the network should work. Maybe for testing
use case or other crazy stuff.

What you have is only the a poor phy without filtering features. That's
the requirement for running in promiscuous, but when mac802154 is
involved it's not promiscuous mode. I have the option at at86rf231 to
set it in promiscuous mode and do other settings like "enable ack
handling and setting hw filtering (NOT for FILTERing frames, just for
AACK handling stuff) then I have that what you have but it isn't exactly
promiscuous mode according 802.15.4.

Now I confusing all people now, but currently this is my point of view. :-)

> On 26/09/14 16:35, Alexander Aring wrote:
> >Hi Simon,
> >
> >On Fri, Sep 26, 2014 at 04:16:02PM +0100, Simon Vincent wrote:
> >>I have three nodes running linux all running in promiscuous mode with ipv6
> >Sorry I need to ask here, why it's in promiscuous mode? It's still
> >(mainline) a WPAN device? I don't know right now what changes you did
> >because at mainline state we don't have any support for running any
> >device into promiscuous mode.
> >
> It is in promiscuous mode as the hardware does not support address filtering
> yet...
> >>forwarding enabled. The kernel is built from wpan-next. The three nodes are
> >>all connected directly using 802.15.4.
> >>
> >>Node A: fe80::203:9a00:0:a
> >>Node B: fe80::203:9a00:0:b
> >>Node C: fe80::203:9a00:0:c
> >>
> >>If from node A I ping node B I get ICMP redirects from node C. Node C also
> >>forwards the packet to node B so node B receives the ping request twice.
> >>
> >I have also 3 nodes here, maybe I can reproduce this scenario to help
> >there. Can you give me some setup steps for this?
> Just setup any three nodes so they can all see each other and setup a
> wireshark sniffer.
> Enable ipv6 forwarding by:
> echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
> I guess you will also have to hack your hardware driver to put your hardware
> in promiscuous mode.
> 
> Then just do a simple ping from one node to another using link local
> addresses.

ok, I will see if I can reproduce this. Thanks.

- Alex
