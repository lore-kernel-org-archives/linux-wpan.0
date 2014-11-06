Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56094 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaKFQeO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 11:34:14 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so2044325wib.5
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 08:34:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
From: Henning Rogge <hrogge@gmail.com>
Date: Thu, 6 Nov 2014 17:33:51 +0100
Message-ID: <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
Subject: Re: 6lowpan with external radio
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org

I had a look at the fakelb driver,

if I understand it right it just "connect" the raw-frame side of
multiple 6lowpan interfaces with each other, right? So it might be
part of the solution...

the other part should be similar to the tun.c driver... unfortunately
the tun driver got quite complex from what I can see.

Henning Rogge

On Thu, Nov 6, 2014 at 4:36 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Henning,
>
>> I am working with an external VHF radio attached over a serial
>> connection (USB serial at the moment) and looking for a way to use the
>> Linux 6lowpan stack with this radio.
>>
>> Is there a way to get a TUN/TAP equivalent for 6lowpan, just getting
>> the raw frames back through a socket into userspace?
>
> there is no interface for this. You will need to build an interface to create 6LoWPAN network devices from userspace and allow reading/writing from it.
>
> Regards
>
> Marcel
>
