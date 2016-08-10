Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39289
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbcHJSGv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2016 14:06:51 -0400
Subject: Re: [PATCH wpan-misc 4/5] website: add boards with transceiver
 section
References: <20160807153324.9642-1-aar@pengutronix.de>
 <20160807153324.9642-4-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <682b277e-9ae6-f2df-159d-1b0cde088ebd@osg.samsung.com>
Date: Wed, 10 Aug 2016 14:10:30 +0200
MIME-Version: 1.0
In-Reply-To: <20160807153324.9642-4-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org

Hello.

On 07/08/16 17:33, Alexander Aring wrote:
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  website/index.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/website/index.txt b/website/index.txt
> index 1dcdf32..5b2f7d5 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -52,6 +52,13 @@ Supported Hardware
>  |Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]
>  |=============================================================
>
> +.Boards with Transceivers
> +|=============================================================
> +|Name        | Transceiver |Website
> +|Ci40        | ca8210      |https://www.kickstarter.com/projects/imgtec/creator-ci40-the-ultimate-iot-in-a-box-dev-kit[kickstarter]
> +|blixten     | cc2520      |https://jopee.wordpress.com/6lowpan-gateway/[jopee]
> +|=============================================================
> +
>  How-To's
>  --------



Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
