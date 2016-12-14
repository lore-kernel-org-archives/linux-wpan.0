Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57971 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756112AbcLNQtm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 14 Dec 2016 11:49:42 -0500
Subject: Re: [wpan-tools issue]wpan-ping: recv() function for receiving
 wpan-ping packets
References: <20161214072024.GB5190@localhost.localdomain>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <8a0c2fd9-1486-240f-5c78-4f7e5bfeb7cc@pengutronix.de>
Date: Wed, 14 Dec 2016 17:49:39 +0100
MIME-Version: 1.0
In-Reply-To: <20161214072024.GB5190@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: wsn.iot.xwq@cn.fujitsu.com
Cc: linux-wpan@vger.kernel.org, stefan@osg.samsung.com


Hi,

On 12/14/2016 08:20 AM, Xue Wenqian wrote:
> Hi,
> 
> Recently I find a wpan-ping problem: wpan-ping process is always
> running, when there is another process runing on wpan interface, which
> will also transmit packets via wpan, the non-wpanping packets will also
> be received by recv() of wpan-ping, leading to the "Sequence number did
> not match" problem. It seems that the recv() function can not filter out
> non-wpanping packets.
> 

In my opinion:

So the currently known other upper layer protocol is 6LoWPAN. According
to 6LoWPAN dispatches [0]:

00 xxxxxx       0       NALP

so the wpan-ping dataframe should start with the bit pattern 00.

Then for extra stuff the payload should do some checksum stuff, e.g.
ICMPv6 at tail -> if it doesn't match drop it.

Then most frames will be filtered, the rest is the usual header parsing,
if it doesn't match there -> drop it.

Wait for original author Stefan, for his opinion... I do here some
suggestions only.

- Alex

[0] https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml
