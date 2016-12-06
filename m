Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:52460
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751590AbcLFVZt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Dec 2016 16:25:49 -0500
Subject: Re: [PATCH v6 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20161206154740.2992-1-h.morris@cascoda.com>
 <20161206154740.2992-2-h.morris@cascoda.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <84426f94-8bb6-06d7-c166-b97929afc0ee@osg.samsung.com>
Date: Tue, 6 Dec 2016 22:25:44 +0100
MIME-Version: 1.0
In-Reply-To: <20161206154740.2992-2-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

Hello.

First of all thanks for going and fixing almost all of the checkpatch 
warnings. The rest seems ok to stay as is.
I would expect you made sure that the case where a msleep() could take 
up to 20ms in cases it is < 20ms are no problems in your driver.

On 06/12/16 16:47, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
>
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

 From what I can see all my review comments have been addressed over 
this 7 iterations. Thanks. :-)

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
