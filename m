Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:40421 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423537AbeCBLL7 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 2 Mar 2018 06:11:59 -0500
Subject: Re: [PATCH] website: Add NXP mcr20a to the suppoted hardware
References: <1519638689-5134-1-git-send-email-liuxuenetmail@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <2888ffb6-9513-5cf2-7aaf-6bb4434e13ce@osg.samsung.com>
Date: Fri, 2 Mar 2018 12:11:44 +0100
MIME-Version: 1.0
In-Reply-To: <1519638689-5134-1-git-send-email-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello.


On 02/26/2018 10:51 AM, Xue Liu wrote:
> add NXP mcr20a to the suppoted hardware list.
>
> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
> ---
>  website/index.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/website/index.txt b/website/index.txt
> index 6d9fe88..d631371 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -47,6 +47,7 @@ Supported Hardware
>  |cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
>  |cc2520      |yes              |cc2520     | SPI | http://de.aliexpress.com/item/CC2520-wireless-module-ZIGBEE-wireless-sensor-networking-module-with-SMA-external-antenna/1921436550.html[aliexpress]
>  |cc2531      |no               |           | USB | http://de.aliexpress.com/item/free-shipping-FOR-ZigBee-CC2531-USB-dongle-protocol-analysis-port-capture-wireless-keyboard-and-mouse/32270975591.html[aliexpress]
> +|mcr20a      |yes              |mcr20a	   | SPI | https://www.nxp.com/products/wireless-connectivity/thread/2.4-ghz-802.15.4-wireless-transceiver:MCR20A[NXP]
>   |mrf24j40   |yes              |mrf24j40   | SPI |  http://de.aliexpress.com/item/MRF24J40MA-I-RM-MRF24J40MA-I-MRF24J40MA-MRF24J40-MICROC-QFN-Import-original/32223258627.html[aliexpress]
>  |RZUSBstick  |experimental, http://wpan.cakelab.org/firmwares/rzusb.bin[WIP]          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
>  |Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]

Thanks for the patch. I applied it to the old website repo and also made sure it gets updated on the new page on http://linux-wpan.org/

regards
Stefan Schmidt
