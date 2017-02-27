Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:33784
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751419AbdB0Oam (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Feb 2017 09:30:42 -0500
Subject: Re: [PATCH v8 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20170206170857.5064-1-h.morris@cascoda.com>
 <20170206170857.5064-2-h.morris@cascoda.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <967ca575-923a-ed40-13c2-544f44eb50e6@osg.samsung.com>
Date: Mon, 27 Feb 2017 15:20:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170206170857.5064-2-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

Hello.

On 02/06/2017 06:08 PM, Harry Morris wrote:
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

With the compile problem from common clk solved you can add my ack for 
the next version:

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
