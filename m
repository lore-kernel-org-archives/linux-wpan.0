Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:51064 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeBSRgd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 12:36:33 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [PATCHv2 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
In-Reply-To: <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com> <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23731.1519061365.1@obiwan.sandelman.ca>
Content-Transfer-Encoding: 8BIT
Date: Mon, 19 Feb 2018 12:29:25 -0500
Message-ID: <23732.1519061365@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan@vger.kernel.org

Xue Liu <liuxuenetmail@gmail.com> wrote:
    > This driver implements a subset of ieee802154_ops. It has no support
    > for CSMA due to lack of hardware support. It has currently no support
    > for its proprietary feature: Dual PAN.

I think you mean, that the driver has no support for the MCR20A Dual
Pan feature, because the 802.15.4 layer has no way to deal with it.

A suggestion is to create two virtual devices!

Does the MCR20A support any of the TSCH features?


-- 
]               Never tell me the odds!                 | ipv6 mesh networks [ 
]   Michael Richardson, Sandelman Software Works        | network architect  [ 
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [ 
	
