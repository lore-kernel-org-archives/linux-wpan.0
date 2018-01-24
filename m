Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:43605 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeAXTaM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jan 2018 14:30:12 -0500
Received: by mail-it0-f49.google.com with SMTP id u62so6466936ita.2
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jan 2018 11:30:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180124172434.GA5251@picapica.im>
References: <20180121122454.GA24136@picapica.im> <CAB_54W6mxa4f3Sy97psaYqYGf9Xp+7SY_imv91U=YK9y_-iMiQ@mail.gmail.com>
 <CAB_54W5qcYR4oyqAUv0Bc2nCjEbKHSgzpRF4i2xtLsTHaNw=2Q@mail.gmail.com> <20180124172434.GA5251@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 24 Jan 2018 14:30:11 -0500
Message-ID: <CAB_54W5LXNWS5iPnLbPXa-84+s2VCJsJvc0NPqiFYaTC06UTig@mail.gmail.com>
Subject: Re: reading RSSI value
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-01-24 12:24 GMT-05:00  <anton@picapica.im>:
> On Mon, Jan 22, 2018 at 02:02:09PM -0500, Alexander Aring wrote:
>> Hi,
>>
>> 2018-01-21 12:59 GMT-05:00 Alexander Aring <alex.aring@gmail.com>:
>> > Hi,
>> >
>> > 2018-01-21 7:24 GMT-05:00  <anton@picapica.im>:
>> >> Hello
>> >>
>> >> Is it possible to somehow read RSSI (Received Signal Strength indicator) value for each ieee802154 frame
>> >> received using raw socket? Quick grepping in kernel and wpan-tools sources says no, but just wanted to
>> >
>> > One note about raw sockets: you should use AF_PACKET RAW as socket type.
>> >
>> > The answer is no. A single RSSI value of a frame says nothing about
>> > something... We want to collect them in kernelspace e.g. wireless
>> > station dump and make some mapping from $NODE_ADDR (complicated
>> > because short/extended mapping).
>> > There exists some thesis branch on github which I did for my "thesis"
>> > but not ready to bring upstream at all...
>> >
>> >> confirm. Could energy detection level value used instead? Also, is it possible to set transmitter power
>> >
>> > Also no energy detection and no LQI...
>> >
>> > Transmit power is possible (depends on driver support), but not per frame...
>> >
>>
>> got a new idea about to handle this per frame. Talked with one of the
>> TC maintainers today... I think it would be nice to have a TC action
>> where you can set a transmit power per classifier... not sure there
>> exists many way how to handle it. Also there was an idea according to
>> 6lowpan to handle it per ndisc entry. :-/
>>
>> If you really want to set it per frame. 802.11 people might be
>> interessted in the "wireless tx power TC action" as well...
>>
>> - Alex
>
>
> But changing transmit power is possible in runtime, isn't it?
> I mean, without bringing interface down/up. Or not?
> Is it supported by at86rf230 driver for at86rf212 chip? It seems that yes
>

no, but this has only one reason currently why we allow this only on
ifdown... we need to set the txpower for next transmit. We don't do a
transmit power setting WHILE the transceiver is actually sending, this
ends mostly in some UNDEF behavior of transceivers (the vendors
doesn't say anything about that handling in datasheets and it sounds
fragile).
BUT this will not be solution to make in userspace something like:

set_power(x);
send_frame(....);
set_power(y);
send_frame(....);

Such use case can be done by some another ideas with sendmsg() CMSG OR
what I said before by a TC action.

- Alex
