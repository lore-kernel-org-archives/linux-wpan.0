Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33603 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934564AbdACI0g (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Jan 2017 03:26:36 -0500
Received: by mail-qk0-f174.google.com with SMTP id t184so368949483qkd.0
        for <linux-wpan@vger.kernel.org>; Tue, 03 Jan 2017 00:26:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4d9369af-5384-98d0-399f-3474abaf75c3@pengutronix.de>
References: <CAAK7Ti-6NypT=jTFeuFv=Ka3EDDzzbnrqbRuv9PU0EaW3ibEhg@mail.gmail.com>
 <141e39b2-da67-2bfa-bc57-61083d071fe9@pengutronix.de> <CAAK7Ti9=p+QaJZBiczQ5xAcBBsmdQObfYwG2TfmsS2i39f_CoQ@mail.gmail.com>
 <4d9369af-5384-98d0-399f-3474abaf75c3@pengutronix.de>
From: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Date: Tue, 3 Jan 2017 13:56:35 +0530
Message-ID: <CAAK7Ti953hfv0s1Dns6yomGqdhbj8tB47aa7LAY5qY8gbSZ75Q@mail.gmail.com>
Subject: Re: please help me process for libcoap and and 6lowpan integration.
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org

thankq Alex.

have you any idea about, where i have to go through in libcoap code to
drive the packet towards lowpan?

On Tue, Jan 3, 2017 at 12:55 PM, Alexander Aring <aar@pengutronix.de> wrote:
> Hi,
>
> On 01/02/2017 06:17 PM, JANARDHANACHARI KELLA wrote:
>> Thankq Alex for your reply.
>>
>> I have already, using flakelb driver and prepared lowpan Interface. I have
>> tested configuration with wpan-tools/example/af_inet6_tx.c and Rx.c files.
>> I am able to find the 6lowpan packet at wpan0 virtual PHY. So, that I am
>> moving towards integration of 6lowpan and coap.
>>
>> Please give me suggestion.
>>
>
> no top post please and keep mailinglist in cc.
>
> If you have lowpan interface it's just the same as you using ethernet
> ipv6.
>
> - Alex



-- 
Sincerely Your's

Janardhanachari Kella
Contact:+91-9908469599
E-mail: eni.chari@gmail.com
