Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34734 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcLHJJy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Dec 2016 04:09:54 -0500
Received: by mail-qt0-f173.google.com with SMTP id n6so406771563qtd.1
        for <linux-wpan@vger.kernel.org>; Thu, 08 Dec 2016 01:09:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b1e4ebee-20f5-a781-7f28-edb10844945d@osg.samsung.com>
References: <CA+oDrvyoWaeDK_gcnRdK2cLb2vRiQ1dbaHb7u_0RggjBV2CqNw@mail.gmail.com>
 <b1e4ebee-20f5-a781-7f28-edb10844945d@osg.samsung.com>
From: Alan Egan <egan.alan.d@googlemail.com>
Date: Thu, 8 Dec 2016 10:09:52 +0100
Message-ID: <CA+oDrvwAoJE_YmsKTC3c5svk_tdbyFe-cS3wZnL1XN4wVoT=Yw@mail.gmail.com>
Subject: Re: 802.15.4g Support (again)
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hi Stefan,

I did in the end, though it was something I was working on over the
summer, and the work is being continued by the company I had a summer
placement with. I'm afraid I don't know how much work is happening on
it at the moment, or what timescales are for submission... From what I
remember, the changes will be fairly wide-reaching - properly adding
the channel selection support (even for a fraction of the supported
802.15.4g channels/modulation schemes) requires a lot of changes.

Cheers,

Alan

On Fri, Nov 25, 2016 at 11:02 AM, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Hello.
>
> On 16/08/16 16:15, Alan Egan wrote:
>>
>> Hi,
>>
>> Reading through the mailing list archive, I was wondering if any
>> progress had been made on the 802.15.4g support in the kernel? I'm in
>> a position where it would be really useful if it existed, so I'm more
>> than happy to have a crack at it myself (and it seems some aspects
>> have already been discussed and worked out). However, it looks like
>> there may already be someone working on it (though the last email
>> looks to be around end of March), and I don't want to duplicate work!
>
>
> Did you have a go at this?
>
> regards
> Stefan Schmidt
