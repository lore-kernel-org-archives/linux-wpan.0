Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:48136 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbdJZOyC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Oct 2017 10:54:02 -0400
Received: by mail-ua0-f194.google.com with SMTP id z4so2660468uaz.5
        for <linux-wpan@vger.kernel.org>; Thu, 26 Oct 2017 07:54:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171018122705.25478-1-patrik.flykt@linux.intel.com>
References: <20171018120615.24126-3-patrik.flykt@linux.intel.com>
 <20171018120615.24126-4-patrik.flykt@linux.intel.com> <20171018122705.25478-1-patrik.flykt@linux.intel.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 26 Oct 2017 10:54:01 -0400
Message-ID: <CAOHTApijss4n7r6tr7oMdGGduzVs-Hx=s0r5uL4+ACX1d=ePFw@mail.gmail.com>
Subject: Re: [RFC 3/3] tun: Add 6LoWPAN compression/decompression to tun driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Patrik Flykt <patrik.flykt@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan - ML <linux-wpan@vger.kernel.org>, luiz.von.dentz@intel.com, Jamal Hadi Salim <hadi@mojatatu.com>, Stefan Schmidt <stefan@osg.samsung.com>, mcr@sandelman.ca

Hi,

First: I always asked myself: 6LoTUN makes no sense because 6LoWPAN
depends on MAC information and TUN interfaces works because IPv6
doesn't depend on MAC information. Now everything is more clear, this
has nothing todo with TUN it's TAP because you use ethernet MAC
information to do 6LoWPAN stuff.

On Wed, Oct 18, 2017 at 8:27 AM, Patrik Flykt
<patrik.flykt@linux.intel.com> wrote:
> Define a new IFF_6LO flag for the tun/tap driver that enables 6LoWPAN
> compression/decompression for tap devices. This is achieved by calling
> lowpan_header_compress once the sk_buff is destined for user space and
> calling lowpan_header_decompress when the user space writes packets to
> kernel. A copy of the ethernet MAC headers are needed both ways, as
> the 6LoWPAN compression may end up expanding the header size by one
> byte in the worst case.
>
> LOWPAN_IPHC_MAX_HC_BUF_LEN more bytes are added to sk_buff headroom
> to ensure there will be enough bytes to push headers to. This is
> probably an overkill and probably done wrongly anyway.
>
This define should be removed because there exists no case where the
compression will be larger than the ipv6 header and vice versa.


> An ethernet MAC header is added in front of the (compressed) IPv6
> datagram in both directions; no such transport exists for 6LoWPAN,
> but this is just an example implementation trying to explain the
> idea behind the BTLE handling in user space and the 6LoWPAN
> compression and decompression in kernel space. Thus the tun/tap
> driver comes in handy as the victim of the demonstration.
>

Sorry but this really scares me. The kernel use 6LoWPAN IPHC for
ethernet (as mac header information) and you doing BTLE/L2CAP stuff in
user space which is not anymore for your original use-case which is
"ethernet".
This might work for now, because only address handling is used in IPHC
as MAC header information and eth/btle use the same address length
(besides that the address is not always the same and BTLE is not a
EUI-48 address with multicast bit etc.)
You cannot simple use MAC X handling in kernelspace and use then MAC
handling Y in userspace - this will not work for long time. I already
fight with UDP based protocols in 802.15.4 6LoWPAN who depends on
802.15.4 MAC information which are not just addressing information. If
they need more bluetooth related information there you have no
possibility to get them. The same for next header compression which
might want more MAC information than just addressing for bluetooth.

> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
>
>         Hi,
>
> This is the one applying on fac72b24.
>
>
>      Patrik
>
>
>  drivers/net/tun.c           | 61 +++++++++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/if_tun.h |  1 +
>  2 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 57e4c31fa84a..11b6494bb7ca 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -66,6 +66,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/virtio_net.h>
>  #include <linux/rcupdate.h>
> +#include <net/6lowpan.h>
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
>  #include <net/rtnetlink.h>
> @@ -231,6 +232,8 @@ struct tun_struct {
>         u32 rx_batched;
>         struct tun_pcpu_stats __percpu *pcpu_stats;
>         struct bpf_prog __rcu *xdp_prog;
> +
> +       struct lowpan_dev       ldev;
>  };
>
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
> @@ -1071,6 +1074,9 @@ static void tun_set_headroom(struct net_device *dev, int new_hr)
>                 new_hr = NET_SKB_PAD;
>
>         tun->align = new_hr;
> +
> +       if ((tun->flags & (IFF_TAP|IFF_6LO)) == (IFF_TAP|IFF_6LO))
> +               tun->align += LOWPAN_IPHC_MAX_HC_BUF_LEN;
>  }
>
>  static void
> @@ -1697,6 +1703,27 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                 skb->dev = tun->dev;
>                 break;
>         case IFF_TAP:
> +               if (tun->flags & IFF_6LO) {
> +                       struct ethhdr eth;
> +
> +                       skb_reset_mac_header(skb);
> +                       memcpy(&eth, skb_mac_header(skb), sizeof(eth));
> +
> +                       skb_pull(skb, sizeof(struct ethhdr));
> +                       skb_reset_network_header(skb);
> +
> +                       if (lowpan_header_decompress(skb, &tun->ldev,
> +                                                       tun->dev->dev_addr,
> +                                                       &eth.h_source) < 0) {

This will make a module dependency of 6lowpan_iphc for the tap driver.
I am pretty sure that the tap driver people doesn't like that. Which
brings me to another issue with this patch:
Why you don't create a virtual lowpan interface on top of the tap
device. This handling is _incredibly_ against our design to have a
6LoWPAN interface device type for the user space.
Now we have will have a tap device which makes internally 6LoWPAN
handling but is not visible as 6LoWPAN interface in the user space,
this will confuse 6LoWPAN user space applications.

What our design is (just to remember):
 - Ethernet interface (MAC/6LoWPAN view, before adaption)
 - 6LoWPAN interface (IPv6 view, after adaption)

I am pretty sure you can run your above changes transparently
separated of TAP driver by adding a 6LoWPAN interface on top. This
will also make no dependency to the TAP driver.

I guess what you want is a TAP interface which is NOT ethernet. It
need to get some special MAC information for your subsystem which is
BTLE. Not using ethernet here. To have the assumption here "it will
work because the address length is the same" is simple wrong, they
will be more use-cases where upper-layers need to have special MAC
information belongs to your link-layer subsystem.
So, my guess, the bluetooth subsystem need some TAP like
interface(hci) maybe? 6LoWPAN has nothing to do with ethernet yet. You
need to put more logic in your link-layer subsystem to adapt ideas
from other link-layer subsystems which has no 6LoWPAN support at all.

- Alex
