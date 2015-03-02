Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:39843 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbCBJjE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 04:39:04 -0500
Received: by wesx3 with SMTP id x3so32058721wes.6
        for <linux-wpan@vger.kernel.org>; Mon, 02 Mar 2015 01:39:03 -0800 (PST)
Date: Mon, 2 Mar 2015 10:38:56 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [linux-wpan] mac802154 development
Message-ID: <20150302093853.GA2314@omega>
References: <02E1EC3037481742A4C5830E984A9E9AA47BE3@SRV-DE08.ddel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02E1EC3037481742A4C5830E984A9E9AA47BE3@SRV-DE08.ddel.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Ludwig, Mike" <ml@dresden-elektronik.de>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Mon, Mar 02, 2015 at 08:44:12AM +0000, Ludwig, Mike wrote:
> Hi,
> 
> after a few days checking through the mainline and bluetooth-next kernel regarding ieee/mac802154 and 6LoWPAN I'm rather puzzled about the current status and future developments. 
> 

See also with what we started:

https://archive.fosdem.org/2014/schedule/event/deviot04/

What we now try to do:

https://fosdem.org/2015/schedule/event/deviot09/
(slides currently available only)

> As the mac802154 is under rework I tried to follow the lines of a hardMAC (e.g. as fakehard.ko is doing it) thereby bypassing the mac802154 business completely. I started creating a serial driver that allows the attachment of a radio over a serial line on the MAC layer interface. The netlink routines did look quite promising. 
> 

Please forget the fakehard driver, I removed the whole driver because
there was one "virtual(fake)" driver for HardMAC and the rework
contain a completely new netlink framework based on nl80211.

Maybe you don't want a HardMAC driver. What exactly is the serial
protocol can you access raw frames or some interface according 802.15.4
standard to start MLME ops?

If you can access it raw than a HardMAC driver would be wrong otherwise
there already exist a serial protocol driver. Then you need some
firmware which speaks this protocol. The driver is in a very awful state
and it's not acceptable for mainline. See [0-2].


The idea of bypassing mac802154 completely still exist. But we will now
handle it 1:1 like wireless. This means over netlink ops will call
cfg802154_ops and cfg802154_ops callbacks need to define in driver
layer. Also other things netdev registration etc...

Send patches I will review them. But maybe you need some things from
net/mac802154 to net/ieee802154. Few weeks I saw some things which
should be moved because it should affects Soft and HardMAC drivers.
I need to send patches for this, if not anybody else do it. We have
currently no HardMAC support and if you like to implement such thing I
would help you there.

> Unfortunately I'm now already stuck at the scan request - or to be more precise at the scan response. In my understanding it is always the first step for any device (FFD or RFD) to scan for existing networks. In mainline at lease the results of a ED scan can be passed back via netlink. In bluetooth-next even the scan confirmation is gone. Is this for a reason?


We have at most SoftMAC drivers mainline and the old interface only
implemented these callbacks for the HardMAC drivers.

I am not sure that you realized that there are two netlink frameworks,
one based on nl802154 (the new fantastic interface which makes no
headache) and the poor old one which nobody figured out exactly how it
works (will be removed later).

We want now to do all the same like wireless (nl80211/cfg80211) they
have similar paradigms with 802.15.4 but different technology. For
example your MLME-SCAN (okay, we have different scan types) we should
look how wireless implemented the scan for access-points. Then we can do
the same like 802.15.4 just for pans. What I will say, we have a good
code-base then.

But doing ed scan will occur that drivers can note about ed values. The
at86rf230 can't (but the transceiver can do it), we need just implement
it but at first we need to get out from "something else" in "something
which works" that's what the rework try to do.

> Moreover, to do some real work by joining an existing WPAN a pan_desciptor_list would have to be passed back to netlink. 
> I did not go further in checking on the start/associate/disassociate netlink parts as it would always be a crutch to create/join WPANs without working scans. 
> 

Yea, doing this step will do lot of work. Also for good code base look
how wireless deals with associate/disassociate with access points, then
we can do the same with coordinators. Just a little bit different
because we are 802.15.4. Again this is just to have a good code base.

> So this is more about seeking advice than implementation details. I'm quite happy to do add missing pieces to the netlink part but would like to do this in line with the rework of the MAC if this would have implications on that. It would be great if you could give me some hints on proceeding and may on the plans for the rework. I guess you already have some ideas on required changes an might point me to the right locations. Thanks a lot for your help.
> 

You want to implement a HardMAC driver. When this is true, you don't
really need to care about net/mac802154 and that's the most part in the
actual reworks since I mostly successful implemented the nl802154 framework.
You can happily add new netlink commands and new interfaces to cfg802154
and yes I would be very happy and accept patches if these are fine.
Also if you do that, don't forget to add support into the official
userspace tool. [3]


For mac802154, some parts of them will affect also the upper layers
which need then a different handling mac802154 and all HardMAC drivers.

Example (very netdev specific):

We doing at the moment all parsed mac information into the control_block
of skb and send it through the layer after calling netif_receive_skb.
This is very bad and we do it also for parsing arguments through the
dev_header_create command. I also saw situations (for sniffing) which
breaks this interface. This works for some cases but it's awful and I
will remove it.

I segmented the rework in three different parts (currently I do 2.):

1. nl802154 <--- have some TODOs but mostly working
2. crypto-layer over nl802154 <--- I am here!
3. frame parsing/creation

So doing step 3 (which I do mostly in dev branch [4]) will require at
first a working state of 2, because I can't test it right now if I break
the crypto layer. Sounds crazy, but yea we have a kernel side crypto
layer and the official userspace tool can't access it. But this is the
current state and I currently try to change it.

Again to 3. and the link at [4]. What you see is a frame parsing
mechanism like mac802154 it does. It also introduce various static
inline function which can you use for HardMAC drivers (It's simple the
same way like wireless). But I can't send it mainline currently, I will
do this after step 2.
Also the new frame parsing/creation doesn't add mac information into the
skb control_block. We need to reparse the mac header (not the FULL mac
header only what's necessary) in the upper-layers like af802154 and 6lowpan.

Also the frame parsing is only optimized for dataframes, see [4] how the
new frameparsing works. Again, it's from mac80211 and they have more
frametypes than 4. Later I want also this type for frameparsing in
6LoWPAN for evaluating dispatch values.

I am sure now that you are a little bit frustrated because there is much
work to do before we can implement some 802.15.4 MAC functionality...
but if you want to use a HardMAC driver then it's not much work. In few
months I will only break the interface between L2 and L3 but then I
would try to keep your driver still working.


btw: I will update the website for that 2. need to be done before we can
starting 3.

- Alex

[0] http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/SerialV1
[1] https://github.com/linux-wpan/ieee802154-serial-protocol-version2 (draft only)
[2] https://github.com/linux-wpan/linux-wpan-next/commit/546618171de2be30236aab86f3ee323b425e2bf5
[3] https://github.com/linux-wpan/wpan-tools
[4] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c
