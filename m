Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:54054 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbbE2IIX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:08:23 -0400
Date: Fri, 29 May 2015 11:08:21 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150529080821.GO11340@wantstofly.org>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
 <20150529041723.GN11340@wantstofly.org>
 <20150529074419.GA2557@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150529074419.GA2557@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 09:44:20AM +0200, Alexander Aring wrote:

> > Also, every other 802 link layer I know of transmits the OUI bytes
> > of the EUI first, and at least for 802.3 ("Ethernet"), the point of
> > transmitting the least significant bit first is so that the first
> > transmitted header bit is the group address bit of the destination
> > ethernet address, see e.g. this section from 802.3-2012 3.2.3:
> > 
> > 	http://i.imgur.com/YfaWVwT.png
> > 
> > (And note how the I/G and U/L bits are on the very left, even though
> > when we write out an EUI-48, the I/G bit is 01:00:00:00:00:00, and
> > the U/L bit is 02:00:00:00:00:00.)
> > 
> > I don't know of any EUI-{48,64} users that transmit the OUI bytes
> > including the I/G bit and the U/L bit as the very last bytes of the
> > address, but this is what you are arguing for, and I'm really not
> > sure why you think it should be like this -- the references you
> > quoted all seem to contradict the conclusion you're drawing from
> > them, in my humble opinion.
> 
> Maybe this helps a little bit to clarifing this [0].
> 
> 8. MAC addresses
> 8.6 Bit-ordering and different MACs
> 
> "Throughout this subclause, considerations relating to the order of bit
> and/or octet transmission refer to the basic bit-serial model of
> transmission that applies to the representation of MAC frames at the
> boundary between the MAC and the PHY."
> 
> "...octet transmission that applies to the representation of MAC frames..."
> which is little endian.

I see nothing in this document that supports this conclusion -- from
where do you draw the conclusion "which is little endian"?

But, I think the whole big versus little endian argument is actually
clouding the issue at this point.  Let's look at this another way and
ask the question differently -- should the EUI-64 octet containing
the U/L and I/G bits, which is one of the octets of the OUI, be the
first octet to be transmitted in address fields in packet headers, or
the last octet to be transmitted?

The IEEE document you are pointing me at suggests that the byte
containing the U/L and I/G bits should be the first octet to be
transmitted, and this is consistent with every other 802 standard
that I am aware of -- it's true for wired ethernet (802.3),
wireless (802.11), etc.

Yet the Linux 802.15.4 stack transmits this octet as the last octet
in address fields -- and to me it seems that this is wrong.


> Also I note that several documents [0] and [1] talks about, what Phoebe
> already said: EUI-64 is a number representation and each payload in PSDU
> should send in little endian byte order.

As I said above, I think the big versus little endian argument is just
distracting from the discussion, and there is nothing in [0] mentioning
endianity either -- there is this remark in [1] in the section you
indicated:

	All multiple octet fields are transmitted and received with the
	least significant octet first, also referred to as “little endian.”

But this is entirely consistent with putting the U/L/I/G byte as the
first byte in the packet, as IEEE 802 specs consider the leftmost byte
to be the least significant byte.

There's also this remark:

	Note that EUI64 fields are treated as a 64-bit number and are
	therefore transmitted and received in little endian order.

If this means that these parts expect the OUI to be at the end of
the address field in the packet instead of at the beginning (I'm not
entirely sure whether this is what this document is saying from this
wording), then I definitely don't agree with that interpretation of
the EUI and 802 and 802.15.4 specifications.


> That the PSDU should send in little endian is specified in section:
> 10.2.3 Bit-to-symbol mapping
> 
> "Each octet of the PPDU is processed through the modulation and spreading
> functions, as illustrated in Figure 69, sequentially, beginning with the
> Preamble field and ending with the last octet of the PSDU. Within each octet,
> the least significant symbol (b0,b1,b2,b3) is processed first and the most
> significant symbol (b4,b5,b6,b7) is processed second."

This is about bit ordering, not byte ordering -- and it's consistent
with what I have been saying before -- it explains why the I/G bit
is transmitted first, even though it is the 0x01 bit in the first
address byte.


> [0] http://standards.ieee.org/getieee802/download/802-2014.pdf
> [1] http://www.silabs.com/Support%20Documents/TechnicalDocs/UG100.pdf (Section 2.1)
> [2] http://datasheet.octopart.com/SN260QT-STMicroelectronics-datasheet-516599.pdf (Section 7.1)
