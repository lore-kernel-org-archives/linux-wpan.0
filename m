Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:55430 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBEC1S (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 4 Feb 2019 21:27:18 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so4818858ith.5
        for <linux-wpan@vger.kernel.org>; Mon, 04 Feb 2019 18:27:17 -0800 (PST)
Date: Mon, 4 Feb 2019 21:27:03 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: How to test a 6lowpan patch w/o physical devices?
Message-ID: <20190205022703.24no6typzskrq6er@x220t>
References: <CAFTs51UE2RbzeVMZ0gJNzikNMzuPKRLTjAUxhvszGM7w02dvgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFTs51UE2RbzeVMZ0gJNzikNMzuPKRLTjAUxhvszGM7w02dvgg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Peter Oskolkov <posk@posk.io>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi,

On Mon, Feb 04, 2019 at 11:50:30AM -0800, Peter Oskolkov wrote:
> Hello!
> 
> I'd like to change 6lowpan defragmentation
> (net/ieee802154/6lowpan/reassembly.c) code to match that of regular
> IPv6, as in https://www.spinics.net/lists/netdev/msg546133.html.
> 

cool.

I am curious, what is your exact testing plan for 6lowpan fragmentation?
Or just cc me, then I will take a look. :-)

> However, I don't have a physical Linux/6lowpan setup to test my
> changes. Is it possible to create a virtual 6lowpan device/network
> inside net namespaces to run tests like these:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/tools/testing/selftests/net/ip_defrag.c
> ?

yes, on kernel since 4.19 you can setup a virtual phy network with the
mac802154_hwsim driver, which works basic similar like the wireless
mac80211_hwsim driver.

Unfortunately you need iwpan to setup basic specific L2 configuration.
It is part of wpan-tools [0].

When you load mac802154_hwsim it will register two phy's which can
reach each other virtually. I guess it will be enough for your test
setup.

Sample setup:

--- snip
modprobe mac802154_hwsim

iwpan dev wpan0 set pan_id 0xbeef
ip link add link wpan0 name lowpan0 type lowpan
ip link set wpan0 up
ip link set lowpan0 up

iwpan dev wpan1 set pan_id 0xbeef
ip netns add foo
iwpan phy1 set netns name foo
ip netns exec foo ip link add link wpan1 name lowpan1 type lowpan
ip netns exec foo ip link set wpan1 up
ip netns exec foo ip link set lowpan1 up
--- snap

I hope this answers your question, let me know if I you have still
questions.

Thank you!

- Alex

[0] https://github.com/linux-wpan/wpan-tools
