Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:55293 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbdBPPzX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 16 Feb 2017 10:55:23 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id AD31A20CD4
        for <linux-wpan@vger.kernel.org>; Thu, 16 Feb 2017 16:55:20 +0100 (CET)
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca>
From: Johann Fischer <johann_fischer@posteo.de>
Message-ID: <b004df9c-7170-7b01-eb59-f10bf57d6662@posteo.de>
Date: Thu, 16 Feb 2017 16:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <28517.1487255767@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Xue,

 > Now I am working on a driver for MCR20A radio chip from NXP. This chip
 > has a special feature: support two PAN networks. It means it can
 > operate on two different or the same channels with different PAN IDs,
 > short addresses and extended addresses. I suppose to add two 802.15.4
 > interfaces for this feature. And I have two questions:
 >
 > 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
 > with different struct ieee802154_hw ?
 >
 > 2. how to deal with tx and rx regarding two interfaces.
 >
 > Thanks.
 >

Dual PAN is something like nice to have.
I suggest initialy to implement only PAN ID 0 support. It is easier and 
you would have fewer problems with the sequence manager. If the driver 
is stable and tested, then you can expand it and add support for dual PAN.

 > It is appropriate for any driver design suggestions about this chip.

Since there are some incompletenesses in the reference manual, a good 
help could be [1], also there is kw2xrf driver in RIOT-OS [2] and mcr20a 
driver in zephyr-project (drivers/ieee802154/ieee802154_mcr20a*) [3].

[1] https://developer.mbed.org/teams/NXP/code/fsl_phy_mcr20a/
[2] https://github.com/RIOT-OS/RIOT/tree/master/drivers/kw2xrf
[3] https://gerrit.zephyrproject.org/r/gitweb?p=zephyr.git;a=tree;hb=HEAD
