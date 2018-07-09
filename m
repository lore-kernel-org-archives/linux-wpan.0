Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53431 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeGIItL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Jul 2018 04:49:11 -0400
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
References: <20180607140802.22666-1-peron.clem@gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
Date: Mon, 9 Jul 2018 10:49:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180607140802.22666-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Romuald Cari <romuald.cari@devialet.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>

Hello Clement.

Finally coming to review the patch. Sorry for the delay.

On 07.06.2018 16:08, Clément Péron wrote:
> From: Romuald CARI <romuald.cari@devialet.com>
> 
> The Link Quality Indication data exposed by drivers could not be accessed from
> userspace. Since this data is per-datagram received, it makes sense to make it
> available to userspace application through the ancillary data mechanism in
> recvmsg rather than through ioctls. This can be activated using the socket
> option WPAN_WANTLQI under SOL_IEEE802154 protocol.

I can see that it makes the application life a lot easier to have data
send out and LQI value synced up by using the socket approach instead of
dealing with socket and ioctl's. I am good with this patch in general.

So you have some public code that uses this approach? I would be
interesting in the userspace part of yours. A demo would be fine. If the
network handling part of your application is public anyway that would be
even better. :-)

As Alex mentioned we have some socket examples in the wpa-tools package
to give people a head start when wanting to use the subsystem. Having
such a simple example for the LQI feature would really give you bonus
points. :-)

https://github.com/linux-wpan/wpan-tools/tree/master/examples

> 
> This LQI data is available in the ancillary data buffer under the SOL_IEEE802154
> level as the type WPAN_LQI. The value is an unsigned byte indicating the link
> quality with values ranging 0-255.
> 
> Signed-off-by: Romuald Cari <romuald.cari@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  include/net/af_ieee802154.h |  1 +
>  net/ieee802154/socket.c     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> index a5563d27a3eb..8003a9f6eb43 100644
> --- a/include/net/af_ieee802154.h
> +++ b/include/net/af_ieee802154.h
> @@ -56,6 +56,7 @@ struct sockaddr_ieee802154 {
>  #define WPAN_WANTACK		0
>  #define WPAN_SECURITY		1
>  #define WPAN_SECURITY_LEVEL	2
> +#define WPAN_WANTLQI		3
>  
>  #define WPAN_SECURITY_DEFAULT	0
>  #define WPAN_SECURITY_OFF	1
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index a60658c85a9a..bc6b912603f1 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -25,6 +25,7 @@
>  #include <linux/termios.h>	/* For TIOCOUTQ/INQ */
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/socket.h>
>  #include <net/datalink.h>
>  #include <net/psnap.h>
>  #include <net/sock.h>
> @@ -452,6 +453,7 @@ struct dgram_sock {
>  	unsigned int bound:1;
>  	unsigned int connected:1;
>  	unsigned int want_ack:1;
> +	unsigned int want_lqi:1;
>  	unsigned int secen:1;
>  	unsigned int secen_override:1;
>  	unsigned int seclevel:3;
> @@ -486,6 +488,7 @@ static int dgram_init(struct sock *sk)
>  	struct dgram_sock *ro = dgram_sk(sk);
>  
>  	ro->want_ack = 1;
> +	ro->want_lqi = 0;
>  	return 0;
>  }
>  
> @@ -713,6 +716,7 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	size_t copied = 0;
>  	int err = -EOPNOTSUPP;
>  	struct sk_buff *skb;
> +	struct dgram_sock *ro = dgram_sk(sk);
>  	DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_name);
>  
>  	skb = skb_recv_datagram(sk, flags, noblock, &err);
> @@ -744,6 +748,13 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		*addr_len = sizeof(*saddr);
>  	}
>  
> +	if (ro->want_lqi) {
> +		err = put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> +			       sizeof(uint8_t), &(mac_cb(skb)->lqi));
> +		if (err)
> +			goto done;
> +	}
> +

I am wondering a bit about the LQI you get back here. Maybe Alex can
also shed some lights on it. The LQI value stored here is always from
the last frame send (to any peer)? Or is it the last frame send to this
specific peer?

I have not put much thoughts into the LQI thing so far.Just thinking we
need to be careful what we are providing to not let userspace make bad
decisions (e.g. wrong routing changes due to link values given for a
different peer connection).

>  	if (flags & MSG_TRUNC)
>  		copied = skb->len;
>  done:
> @@ -847,6 +858,9 @@ static int dgram_getsockopt(struct sock *sk, int level, int optname,
>  	case WPAN_WANTACK:
>  		val = ro->want_ack;
>  		break;
> +	case WPAN_WANTLQI:
> +		val = ro->want_lqi;
> +		break;
>  	case WPAN_SECURITY:
>  		if (!ro->secen_override)
>  			val = WPAN_SECURITY_DEFAULT;
> @@ -892,6 +906,9 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
>  	case WPAN_WANTACK:
>  		ro->want_ack = !!val;
>  		break;
> +	case WPAN_WANTLQI:
> +		ro->want_lqi = !!val;
> +		break;
>  	case WPAN_SECURITY:
>  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
>  		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
> 

Review wise I am happy with the patch. I will give it a test.

regards
Stefan Schmidt
