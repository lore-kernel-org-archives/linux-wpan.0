Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:41055 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932631AbeBUKNB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Feb 2018 05:13:01 -0500
Received: by mail-pf0-f182.google.com with SMTP id a17so468438pff.8
        for <linux-wpan@vger.kernel.org>; Wed, 21 Feb 2018 02:13:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <020d8281-720c-4359-409e-15016d39a386@osg.samsung.com>
References: <1519127758-2084-1-git-send-email-liuxuenetmail@gmail.com>
 <1519127758-2084-4-git-send-email-liuxuenetmail@gmail.com> <020d8281-720c-4359-409e-15016d39a386@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Wed, 21 Feb 2018 11:13:00 +0100
Message-ID: <CAJuUDwuOa9DHpadQhQaNq_ba8mv6bB3RdOr9MYKx2wNX_-JJUQ@mail.gmail.com>
Subject: Re: [PATCHv3 3/3] This is a driver for the NXP MCR20A 802.15.4 transceiver.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello,

Thanks for the review. Now I can pick up the CC2420 driver again and
hope to post a new one in a few weeks.

regards,

Xue Liu


On 21 February 2018 at 10:50, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Hello.
>
>
> On 02/20/2018 12:55 PM, Xue Liu wrote:
>> The MCR20AVHM transceiver (or MCR20A) is a low power,
>> high-performance 2.4 GHz, IEEE 802.15.4 compliant transceiver.
>>
>> This driver implements a subset of ieee802154_ops.
>> It has no support for CSMA due to lack of hardware support.
>> It has currently no support for its proprietary Dual-PAN feature.
>>
>> https://www.nxp.com/docs/en/reference-manual/MCR20RM.pdf
>>
>> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
>
> I took the liberty and changed the subject line back to what you used in v2 of the patch.
>
> This patch has been applied to the wpan-next tree and will be
> part of the next pull request to net-next. Thanks!
>
> regards
> Stefan Schmidt
