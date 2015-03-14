Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33913 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbCNS4c (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Mar 2015 14:56:32 -0400
Received: by wggv3 with SMTP id v3so11106113wgg.1
        for <linux-wpan@vger.kernel.org>; Sat, 14 Mar 2015 11:56:31 -0700 (PDT)
Date: Sat, 14 Mar 2015 19:56:21 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: 802.15.4 6LoWPAN ARPHRD changed
Message-ID: <20150314185620.GA1545@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: radvd-devel-l@litech.org, unstrung-hackers@lists.sandelman.ca, mkl@pengutronix.de, marcel@holtmann.org

Hi,

the 6LoWPAN ARPHRD interface type is changed and will be at linux kernel
version 4.1 or later to: ARPHRD_6LOWPAN, before it was ARPHRD_IEEE802154.

The reason was that a 802.15.4 and 6LoWPAN interface used the same
ARPHRD_IEEE802154 type, that occurs several issues on other applications
which can't decide if it's a 802154 or 6LoWPAN (IPv6) interface.

Since bluetooth 6LoWPAN introduced the ARPHRD_6LOWPAN we also decide
that we using ARPHRD_6LOWPAN now.

The most applications getting the EUI64 address from the interface
by evaluating the ARPHRD_IEEE802154. This should be the same for BT
6LoWPAN and 802.15.4 6LoWPAN, because both uses has an EUI64 address.
Also the applications use-case for BT 6LoWPAN and 802.15.4 6LoWPAN
should be the same. We can also introduce some other mechanism to detect
the L2 interface type of an ARPHRD_6LOWPAN, if this is necessary.

For backwards compability it should be safe to add a:

case ARPHRD_6LOWPAN before or after ARPHRD_IEEE802154.

Example radvd in function update_device_info [0]:

switch (ifr.ifr_hwaddr.sa_family) {
...
case ARPHRD_IEEE802154:
case ARPHRD_6LOWPAN:
	...
	break;
...
}

But this handling is still a little bit wrong because ARPHRD_IEEE802154
are 802.15.4 interfaces which don't have IPv6 functionality.

Nevertheless I just want to leave a note to current common userspace
applications which evaluating this UAPI value. That's why I cc'ed radvd
and unstrung here.

- Alex

[0] https://github.com/reubenhwk/radvd/blob/master/device-linux.c#L82
