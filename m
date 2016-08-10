Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39290
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbcHJSGv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2016 14:06:51 -0400
Subject: Re: [PATCH wpan-misc 5/5] website: add SOB for sending patches
References: <20160807153324.9642-1-aar@pengutronix.de>
 <20160807153324.9642-5-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <8fd76365-8cb8-9e7a-e5f6-47d78c49f49c@osg.samsung.com>
Date: Wed, 10 Aug 2016 14:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <20160807153324.9642-5-aar@pengutronix.de>
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
> index 5b2f7d5..1c414bd 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -271,7 +271,7 @@ cd wpan-misc/website
>  git checkout -b myproposal
>  # Change this page to whatever you like.
>  $EDITOR index.txt
> -git commit -a
> +git commit -s -a
>  # be sure to be registered to linux-wpan@vger.kernel.org before sending the
>  # patch
>  git send-email --to linux-wpan@vger.kernel.org -1
>



Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
