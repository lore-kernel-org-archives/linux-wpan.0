Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:48933 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbaLWKjE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 05:39:04 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so5407867lab.12
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 02:39:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
References: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 23 Dec 2014 16:09:02 +0530
Message-ID: <CAEUmHyYKMHmZ8aJWnMe7fOrOh8AxswtL0=TJpXeiy6YevresDw@mail.gmail.com>
Subject: Re: [PATCH bluetooth-next 0/3] ieee802154: 6lowpan: separate
 receive/transmit functionality
From: Varka Bhadram <varkabhadram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, kernel@pengutronix.de

Hi Alex,

On Tue, Dec 23, 2014 at 4:00 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> this patch series based on "ieee802154: structural directory changes" and
> contains splitting of receive/transmit functionality in separate tx and rx
> files. At least we rename the 6lowpan_rtnl to core which contains core
> functionality for 802.15.4 6LoWPAN.
>
> Alexander Aring (3):
>   ieee802154: 6lowpan: move receive functionality
>   ieee802154: 6lowpan: move transmit functionality
>   ieee802154: 6lowpan: rename to core
>
Nice work. By this change we can easily identify the Tx and Rx part separately.

Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>

>  net/ieee802154/6lowpan/6lowpan_i.h    |  31 ++
>  net/ieee802154/6lowpan/6lowpan_rtnl.c | 729 ----------------------------------
>  net/ieee802154/6lowpan/Makefile       |   2 +-
>  net/ieee802154/6lowpan/core.c         | 304 ++++++++++++++
>  net/ieee802154/6lowpan/rx.c           | 171 ++++++++
>  net/ieee802154/6lowpan/tx.c           | 271 +++++++++++++
>  6 files changed, 778 insertions(+), 730 deletions(-)
>  delete mode 100644 net/ieee802154/6lowpan/6lowpan_rtnl.c
>  create mode 100644 net/ieee802154/6lowpan/core.c
>  create mode 100644 net/ieee802154/6lowpan/rx.c
>  create mode 100644 net/ieee802154/6lowpan/tx.c
>
> --
> 2.2.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thanks and Regards,
Varka Bhadram.
