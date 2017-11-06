Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47762 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbdKFOZU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 09:25:20 -0500
Subject: Re: [PATCH 00/14] Checkpatch cleanup for ieee802154 drivers
References: <20170922121405.31789-1-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <fcc2e345-3905-1501-7023-1651b73ad7bc@datenfreihafen.org>
Date: Mon, 6 Nov 2017 15:25:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

I would like to move forward with these patches. Could the driver
maintainers give their ACK here please if they are happy with the patch?

On 22.09.2017 14:13, Stefan Schmidt wrote:
> Hello.
> 
> This patchset works through various warnings and errors reported from checkpatch
> on all ieee802154 drivers. Testing and ACKs from the repective driver
> maintainers would be appreciated.
> 
> Stefan Schmidt (14):
>   ieee802154: adf7242: use unsigned int over only unsigned

Michael?

>   ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
>   ieee802154: at86rf230: use __func__ macro for debug messages

Alex?

>   ieee802154: atusb: switch from uint8_t to u8
>   ieee802154: atusb: use __func__ macro for debug messages
>   ieee802154: atusb: fix some kernel coding style errors
>   ieee802154: atusb: switch from BUG_ON() to WARN_ON() on problem

These four are getting applied soon.

>   ieee802154: mrf24j40: fix some kernel coding style errors

Alan, you spoke against this one. I will drop it.

>   ieee802154: ca8210: fix some kernel coding style errors
>   ieee802154: ca8210: use __func__ macro for debug messages

Harry?

>   ieee802154: cc2520: fix some kernel coding style errors
>   ieee802154: cc2520: use __func__ macro for debug messages
>   ieee802154: cc2520: switch from BUG_ON() to WARN_ON() on problem

Varka?

>   ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

Alex?

regards
Stefan Schmidt
