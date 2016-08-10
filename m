Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39287
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbcHJSGv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2016 14:06:51 -0400
Subject: Re: [PATCH wpan-misc 1/5] website: update testing scripts for netns
References: <20160807153324.9642-1-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <88d62949-0be7-9807-4721-24d2fe8a2121@osg.samsung.com>
Date: Wed, 10 Aug 2016 14:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <20160807153324.9642-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org

Hello.

On 07/08/16 17:33, Alexander Aring wrote:
> Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  website/index.txt | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/website/index.txt b/website/index.txt
> index 65c6b9c..1438c6e 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -90,8 +90,13 @@ Setup a 6LowPAN test network
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  Let's assume you want to setup a 6lowpan test network of six nodes.
> +Each of them will be created in their own net namespace to avoid
> +local IPv6 optimizations. Each netns is named according to the wpan
> +interface which available in the net namespace.
>
>  ---------------------------------------------------------------------
> +#!/bin/sh
> +
>  # we need some Private Area Network ID
>  panid="0xbeef"
>  # number of nodes
> @@ -102,25 +107,26 @@ numnodes=6
>  modprobe fakelb numlbs=$numnodes
>
>  # initialize all the nodes
> -for i in $(seq 0 $numnodes);
> +for i in $(seq 0 `expr $numnodes - 1`);
>  do
> -	iwpan dev wpan${i} set pan_id 0xbeef
> -	ip link wpan${i} name lowpan${i} type lowpan
> -	ip link set wpan${i} up
> -	ip link set lowpan${i} up
> +	ip netns delete wpan${i}
> +	ip netns add wpan${i}
> +	PHYNUM=`iwpan dev | grep -B 1 wpan${i} | sed -ne '1 s/phy#\([0-9]\)/\1/p'`
> +	iwpan phy${PHYNUM} set netns name wpan${i}
> +
> +	ip netns exec wpan${i} iwpan dev wpan${i} set pan_id $panid
> +	ip netns exec wpan${i} ip link add link wpan${i} name lowpan${i} type lowpan
> +	ip netns exec wpan${i} ip link set wpan${i} up
> +	ip netns exec wpan${i} ip link set lowpan${i} up
>  done
>  ---------------------------------------------------------------------
>
>  Now let us send some data over our network:
>
>  ---------------------------------------------------------------------
> -wireshark -kSl -i lowpan0 &
> -# get the IPv6 address of lowpan1
> -lowpan1addr="$(ip addr show lowpan1 | grep inet6 \
> -	| sed 's,.*inet6 \([^/]*\).*,\1,')"
> -# tell ping6 to ping the IPv6 address of lowpan1 and send it via
> -# lowpan0
> -ping6 ${lowpan1addr}%lowpan0
> +ip netns exec wpan0 wireshark -kSl -i lowpan0 &
> +# ping all nodes
> +ip netns exec wpan0 ping6 ff02::1%lowpan0
>  ---------------------------------------------------------------------
>
>  Now watch wireshark and all the nice ICMP packets there.
>



Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
