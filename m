Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54915 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756650AbcHDNRi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Aug 2016 09:17:38 -0400
Subject: Re: [PATCHv2 linux-wpan/radvd for-upstream 2/2] device-linux: get
 address length via netlink
References: <20160804130932.4429-1-aar@pengutronix.de>
 <20160804130932.4429-4-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <2dc2bf28-9e1d-b6e5-d20c-e0d0e94c8f05@pengutronix.de>
Date: Thu, 4 Aug 2016 15:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <20160804130932.4429-4-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org


Hi,

On 08/04/2016 03:09 PM, Alexander Aring wrote:
> This patch adds a mechanism to get the device address length via
> netlink. This is necessary for device type 6LoWPAN which can have
> different device address lengths.
> ---
>  device-linux.c | 16 +++++++++++++--
>  netlink.c      | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  netlink.h      |  1 +
>  3 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/device-linux.c b/device-linux.c
> index 7301927..1ccb207 100644
> --- a/device-linux.c
> +++ b/device-linux.c
> @@ -17,6 +17,7 @@
>  #include "radvd.h"
>  #include "defaults.h"
>  #include "pathnames.h"
> +#include "netlink.h"
>  
>  #ifndef IPV6_ADDR_LINKLOCAL
>  #define IPV6_ADDR_LINKLOCAL   0x0020U
> @@ -84,8 +85,19 @@ int update_device_info(int sock, struct Interface *iface)
>  		break;
>  #endif				/* ARPHDR_ARCNET */
>  	case ARPHRD_6LOWPAN:
> -		iface->sllao.if_hwaddr_len = 64;
> -		iface->sllao.if_prefix_len = 64;
> +#ifdef HAVE_NETLINK
> +		/* hwaddr length differs on some L2 type lets detect them */
> +		iface->sllao.if_hwaddr_len = netlink_get_device_addr_len(iface);
> +		if (iface->sllao.if_hwaddr_len != -1) {
> +			iface->sllao.if_hwaddr_len *= 8;
> +			iface->sllao.if_prefix_len = 64;
> +		} else {
> +			iface->sllao.if_prefix_len = -1;
> +		}
> +#else
> +		iface->sllao.if_hwaddr_len = -1;
> +		iface->sllao.if_prefix_len = -1;
> +#endif
>  		break;
>  	default:
>  		iface->sllao.if_hwaddr_len = -1;
> diff --git a/netlink.c b/netlink.c
> index 80d2254..d07a0b8 100644
> --- a/netlink.c
> +++ b/netlink.c
> @@ -32,6 +32,70 @@
>  #define SOL_NETLINK	270
>  #endif
>  
> +struct iplink_req {
> +	struct nlmsghdr		n;
> +	struct ifinfomsg	i;
> +	char			buf[1024];
> +};
> +
> +int netlink_get_device_addr_len(struct Interface *iface)
> +{
> +	struct iplink_req req = {};
> +	struct iovec iov = { &req, sizeof(req) };
> +	struct sockaddr_nl sa = {};
> +	struct msghdr msg = { (void *)&sa, sizeof(sa), &iov, 1, NULL, 0, 0 };
> +	int sock, len, addr_len = -1;
> +	unsigned short type;
> +	char answer[32768];
> +	struct rtattr *tb;
> +
> +	/* nl_pid (for linux kernel) and nl_groups (unicast) should be zero */
> +	sa.nl_family = AF_NETLINK;
> +	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
> +	req.n.nlmsg_flags = NLM_F_REQUEST;
> +	req.n.nlmsg_type = RTM_GETLINK;
> +	req.i.ifi_index = iface->props.if_index;
> +
> +	sock = netlink_socket();
> +	if (sock == -1)
> +		return -1;
> +
> +	len = sendmsg(sock, &msg, 0);
> +	if (len == -1) {
> +		flog(LOG_ERR, "netlink: sendmsg for addr_len failed: %s", strerror(errno));
> +		close(sock);

need to be removed.

> +		goto out;
> +	}
> +
> +	iov.iov_base = answer;
> +	iov.iov_len = sizeof(answer);
> +	len = recvmsg(sock, &msg, 0);
> +	if (len == -1) {
> +		flog(LOG_ERR, "netlink: recvmsg for addr_len failed: %s", strerror(errno));
> +		close(sock);

same here.

> +		goto out;
> +	}
> +
> +	if (len < NLMSG_LENGTH(sizeof(struct ifinfomsg)))
> +		goto out;
> +	len -= NLMSG_LENGTH(sizeof(struct ifinfomsg));
> +
> +	tb = (struct rtattr *)(answer + NLMSG_LENGTH(sizeof(struct ifinfomsg)));
> +	while (RTA_OK(tb, len)) {
> +		type = tb->rta_type & ~NLA_F_NESTED;
> +		if (type == IFLA_ADDRESS) {
> +			addr_len = RTA_PAYLOAD(tb);
> +			break;
> +		}
> +		tb = RTA_NEXT(tb, len);
> +	}
> +
> +out:
> +	close(sock);

will be done here.

I will fix that before sending the pull-request if everything else is
fine enough. :-)

- Alex

