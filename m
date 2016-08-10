Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39286
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcHJSGv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2016 14:06:51 -0400
Subject: Re: [PATCH wpan-misc 3/5] website: fix typo
References: <20160807153324.9642-1-aar@pengutronix.de>
 <20160807153324.9642-3-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <2578745d-2de5-6743-4ebd-c0c86ad21cab@osg.samsung.com>
Date: Wed, 10 Aug 2016 14:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <20160807153324.9642-3-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org

Hello.

On 07/08/16 17:33, Alexander Aring wrote:
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  website/index.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/website/index.txt b/website/index.txt
> index 5d9793a..1dcdf32 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -81,7 +81,7 @@ ip link add link wpan0 name lowpan0 type lowpan
>  That's it! Now you have some lowpan0 interface with a 6LoWPAN 1280 MTU which runs on top the wpan interface.
>  As default you have a default link-local address based on the MAC (extended address).
>
> -Setup a 6LowPAN test network
> +Setup a 6LoWPAN test network
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  Let's assume you want to setup a 6lowpan test network of six nodes.
>



Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
