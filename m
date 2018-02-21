Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:61604 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935499AbeBUOIh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 21 Feb 2018 09:08:37 -0500
Subject: Re: [PATCH] website: Add troubleshooting section in how-tos
References: <20180218230316.GA8719@picapica.im>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <1dd13aca-fc2d-82fb-821e-3b1994f26930@osg.samsung.com>
Date: Wed, 21 Feb 2018 15:08:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180218230316.GA8719@picapica.im>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im, linux-wpan@vger.kernel.org

Hello.


On 02/19/2018 12:03 AM, anton@picapica.im wrote:
> Some hints about issues related to SPI bus.
>
> Signed-off-by: Anton Sviridenko <anton@picapica.im>
> ---
>  website/index.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/website/index.txt b/website/index.txt
> index 9fd149e..6d9fe88 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -135,6 +135,21 @@ ip netns exec wpan0 ping6 ff02::1%lowpan0
>  Now watch wireshark and all the nice ICMP packets there.
>  
>  
> +Troubleshooting
> +~~~~~~~~~~~~~~~
> +If you have issues with transceiver connected to SPI bus, check first
> +if wiring is correct and SPI controller is properly configured. Try to
> +decrease SPI clock frequency. Messages like these ones in dmesg output
> +could indicate problems with SPI connection:
> +
> +---------------------------------------------------------------------
> +at86rf230 spi32765.0: unexcept state change from 0x01 to 0x08. Actual state:
> +0x01
> +WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:696 0xc0442644
> +received tx trac status 4
> +---------------------------------------------------------------------
> +
> +
>  Sniffing
>  ~~~~~~~~
>  

Thanks for the patch I applied and pushed it to the repo now.
While doing this I toke the freedom to replace your email with name and email in the from line to ahve your name show up correctly in git.

Alex, could you re-generate the website to get this included?

regards
Stefan Schmidt

