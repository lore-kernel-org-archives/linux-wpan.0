Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbcGYNie (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 09:38:34 -0400
Date: Mon, 25 Jul 2016 09:38:32 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: Re: [PATCH 3/3] ieee802154: encrypt frame before
 ieee802154_subif_start_xmit is called
Message-ID: <20160725133831.GF30145@redhat.com>
References: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
 <1469207896-26481-3-git-send-email-arozansk@redhat.com>
 <c4cf7740-21cc-17fc-5588-c46b0500944a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cf7740-21cc-17fc-5588-c46b0500944a@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi Alexander,
On Sat, Jul 23, 2016 at 03:43:05PM +0200, Alexander Aring wrote:
> Please don't use af_802154 raw sockets which are a long time broken, use
> AF_PACKET raw. See as example [0] which allows to run RIOT-OS native as
> elf binary in userspace and talk with the 802.15.4 6LoWPAN kernel stuff.
> Also the AF_PACKET RAW will directly called xmit callback and not
> dev_queue_xmit -> no qdisc is involved and mostly you like to have that
> for such kind of sockets.
> 
> The socket "af_802154" should be used to doing MAC frames by kernel,
> AF_PACKET DGRAM sockets has a very limited UAPI for that.

my idea using it was to have the MAC implemented in userspace and use
raw sockets to interface with existing drivers.

> Unfortunately this will not fix your issues if you sending out raw
> frames with security bits enabled.
>
> You found the right issue because the "xmit callback" should not touch
> the header again. I also had issues by using wireshark, because it
> doesn't show the encrypted frame.
> 
> It's the same for rx handling where decryrption should be "somehow" done
> after the packet-layer.

I haven't notice that yet, still trying to work out sending and
receiving frames without encryption.

> The issue getting even bigger (and the reason why I didn't solved it)
> when you think about HardMAC transceivers.
> 
> HardMAC transceivers do encryption end decryption on transceivers side,
> so on linux side we have always not encrypted frames. This issue is a
> whole unsolved issue in out architecture. Maybe we should simple handle
> then as "not encrypted" but then the MAC headers frame control bits need
> to show that. Or we tell the userspace, "You have here a HardMAC
> transceiver and please note there is no control for showing encrypted
> payload while dumping e.g. in libpcap". I think it's okay to have the
> frame control secbits sets there, but we need some way to tell the
> userspace "there is no support for showing encrypted payload" for
> HardMAC transceivers and security enabled in frames.
> 
> I had no idea for that currently, HardMAC transceivers will also
> introduce some other stuff we need to do. At the moment we ignore
> "HardMAC" transceivers at some points right now.
> 
> I am fine if we fix this behaviour for SoftMAC transceivers side (later
> we can introduce such flag for UAPI that "encrypted payload not
> supported").
> 
> This will not work if we later add support for running HardMAC and
> SoftMAC. I tried to fix it on my own (can't find the branch anymore and
> patches never get into mainline). If I remember correctly, I used a callback
> but I saw then the better idea would it to move encryption to
> wpan_dev_hard_header, callback.
> 
> Some parameters what for a frame we need and SoftMAC/HardMAC can be
> doing (something) for that. For HardMAC I need to figure out how this
> can be working then. At least wireshark/tcpdump will see the mac header
> so everybody should do the same stuff there.
> 
> If both do the same stuff, it's indicate that this is for
> "net/ieee802154" branch.
> 
> Another issue is that wpan_dev_hard_header callback was simpled
> copy&pasted right now from the global generic "dev_hard_header" callback
> which had several issues, because it was called by AF_PACKET DGRAM
> sockets and this had 8 bytes limited parameters for e.g. addresses and
> the callback had some out-of-bound array access there.
> 
> Nevertheless the wpan_dev_hard_header fixed it because it will called by
> 802.15.4 upper layers only. The bad thing is that skb->cb is still used
> there, which was a workaround for "dev_hard_header" callback to extend
> the callback with additional information. This should be removed, since
> we have our own callback for that where we have control over it and can
> add more parameters.
> 
> Everything is ugly solved and fixing this requires to fix header
> creation currently. :-) I also don't know if we really needs this
> callback or simple have creation functions in "net/ieee802154" which
> will be called by upper layers. HardMAC drivers need to parse the frame
> then and doing something that these settings for this frame will be done
> on transceivers side.
> 
> It's a big TODO there.

Thanks for the explanation, as someone starting working with this it
saves me a ton of time! Much appreciated!

> Nevertheless it's okay for me to fix that on rx/tx side so the RAW
> socket are really RAW sockets which sends user generated frames out
> (also with secbit enabled).
> 
> But please fix this for rx/tx side and not in a way which makes the
> behaviour with future HardMAC transceivers more possible.
> 
> For tx side it should be okay to move it to the end of
> "wpan_dev_hard_header" callback which should be not called by AF_PACKET
> raw sockets. This should be a simple fix...
> 
> For rx side it would be harder. I thought maybe there exists some
> packet_layer "hook" before starting packet_type->func e.g. [1]
> 
> Do encrypt payload, so we don't need to duplicate code much... if such
> hook doesn't exist then we need out own hook mechanism for
> packet_type->func callback.

I'll take a look on it and see if I can come with an acceptable
solution.
Thanks!

-- 
Aristeu

