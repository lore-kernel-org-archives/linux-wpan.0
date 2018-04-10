Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:58705 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDJK0s (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 10 Apr 2018 06:26:48 -0400
Subject: Re: [PATCH] ieee802154: mcr20a: Fix memory leak in mcr20a_probe
References: <20180405162006.GA2199@embeddedor.com>
 <CAJuUDwtUUv_nMEwijRydWmseL1aYOAoAfEdLVnoHWPWKdVgS-A@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <16f61490-5e6e-29c7-32b1-3a92a575ccb9@osg.samsung.com>
Date: Tue, 10 Apr 2018 12:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAJuUDwtUUv_nMEwijRydWmseL1aYOAoAfEdLVnoHWPWKdVgS-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.


On 04/10/2018 11:54 AM, Xue Liu wrote:
> Hallo,
>
> Thanks for the fix. It looks good.
>
> ACK-by: Xue Liu <liuxuenetmail@gmail.com>

Thanks for the ACK Xue. The correct format would be

Acked-by: Xue Liu <liuxuenetmail@gmail.com>

That way patchwork also picks the ACK up and adds it to the patch before I apply it from there.

No worries, I did this manually for you this time. For the next time please use the correct format to have this tracked.

regards
Stefan Schmidt
