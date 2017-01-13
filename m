Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50381
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751708AbdAMM77 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Jan 2017 07:59:59 -0500
Subject: Re: [PATCH v7 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20170110154122.6724-1-h.morris@cascoda.com>
 <20170110154122.6724-2-h.morris@cascoda.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <b4b9b993-4e8b-8099-7217-72799f7f0aec@osg.samsung.com>
Date: Fri, 13 Jan 2017 13:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170110154122.6724-2-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

Hello.

On 10/01/17 16:41, Harry Morris wrote:
> Add driver source and config for softMAC implementation of Cascoda's CA8210
> IEEE 802.15.4 transceiver device. The driver mimics a common PHY-only
> implementation despite the CA8210 being a hardMAC device which exposes a SAP
> interface to the fully integrated MAC.
>
> The chip is a modem-only device with an integrated processor which runs the
> 802.15.4 MAC. The chip communicates via full-duplex SPI with additional pins
> for NIRQ and NRESET. The chip can also output its 16MHz clock to a GPIO with a
> configurable divider.
>
> The driver can be configured to implement a debugfs node that provides access
> to the SAP-based API to drive mechanisms not currently supported by the
> standard kernel interface.
>
> Signed-off-by: Harry Morris <h.morris@cascoda.com>
> ---
>  drivers/net/ieee802154/Kconfig  |   21 +
>  drivers/net/ieee802154/Makefile |    1 +
>  drivers/net/ieee802154/ca8210.c | 3273 +++++++++++++++++++++++++++++++++++++++

Great to that your latest rework got rid of around 500 lines of code. 
Reduced by this the mail does made its way to the list finally. :)

As I expressed before I'm ok with this driver even if it has some short 
comings. Something we should work on over this year. We on adding better 
hardMAC transceiver support to the stack and you adapting the driver and 
telling us whats missing :)

I did give it another run and make C=1 pointed the following out to me:

drivers/net/ieee802154/ca8210.c:1840:27: warning: incorrect type in 
assignment (different base types)
drivers/net/ieee802154/ca8210.c:1840:27:    expected restricted __le16 
[assigned] [usertype] pan_id
drivers/net/ieee802154/ca8210.c:1840:27:    got unsigned short 
[unsigned] [short] [usertype] <noident>
drivers/net/ieee802154/ca8210.c:1845:25: warning: incorrect type in 
assignment (different base types)
drivers/net/ieee802154/ca8210.c:1845:25:    expected restricted __le16 
[assigned] [usertype] pan_id
drivers/net/ieee802154/ca8210.c:1845:25:    got unsigned short 
[unsigned] [short] [usertype] <noident>
drivers/net/ieee802154/ca8210.c:1951:42: warning: missing braces around 
initializer
drivers/net/ieee802154/ca8210.c:1974:28: warning: incorrect type in 
argument 3 (different base types)
drivers/net/ieee802154/ca8210.c:1974:28:    expected unsigned short 
[unsigned] [usertype] dst_pan_id
drivers/net/ieee802154/ca8210.c:1974:28:    got restricted __le16 
[addressable] [usertype] pan_id

Maybe the code checker just got confused and these are false positives 
but please have a look at them.

I'm offline for the next two weeks. Will let this version sit here and 
if nothing problematic comes up we can get this applied when I'm back.

regards
Stefan Schmidt
