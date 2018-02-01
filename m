Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35436 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeBAQPz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Feb 2018 11:15:55 -0500
Received: by mail-vk0-f45.google.com with SMTP id n132so11597694vke.2
        for <linux-wpan@vger.kernel.org>; Thu, 01 Feb 2018 08:15:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dea4d0e2-af43-1d46-2abe-ef947fa1298e@osg.samsung.com>
References: <dea4d0e2-af43-1d46-2abe-ef947fa1298e@osg.samsung.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 1 Feb 2018 11:15:54 -0500
Message-ID: <CAOHTApicFHO=26DmaCnmux1KXqwfgR1DEZ7An2VFs5vRYp=aPw@mail.gmail.com>
Subject: Re: wpan-tools 0.8 release
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>

Hi,

On Thu, Feb 1, 2018 at 5:29 AM, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Hello.
>
>
> It is a pleasure to announce the 0.8 release of wpan-tools.
> Thanks to everyone who contributed!
>
> More of a maintenance release this time around. We did not have a release in a while and the build error with libnl >= 3.3 started to hit
> more people. Having this fixed is worth a release alone. Thanks a lot to Thomas Petazzoni for the fix.
>
> We also added some some examples on how to use the ieee802154 subsystem socket types from userspace.
> Xue Wenqian added some more functionality to the wpan-ping utility. Mayn thanks here as well.
>
> https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.gz
>
> sha256sum: 0e22cadbc40d4c12d0a66e8175bda12046f03237ce6da23d4fd26fd3ab557d8b
>
> https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.xz
>
> sha256sum: daacd38fe2f216095664dbf2628151c8f632d3f122d526059a37ba3cc4d3d8af
>
>
> Stefan Schmidt (9):
> examples: add README with details to the various examples
> examples: af_ieee802154_tx example
> examples: af_ieee802154_rx example
> examples: add af_packet_rx example
> examples: af_inet6_rx example
> examples: af_packet_tx example
> examples: af_inet6_tx example
> examples: add .gitignore file for examples directory
> Release 0.8
>
> Thomas Petazzoni (1):
> src/nl_extras.h: fix compatibility with libnl 3.3.0
>
> Xue Wenqian (2):
> wpan-ping: add the support to set wpan-ping interval
> wpan-ping: Add the filtering function for frame receiving
>

Thank you all. I know at the moment is some idle time... but I want to
make something this year again.
What I have laying around for container based mesh networking
simulation, I need that to tackle some issues with fragmentation
handling in 6LoWPAN...
Have some ideas for a special qdisc (and my current boss supports me
to develop it).

And another thing is the multiple pan handling with ack handling on
hardware (by slotted ackhandling on at86rf2xx transceivers).
I am recently moved into another country and my RPI/openthread
transceiver stuff is still in my old country... but I will have my
hardware this year.

Another thing would be too take a look into these IKEA lamps [0] and
check what's needed to talk with them? Somebody knows if they using
2.4 Ghz ISM? If so then it would be easy to sniff traffic...
So far I know they use 802.154. and some "ZigBee" e.g. Phillips Hue
(and phillips hue use 2.4 Ghz, I was able to see traffic once).

- Alex

[0] http://www.ikea.com/ca/en/catalog/categories/departments/lighting/36812/
