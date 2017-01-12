Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:59945 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdALIsX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Jan 2017 03:48:23 -0500
Received: from [IPv6:2003:48:940:b01b:3252:cbff:fe54:190f] (p200300480940B01B3252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:48:940:b01b:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 1BB33C2B31
        for <linux-wpan@vger.kernel.org>; Thu, 12 Jan 2017 09:48:21 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Added 802.15.4 support Scapy packet generator
Message-ID: <74de76a3-ef1d-ab84-36eb-817e12399de1@datenfreihafen.org>
Date: Thu, 12 Jan 2017 09:48:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

My pet project over the last few weeks has been bringing 15.4 support to
the Scapy packet manipulation program.

http://www.secdev.org/projects/scapy/

I based my work on a very old fork of Scapy which had support for ZigBee
and thus 15.4 for the lower layers. After throwing all the ZigBee parts
away and updating it to changes in upstream Scapy I now have a version
which can understand and send all kind of 15.4 frames.

You can find the work in progress code here:

https://github.com/linux-wpan/scapy/tree/stefan/dot15d4-support

To test it out you would need to setup a monitor interface named
monitor0 (virtual or real) and run ieee802154-scapy.py

Looking through the file should show you how the various frames are
created and send out. Listing on the other side with wireshark will show
you the results.

Scapy could help us
* developing kernel support for currently unsupported frames (beacon, cmd)
* testing by having a unit test framework (on a virtual env) for things
we support
* fuzzing our stack to find problems

I plan to get this code merged upstream at some point. It needs some
cleanup and fixes before that and I will be offline for the next two
weeks anyway. I wanted to get the message out before that happens. :)

Future additions could be support for IE and multipurpose frames from
the 2015 spec update (maybe other 2015 updates as well). A layer for
6LoWPAN with various header compression techniques would also be nice.

Have fun playing around with this. :)

regards
Stefan Schmidt
