Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58105 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbaKFRBL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 12:01:11 -0500
Received: by mail-wi0-f174.google.com with SMTP id d1so2123300wiv.7
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 09:01:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141106165425.GA32499@omega>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
 <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org> <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com>
 <20141106165425.GA32499@omega>
From: Henning Rogge <hrogge@gmail.com>
Date: Thu, 6 Nov 2014 18:00:49 +0100
Message-ID: <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com>
Subject: Re: 6lowpan with external radio
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

On Thu, Nov 6, 2014 at 5:54 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> On Thu, Nov 06, 2014 at 05:33:51PM +0100, Henning Rogge wrote:
>> I had a look at the fakelb driver,
>>
>> if I understand it right it just "connect" the raw-frame side of
>> multiple 6lowpan interfaces with each other, right? So it might be
>> part of the solution...
>>
>> the other part should be similar to the tun.c driver... unfortunately
>> the tun driver got quite complex from what I can see.
>>
>
> do you use a 802.15.4 radio? Then maybe the serial driver is something
> like that what you searching for.

No, its not a 802.15.4 radio... its mostly layer 1 and some "listen
before talk/ALOHA" media access. I can send it raw frames (with a few
header fields) and get everything the radio receives via serial port.

A friend of mine suggested looking into 6lowpan instead of writing my
own fragmentation/IP-compression/... scheme. The radio is very slow,
so I need something efficient.

Henning Rogge
