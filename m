Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:54645 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcLHHFD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Dec 2016 02:05:03 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH bluetooth-next 0/4] ieee802154: atusb: drivers updates for
 v0.3 firmware
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
Date: Thu, 8 Dec 2016 08:05:02 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <5025FE69-CB84-44EE-9AB0-DC81F88FED9F@holtmann.org>
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Stefan,

> With the version 0.3 for the ATUSB firmware finally out of the door here are the
> corresponding kernel driver patches to make use of the new functionality.
> 
> While the first to patches are just preparation the last two are useful enhancements. An permanent
> EUI64 address can now be hold in the EEPROM of the ATUSB dongle to survive reboots and allowing a
> unique identification and no need to mess around with generated addresses after each device probe.
> 
> All new ATUSB dongles will have a address set in EEPROM already, for devices that are out in the
> wild already you would have to ask me to assign you an official one if you want it. Feel free to do
> so. :)
> 
> The last one allows to set the maximal fram reties values now that we support the needed states
> inside the firmware. This finishes the hardware assisted ACK handling on the TX site. RX side was
> working for a long time already.
> 
> Stefan Schmidt (4):
>  ieee802154: atusb: sync header file from firmware for new features
>  ieee802154: atusb: store firmware version after retrieval for later
>    use
>  ieee802154: atusb: try to read permanent extended address from device
>  ieee802154: atusb: implement .set_frame_retries ops callback
> 
> drivers/net/ieee802154/atusb.c | 79 ++++++++++++++++++++++++++++++++++++++----
> drivers/net/ieee802154/atusb.h | 11 ++++--
> 2 files changed, 80 insertions(+), 10 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

