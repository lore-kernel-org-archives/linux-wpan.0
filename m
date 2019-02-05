Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35937 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfBEQrG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Feb 2019 11:47:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id d12so2389285edy.3
        for <linux-wpan@vger.kernel.org>; Tue, 05 Feb 2019 08:47:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFTs51UE2RbzeVMZ0gJNzikNMzuPKRLTjAUxhvszGM7w02dvgg@mail.gmail.com>
 <20190205022703.24no6typzskrq6er@x220t>
In-Reply-To: <20190205022703.24no6typzskrq6er@x220t>
From: Peter Oskolkov <posk@posk.io>
Date: Tue, 5 Feb 2019 08:46:53 -0800
Message-ID: <CAFTs51VCt=HVL6-gn0BstjUpDzphrdH+ix3QHd4GaD1tQXdtoA@mail.gmail.com>
Subject: Re: How to test a 6lowpan patch w/o physical devices?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

On Mon, Feb 4, 2019 at 6:27 PM Alexander Aring <aring@mojatatu.com> wrote:
>
> Hi,
>
> On Mon, Feb 04, 2019 at 11:50:30AM -0800, Peter Oskolkov wrote:
> > Hello!
> >
> > I'd like to change 6lowpan defragmentation
> > (net/ieee802154/6lowpan/reassembly.c) code to match that of regular
> > IPv6, as in https://www.spinics.net/lists/netdev/msg546133.html.
> >
>
> cool.
>
> I am curious, what is your exact testing plan for 6lowpan fragmentation?

I plan to add a 6lowpan test case to
tools/testing/selftests/net/ip_defrag.[sh|c]

> Or just cc me, then I will take a look. :-)

Will definitely cc you.

>
> > However, I don't have a physical Linux/6lowpan setup to test my
> > changes. Is it possible to create a virtual 6lowpan device/network
> > inside net namespaces to run tests like these:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/tools/testing/selftests/net/ip_defrag.c
> > ?
>
> yes, on kernel since 4.19 you can setup a virtual phy network with the
> mac802154_hwsim driver, which works basic similar like the wireless
> mac80211_hwsim driver.
>
> Unfortunately you need iwpan to setup basic specific L2 configuration.
> It is part of wpan-tools [0].
>
> When you load mac802154_hwsim it will register two phy's which can
> reach each other virtually. I guess it will be enough for your test
> setup.
>
> Sample setup:
>
> --- snip
> modprobe mac802154_hwsim
>
> iwpan dev wpan0 set pan_id 0xbeef
> ip link add link wpan0 name lowpan0 type lowpan
> ip link set wpan0 up
> ip link set lowpan0 up
>
> iwpan dev wpan1 set pan_id 0xbeef
> ip netns add foo
> iwpan phy1 set netns name foo
> ip netns exec foo ip link add link wpan1 name lowpan1 type lowpan
> ip netns exec foo ip link set wpan1 up
> ip netns exec foo ip link set lowpan1 up
> --- snap
>
> I hope this answers your question, let me know if I you have still
> questions.

Thanks a lot, Alex! Yes, it seems exactly what I need!

>
> Thank you!
>
> - Alex
>
> [0] https://github.com/linux-wpan/wpan-tools
