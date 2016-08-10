Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39288
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbcHJSGv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2016 14:06:51 -0400
Subject: Re: [PATCH wpan-misc 2/5] website: remove note about missing short
 address functionality
References: <20160807153324.9642-1-aar@pengutronix.de>
 <20160807153324.9642-2-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <6a2b55d8-a715-acca-b16a-555fdf372f08@osg.samsung.com>
Date: Wed, 10 Aug 2016 14:08:29 +0200
MIME-Version: 1.0
In-Reply-To: <20160807153324.9642-2-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org

Hello.

On 07/08/16 17:33, Alexander Aring wrote:
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  website/index.txt | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/website/index.txt b/website/index.txt
> index 1438c6e..5d9793a 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -81,11 +81,6 @@ ip link add link wpan0 name lowpan0 type lowpan
>  That's it! Now you have some lowpan0 interface with a 6LoWPAN 1280 MTU which runs on top the wpan interface.
>  As default you have a default link-local address based on the MAC (extended address).
>
> -Note: we don't support any case of short-addresses right now. This is a complicated issue with the IPv6 neighbour discovery cache.
> -Of course we supporting broadcast frames via short-addresses but nothing more in 802.15.4 6LoWPAN.
> -Only extended address handling is supported right now.
> -
> -
>  Setup a 6LowPAN test network
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>




Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
