Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:38932 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbeBUJux (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 21 Feb 2018 04:50:53 -0500
Subject: Re: [PATCHv3 3/3] This is a driver for the NXP MCR20A 802.15.4
 transceiver.
References: <1519127758-2084-1-git-send-email-liuxuenetmail@gmail.com>
 <1519127758-2084-4-git-send-email-liuxuenetmail@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <020d8281-720c-4359-409e-15016d39a386@osg.samsung.com>
Date: Wed, 21 Feb 2018 10:50:49 +0100
MIME-Version: 1.0
In-Reply-To: <1519127758-2084-4-git-send-email-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello.


On 02/20/2018 12:55 PM, Xue Liu wrote:
> The MCR20AVHM transceiver (or MCR20A) is a low power,
> high-performance 2.4 GHz, IEEE 802.15.4 compliant transceiver.
>
> This driver implements a subset of ieee802154_ops.
> It has no support for CSMA due to lack of hardware support.
> It has currently no support for its proprietary Dual-PAN feature.
>
> https://www.nxp.com/docs/en/reference-manual/MCR20RM.pdf
>
> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>

I took the liberty and changed the subject line back to what you used in v2 of the patch.

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
