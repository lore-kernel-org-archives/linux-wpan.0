Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34407 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbcDDIEx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 Apr 2016 04:04:53 -0400
Received: by mail-lf0-f42.google.com with SMTP id c62so157139562lfc.1
        for <linux-wpan@vger.kernel.org>; Mon, 04 Apr 2016 01:04:52 -0700 (PDT)
Date: Mon, 4 Apr 2016 10:04:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Reversed Payload Bits?
Message-ID: <20160404080440.GA625@omega>
References: <CAH+RWqFxO9VgVgbyxjefot8JLnF_asKzbGh9AVtu2GW9Z8uqxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH+RWqFxO9VgVgbyxjefot8JLnF_asKzbGh9AVtu2GW9Z8uqxA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Remi Philippe <remi+wpan@linqio.com>
Cc: linux-wpan@vger.kernel.org

On Sun, Apr 03, 2016 at 10:35:29PM +0400, Remi Philippe wrote:
> Hello,
> A generic question, have you ever run into issues such as payload bits
> arriving reversed (AT86RF215 to CC1200 on Contiki, but I guess it
> would be the same for AT86RF230)?
> 

- which layer? MAC, 6LoWPAN?

- bit or byte ordering?


If you code something and missed byteordering handling you can check it
with:

make C=2 net/ieee802154/ net/mac802154/

this requires the software "sparse".

_But_ this works only if you use correct the byteorder typedefs such as
"__le16", etc...

> At first look it could have been and endianess problem, but I don't see why...
> 

Which contiki version? I tested 2.6 with some self ported board only.
I know versions below had some fragmentation issues, which you not use.

- Alex
