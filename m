Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37939 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882AbcGWNnK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 23 Jul 2016 09:43:10 -0400
Subject: Re: [PATCH 3/3] ieee802154: encrypt frame before
 ieee802154_subif_start_xmit is called
References: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
 <1469207896-26481-3-git-send-email-arozansk@redhat.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <c4cf7740-21cc-17fc-5588-c46b0500944a@pengutronix.de>
Date: Sat, 23 Jul 2016 15:43:05 +0200
MIME-Version: 1.0
In-Reply-To: <1469207896-26481-3-git-send-email-arozansk@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aristeu Rozanski <arozansk@redhat.com>, linux-wpan@vger.kernel.org
Cc: Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>


Hi,

On 07/22/2016 07:18 PM, Aristeu Rozanski wrote:
> Move mac802154_llsec_encrypt() call to right before dev_queue_xmit()
> call and out of ieee802154_subif_start_xmit(). This prevents packets
> failing to send on raw sockets.
> 
> Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

Please don't use af_802154 raw sockets which are a long time broken, use
AF_PACKET raw. See as example [0] which allows to run RIOT-OS native as
elf binary in userspace and talk with the 802.15.4 6LoWPAN kernel stuff.
Also the AF_PACKET RAW will directly called xmit callback and not
dev_queue_xmit -> no qdisc is involved and mostly you like to have that
for such kind of sockets.

The socket "af_802154" should be used to doing MAC frames by kernel,
AF_PACKET DGRAM sockets has a very limited UAPI for that.

Unfortunately this will not fix your issues if you sending out raw
frames with security bits enabled.

You found the right issue because the "xmit callback" should not touch
the header again. I also had issues by using wireshark, because it
doesn't show the encrypted frame.

It's the same for rx handling where decryrption should be "somehow" done
after the packet-layer.

The issue getting even bigger (and the reason why I didn't solved it)
when you think about HardMAC transceivers.

HardMAC transceivers do encryption end decryption on transceivers side,
so on linux side we have always not encrypted frames. This issue is a
whole unsolved issue in out architecture. Maybe we should simple handle
then as "not encrypted" but then the MAC headers frame control bits need
to show that. Or we tell the userspace, "You have here a HardMAC
transceiver and please note there is no control for showing encrypted
payload while dumping e.g. in libpcap". I think it's okay to have the
frame control secbits sets there, but we need some way to tell the
userspace "there is no support for showing encrypted payload" for
HardMAC transceivers and security enabled in frames.

I had no idea for that currently, HardMAC transceivers will also
introduce some other stuff we need to do. At the moment we ignore
"HardMAC" transceivers at some points right now.

I am fine if we fix this behaviour for SoftMAC transceivers side (later
we can introduce such flag for UAPI that "encrypted payload not
supported").

> ---
>  include/net/mac802154.h     | 14 ++++++++++++++
>  net/ieee802154/6lowpan/tx.c |  4 ++--
>  net/ieee802154/socket.c     |  4 +++-
>  net/mac802154/tx.c          | 29 +++++++++++++++++------------
>  4 files changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index e465c85..ee24a0e 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -377,6 +377,20 @@ void ieee802154_wake_queue(struct ieee802154_hw *hw);
>  void ieee802154_stop_queue(struct ieee802154_hw *hw);
>  
>  /**
> + * ieee802154_finish_frame - finish a frame before queueing for transmission
> + *
> + * @skb: the buffer to be finished
> + */
> +#ifdef CONFIG_MAC802154
> +int ieee802154_finish_frame(struct sk_buff *skb);
> +#else	/* CONFIG_MAC802154 */
> +static inline int ieee802154_finish_frame(struct sk_buff *skb)
> +{
> +	return dev_queue_xmit(skb);
> +}
> +#endif	/* !CONFIG_MAC802154 */

This will not work if we later add support for running HardMAC and
SoftMAC. I tried to fix it on my own (can't find the branch anymore and
patches never get into mainline). If I remember correctly, I used a callback
but I saw then the better idea would it to move encryption to
wpan_dev_hard_header, callback.

Some parameters what for a frame we need and SoftMAC/HardMAC can be
doing (something) for that. For HardMAC I need to figure out how this
can be working then. At least wireshark/tcpdump will see the mac header
so everybody should do the same stuff there.

If both do the same stuff, it's indicate that this is for
"net/ieee802154" branch.

Another issue is that wpan_dev_hard_header callback was simpled
copy&pasted right now from the global generic "dev_hard_header" callback
which had several issues, because it was called by AF_PACKET DGRAM
sockets and this had 8 bytes limited parameters for e.g. addresses and
the callback had some out-of-bound array access there.

Nevertheless the wpan_dev_hard_header fixed it because it will called by
802.15.4 upper layers only. The bad thing is that skb->cb is still used
there, which was a workaround for "dev_hard_header" callback to extend
the callback with additional information. This should be removed, since
we have our own callback for that where we have control over it and can
add more parameters.

Everything is ugly solved and fixing this requires to fix header
creation currently. :-) I also don't know if we really needs this
callback or simple have creation functions in "net/ieee802154" which
will be called by upper layers. HardMAC drivers need to parse the frame
then and doing something that these settings for this frame will be done
on transceivers side.

It's a big TODO there.

---

Nevertheless it's okay for me to fix that on rx/tx side so the RAW
socket are really RAW sockets which sends user generated frames out
(also with secbit enabled).

But please fix this for rx/tx side and not in a way which makes the
behaviour with future HardMAC transceivers more possible.

For tx side it should be okay to move it to the end of
"wpan_dev_hard_header" callback which should be not called by AF_PACKET
raw sockets. This should be a simple fix...

For rx side it would be harder. I thought maybe there exists some
packet_layer "hook" before starting packet_type->func e.g. [1]

Do encrypt payload, so we don't need to duplicate code much... if such
hook doesn't exist then we need out own hook mechanism for
packet_type->func callback.

- Alex

[0] https://github.com/linux-wpan/RIOT/blob/26a86d6fbd5695fe56c1defb097470787922f440/cpu/native/netdev2_raw802154/netdev2_raw802154.c#L281
[1] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/rx.c#L320
