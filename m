Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33149 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeAUR7K (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Jan 2018 12:59:10 -0500
Received: by mail-io0-f170.google.com with SMTP id n7so7129061iob.0
        for <linux-wpan@vger.kernel.org>; Sun, 21 Jan 2018 09:59:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180121122454.GA24136@picapica.im>
References: <20180121122454.GA24136@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Sun, 21 Jan 2018 12:59:08 -0500
Message-ID: <CAB_54W6mxa4f3Sy97psaYqYGf9Xp+7SY_imv91U=YK9y_-iMiQ@mail.gmail.com>
Subject: Re: reading RSSI value
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-01-21 7:24 GMT-05:00  <anton@picapica.im>:
> Hello
>
> Is it possible to somehow read RSSI (Received Signal Strength indicator) value for each ieee802154 frame
> received using raw socket? Quick grepping in kernel and wpan-tools sources says no, but just wanted to

One note about raw sockets: you should use AF_PACKET RAW as socket type.

The answer is no. A single RSSI value of a frame says nothing about
something... We want to collect them in kernelspace e.g. wireless
station dump and make some mapping from $NODE_ADDR (complicated
because short/extended mapping).
There exists some thesis branch on github which I did for my "thesis"
but not ready to bring upstream at all...

> confirm. Could energy detection level value used instead? Also, is it possible to set transmitter power

Also no energy detection and no LQI...

Transmit power is possible (depends on driver support), but not per frame...

- Alex
