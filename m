Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35189 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757847AbcDEMUG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Apr 2016 08:20:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id a140so3763394wma.2
        for <linux-wpan@vger.kernel.org>; Tue, 05 Apr 2016 05:20:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160404080440.GA625@omega>
References: <CAH+RWqFxO9VgVgbyxjefot8JLnF_asKzbGh9AVtu2GW9Z8uqxA@mail.gmail.com>
	<20160404080440.GA625@omega>
Date: Tue, 5 Apr 2016 16:20:04 +0400
Message-ID: <CAH+RWqHuppOrJMH_fOa52dd_M1K_TWHpmzdB_WYuwTih5C5LrA@mail.gmail.com>
Subject: Re: Reversed Payload Bits?
From: Remi Philippe <remi+wpan@linqio.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Thanks Alex, will look into your suggestion. It seems it's a bit reversal issue.
Contiki is 3.0 (master)

I just noticed that we were playing with the RPi version which doesn't
integrate most of the patches of bluetooth-next. Will first try to
create a diff between RPi and 802154 related to see if it fixes the
issue.

On Mon, Apr 4, 2016 at 12:04 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> On Sun, Apr 03, 2016 at 10:35:29PM +0400, Remi Philippe wrote:
>> Hello,
>> A generic question, have you ever run into issues such as payload bits
>> arriving reversed (AT86RF215 to CC1200 on Contiki, but I guess it
>> would be the same for AT86RF230)?
>>
>
> - which layer? MAC, 6LoWPAN?
>
> - bit or byte ordering?
>
>
> If you code something and missed byteordering handling you can check it
> with:
>
> make C=2 net/ieee802154/ net/mac802154/
>
> this requires the software "sparse".
>
> _But_ this works only if you use correct the byteorder typedefs such as
> "__le16", etc...
>
>> At first look it could have been and endianess problem, but I don't see why...
>>
>
> Which contiki version? I tested 2.6 with some self ported board only.
> I know versions below had some fragmentation issues, which you not use.
>
> - Alex
