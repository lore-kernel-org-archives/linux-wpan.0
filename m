Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32782 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbERKT4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 06:19:56 -0400
Received: by padbw4 with SMTP id bw4so146140547pad.0
        for <linux-wpan@vger.kernel.org>; Mon, 18 May 2015 03:19:56 -0700 (PDT)
Message-ID: <5559BCB0.7040100@gmail.com>
Date: Mon, 18 May 2015 15:49:28 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 06/34] ieee802154: introduce wpan_phy_supported
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com> <1431891910-32231-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-7-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alan Ott <alan@signal11.us>

Hi,

On 05/18/2015 01:14 AM, Alexander Aring wrote:

> This patch introduce the wpan_phy_supported struct for wpan_phy. There
> is currently no way to check if a transceiver can handle IEEE 802.15.4
> complaint values. With this struct we can check before if the
> transceiver supports these values before sending to driver layer.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
> Cc: Varka Bhadram <varkabhadram@gmail.com>
> Cc: Alan Ott <alan@signal11.us>
> ---
>   drivers/net/ieee802154/at86rf230.c |  8 ++++----
>   drivers/net/ieee802154/cc2520.c    |  2 +-
>   drivers/net/ieee802154/fakelb.c    | 30 +++++++++++++++---------------
>   drivers/net/ieee802154/mrf24j40.c  |  2 +-
>   include/net/cfg802154.h            |  6 +++++-
>   net/ieee802154/nl-phy.c            |  4 ++--
>   net/ieee802154/nl802154.c          |  4 ++--
>   7 files changed, 30 insertions(+), 26 deletions(-)

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Varka Bhadram

