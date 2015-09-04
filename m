Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34146 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbbIDJr4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 4 Sep 2015 05:47:56 -0400
Subject: Re: [PATCH wpan-misc 1/3] website: update rzusbstick firmware
References: <1441358231-22349-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E968C8.7010305@osg.samsung.com>
Date: Fri, 4 Sep 2015 11:47:52 +0200
MIME-Version: 1.0
In-Reply-To: <1441358231-22349-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 04/09/15 11:17, Alexander Aring wrote:
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   website/index.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/website/index.txt b/website/index.txt
> index 907af61..9a4794f 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -47,7 +47,7 @@ Supported Hardware
>   |cc2520      |yes              |cc2520     | SPI | http://de.aliexpress.com/item/CC2520-wireless-module-ZIGBEE-wireless-sensor-networking-module-with-SMA-external-antenna/1921436550.html[aliexpress]
>   |cc2531      |no               |           | USB | http://de.aliexpress.com/item/free-shipping-FOR-ZigBee-CC2531-USB-dongle-protocol-analysis-port-capture-wireless-keyboard-and-mouse/32270975591.html[aliexpress]
>    |mrf24j40   |yes              |mrf24j40   | SPI |  http://de.aliexpress.com/item/MRF24J40MA-I-RM-MRF24J40MA-I-MRF24J40MA-MRF24J40-MICROC-QFN-Import-original/32223258627.html[aliexpress]
> -|RZUSBstick  |no, WIP          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
> +|RZUSBstick  |experimental, http://wpan.cakelab.org/firmwares/rzusb.bin[WIP]          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
>   |Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]
>   |=============================================================
>   

All three patches are looking good to me.

regards
Stefan Schmidt
