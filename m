Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37514 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbbE2Iby (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:31:54 -0400
Received: by wifw1 with SMTP id w1so14168758wif.0
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 01:31:53 -0700 (PDT)
Date: Fri, 29 May 2015 10:31:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150529083145.GA3709@omega>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
 <20150529041723.GN11340@wantstofly.org>
 <20150529074419.GA2557@omega>
 <20150529080821.GO11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150529080821.GO11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 11:08:21AM +0300, Lennert Buytenhek wrote:
...
> > That the PSDU should send in little endian is specified in section:
> > 10.2.3 Bit-to-symbol mapping
> > 
> > "Each octet of the PPDU is processed through the modulation and spreading
> > functions, as illustrated in Figure 69, sequentially, beginning with the
> > Preamble field and ending with the last octet of the PSDU. Within each octet,
> > the least significant symbol (b0,b1,b2,b3) is processed first and the most
> > significant symbol (b4,b5,b6,b7) is processed second."
> 
> This is about bit ordering, not byte ordering -- and it's consistent
> with what I have been saying before -- it explains why the I/G bit
> is transmitted first, even though it is the 0x01 bit in the first
> address byte.
> 

I need to lookup more information about this.

I know this not an argument, but let us think about if we change the byte
order there. This means that SAM/DAM decompression/compression BIT 11 is wrong [0].
(The remaining 64 bits are computed from the encapsulating header (e.g.,
802.15.4 or IPv6 source address)...)

That also means that wireshark, contiki, etc. will all do currently the wrong
byte ordering at L2. I currently can't believe that and we should really
clarifying this issue before we change this. Otherwise we are
incompatible with the whole 802.15.4 IoT used software outside.

- Alex

[0] https://tools.ietf.org/html/rfc6282#section-3.1.1
