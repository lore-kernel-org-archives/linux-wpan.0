Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47571 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfILLPB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Sep 2019 07:15:01 -0400
Subject: Re: ANNOUNCE: rpld an another RPL implementation for Linux
References: <CAB_54W7h9ca0UJAZtk=ApPX-2ZCvzu4774BTFTaB5mtkobWCtw@mail.gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <78e83575-4bae-cb8b-be8c-c108ac488a37@datenfreihafen.org>
Date: Thu, 12 Sep 2019 13:14:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAB_54W7h9ca0UJAZtk=ApPX-2ZCvzu4774BTFTaB5mtkobWCtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Cc: Michael Richardson <mcr@sandelman.ca>, Jamal Hadi Salim <jhs@mojatatu.com>, Robert Kaiser <robert.kaiser@hs-rm.de>, Martin Gergeleit <martin.gergeleit@hs-rm.de>, Kai Beckmann <kai.beckmann@hs-rm.de>, koen@bergzand.net, linux-wpan - ML <linux-wpan@vger.kernel.org>, reubenhwk@gmail.com, BlueZ development <linux-bluetooth@vger.kernel.org>, sebastian.meiling@haw-hamburg.de, Marcel Holtmann <marcel@holtmann.org>, Werner Almesberger <werner@almesberger.net>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hello Alex.

On 29.08.19 23:57, Alexander Aring wrote:
> Hi,
> 
> I had some free time, I wanted to know how RPL [0] works so I did a
> implementation. It's _very_ basic as it only gives you a "routable"
> (is that a word?) thing afterwards in a very constrained setup of RPL
> messages.
> 
> Took ~1 month to implement it and I reused some great code from radvd
> [1]. I released it under the same license (BSD?). Anyway, I know there
> exists a lot of memory leaks and the parameters are just crazy as not
> practical in a real environment BUT it works.
> 
> I changed a little bit the dependencies from radvd (because fancy new things):
> 
> - lua for config handling
> - libev for event loop handling
> - libmnl for netlink handling
> 
> The code is available at:
> 
> https://github.com/linux-wpan/rpld

I finally had a first look at it and played around a little bit.

How do you want to review patches for this? Pull requests on the github
repo or patches send on the linux-wpan list?

So far just some basic stuff I stumbled over when playing with it. Build
fixes (SCOPE_ID and different lua pkgconfig namings), leak fixes to
config.c as well as a travis setup to get building on CI as well as
submitting to Coverity scan service (the later two are already tested in
practice with some dev branches I pushed to the github repo, hope you
don't mind).

regards
Stefan Schmidt
