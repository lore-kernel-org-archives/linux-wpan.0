Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:56907 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaJGHkf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 03:40:35 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so8403837wgh.33
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 00:40:33 -0700 (PDT)
Received: from omega (p20030064A932D7B2E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a932:d7b2:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id om1sm19647039wjc.42.2014.10.07.00.40.32
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 00:40:32 -0700 (PDT)
Date: Tue, 7 Oct 2014 09:40:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: new handling for applying patches
Message-ID: <20141007074025.GA2768@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

over irc, means:

irc.freenode.net #linux-wireless (there exist also a #linux-wpan channel)

Marcel offered this:

<qoute>
20:04 < holtmann> eintopf: If you want to make your life a bit simpler, you or the driver maintainer can just ack patches and I apply them to bluetooth-next tree.
20:05 < holtmann> eintopf: Seriously I can just take them straight out of linux-wpan mailing list of you want. It is dead simple for me.
20:06 < holtmann> We need to get to a level where net/6lowpan/ dependencies on Bluetooth and IEEE 802.15.4 are not affecting itself that much anymore and then you can just submit directly to wireless-next 
                  tree.
20:07 < holtmann> So if you want to focus on hacking on the code, I can take care of getting you a tree you can work in.
</qoute>

That's a very nice offer and I will accept it. Thanks.

The new behaviour:
 - 802.15.4: base on bluetooth-next and send it to linux-wpan.
   - Here Marcel waits for driver maintainers or me.
 - 6LoWPAN GENERIC: base on bluetooth-next and send it to linux-wpan,
   linux-bluetooth.
    - Here Marcel waits for Jukka or me.


Hope that is okay. We need to do this until:

"We need to get to a level where net/6lowpan/ dependencies on Bluetooth and IEEE 802.15.4 are not affecting itself that much anymore"

then we can send 802.15.4 patches (hopefully pull-request, yea I will
learn that) also to wireless/wireless-next.


Hope all are fine with this solution at the moment.

- Alex
