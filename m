Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50890 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbbE2Ixo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:53:44 -0400
Message-ID: <55682914.6060109@xsilon.com>
Date: Fri, 29 May 2015 09:53:40 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
References: <20150528140934.GG11340@wantstofly.org> <20150528162702.785e1f1c@zoidberg> <20150529041723.GN11340@wantstofly.org> <20150529074419.GA2557@omega> <20150529080821.GO11340@wantstofly.org> <20150529083145.GA3709@omega>
In-Reply-To: <20150529083145.GA3709@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

I noticed the 802.15.4 spec has test vectors for the crypto that show 
the byte order of the address.
See 802.15.4-2011 spec [1]
Annex C, Section C.2.1.1

source address 0xacde480000000001 is represented in a packet as.
08 D0 84 21 43 01 00 00 00 00 48 DE AC || 02 05 00 00 00 || 55 CF 00 00 
51 52 53 54 22 3B C1 EC 84 1A
B5 53.

- Simon
[1] - https://standards.ieee.org/getieee802/download/802.15.4-2011.pdf

On 29/05/15 09:31, Alexander Aring wrote:
> On Fri, May 29, 2015 at 11:08:21AM +0300, Lennert Buytenhek wrote:
> ...
>>> That the PSDU should send in little endian is specified in section:
>>> 10.2.3 Bit-to-symbol mapping
>>>
>>> "Each octet of the PPDU is processed through the modulation and spreading
>>> functions, as illustrated in Figure 69, sequentially, beginning with the
>>> Preamble field and ending with the last octet of the PSDU. Within each octet,
>>> the least significant symbol (b0,b1,b2,b3) is processed first and the most
>>> significant symbol (b4,b5,b6,b7) is processed second."
>> This is about bit ordering, not byte ordering -- and it's consistent
>> with what I have been saying before -- it explains why the I/G bit
>> is transmitted first, even though it is the 0x01 bit in the first
>> address byte.
>>
> I need to lookup more information about this.
>
> I know this not an argument, but let us think about if we change the byte
> order there. This means that SAM/DAM decompression/compression BIT 11 is wrong [0].
> (The remaining 64 bits are computed from the encapsulating header (e.g.,
> 802.15.4 or IPv6 source address)...)
>
> That also means that wireshark, contiki, etc. will all do currently the wrong
> byte ordering at L2. I currently can't believe that and we should really
> clarifying this issue before we change this. Otherwise we are
> incompatible with the whole 802.15.4 IoT used software outside.
>
> - Alex
>
> [0] https://tools.ietf.org/html/rfc6282#section-3.1.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

