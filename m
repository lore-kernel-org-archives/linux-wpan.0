Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33170 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbE2Ho1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 03:44:27 -0400
Received: by wicmx19 with SMTP id mx19so8592486wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 00:44:26 -0700 (PDT)
Date: Fri, 29 May 2015 09:44:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150529074419.GA2557@omega>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
 <20150529041723.GN11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150529041723.GN11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 07:17:23AM +0300, Lennert Buytenhek wrote:
...
> 
> Also, every other 802 link layer I know of transmits the OUI bytes
> of the EUI first, and at least for 802.3 ("Ethernet"), the point of
> transmitting the least significant bit first is so that the first
> transmitted header bit is the group address bit of the destination
> ethernet address, see e.g. this section from 802.3-2012 3.2.3:
> 
> 	http://i.imgur.com/YfaWVwT.png
> 
> (And note how the I/G and U/L bits are on the very left, even though
> when we write out an EUI-48, the I/G bit is 01:00:00:00:00:00, and
> the U/L bit is 02:00:00:00:00:00.)
> 
> I don't know of any EUI-{48,64} users that transmit the OUI bytes
> including the I/G bit and the U/L bit as the very last bytes of the
> address, but this is what you are arguing for, and I'm really not
> sure why you think it should be like this -- the references you
> quoted all seem to contradict the conclusion you're drawing from
> them, in my humble opinion.

Maybe this helps a little bit to clarifing this [0].

8. MAC addresses
8.6 Bit-ordering and different MACs

"Throughout this subclause, considerations relating to the order of bit
and/or octet transmission refer to the basic bit-serial model of
transmission that applies to the representation of MAC frames at the
boundary between the MAC and the PHY."

"...octet transmission that applies to the representation of MAC frames..."
which is little endian.



Also I note that several documents [0] and [1] talks about, what Phoebe
already said: EUI-64 is a number representation and each payload in PSDU
should send in little endian byte order.


That the PSDU should send in little endian is specified in section:
10.2.3 Bit-to-symbol mapping

"Each octet of the PPDU is processed through the modulation and spreading
functions, as illustrated in Figure 69, sequentially, beginning with the
Preamble field and ending with the last octet of the PSDU. Within each octet,
the least significant symbol (b0,b1,b2,b3) is processed first and the most
significant symbol (b4,b5,b6,b7) is processed second."


- Alex

[0] http://standards.ieee.org/getieee802/download/802-2014.pdf
[1] http://www.silabs.com/Support%20Documents/TechnicalDocs/UG100.pdf (Section 2.1)
[2] http://datasheet.octopart.com/SN260QT-STMicroelectronics-datasheet-516599.pdf (Section 7.1)
